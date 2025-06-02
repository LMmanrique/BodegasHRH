package Controlador;

import Configuraciones.conexion;
import Modelo.DetalleMovimiento;
import Modelo.Ingreso;
import Modelo.Vencimiento;
import ModeloDAO.IngresosDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;


public class IngresosServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Fuerza UTF-8 y JSON
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");

        JSONObject json = new JSONObject();

        // Recogemos tipo y usuario
        String tipo = request.getParameter("tipo");
        String usuarioNombre = request.getParameter("usuario");

        // Conexión y DAO
        try (Connection conn = new conexion().conectar()) {
            // Validaciones generales
            if (tipo == null || tipo.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                json.put("success", false).put("message", "No se recibió el tipo de movimiento.");
                writeJson(response, json);
                return;
            }
            if (usuarioNombre == null || usuarioNombre.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                json.put("success", false).put("message", "No se identificó al usuario.");
                writeJson(response, json);
                return;
            }

            // Creamos Ingreso y mapeo común
            Ingreso ingreso = new Ingreso();
            ingreso.setUsuarioId(Integer.parseInt(usuarioNombre)); // TODO: Traducir usuarioNombre → ID real
            // Fecha según tipo
            String fechaParam;
            switch (tipo) {
                case "compra":    fechaParam = request.getParameter("fecha");           break;
                case "traslado":  fechaParam = request.getParameter("fecha_traslado");  break;
                case "cambio":    fechaParam = request.getParameter("fecha_cambio");    break;
                case "devolucion":fechaParam = request.getParameter("fecha_devolucion");break;
                case "donacion":  fechaParam = request.getParameter("fecha_suscripcion");break;
                default: fechaParam = null;
            }
            if (fechaParam == null || fechaParam.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                json.put("success", false).put("message", "La fecha es obligatoria para " + tipo + ".");
                writeJson(response, json);
                return;
            }
            ingreso.setFecha(Date.valueOf(fechaParam));

            // Documento genérico
            String doc = request.getParameter("nofactura");
            if (doc == null || doc.isEmpty()) {
                doc = request.getParameter("num_documento");
            }
            ingreso.setDocumento(doc != null ? doc.trim() : "");

            // Detalle de insumos
            String[] ids     = request.getParameterValues("detalle_existencia_id[]");
            String[] cants   = request.getParameterValues("detalle_cantidad[]");
            String[] precios = request.getParameterValues("detalle_precio_unitario[]");
            String[] fechas  = request.getParameterValues("detalle_fecha_vencimiento[]");
            String[] lotes   = request.getParameterValues("detalle_lote[]");

            if (ids == null || ids.length == 0) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                json.put("success", false).put("message", "Debe agregar al menos un insumo.");
                writeJson(response, json);
                return;
            }
            List<DetalleMovimiento> detalles = new ArrayList<>();
            for (int i = 0; i < ids.length; i++) {
                DetalleMovimiento d = new DetalleMovimiento();
                // 1) Parseo de existencia, cantidad y precio
                try {
                    d.setExistenciaId(Integer.parseInt(ids[i]));
                    d.setCantidad(new BigDecimal(cants[i].trim()));
                    d.setPrecioUnitario(new BigDecimal(precios[i].trim()));
                } catch (NumberFormatException ex) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    json.put("success", false)
                        .put("message", "Cantidad o precio inválido en fila " + (i + 1) + ".");
                    writeJson(response, json);
                    return;
                }

                // 2) Validación conjunta de Fecha de Vencimiento y Lote
                String fechaStr = fechas[i];
                String loteStr  = lotes[i];
                boolean noAplicaFecha = "No Aplica".equals(fechaStr);
                boolean noAplicaLote  = "No Aplica".equals(loteStr);
                boolean fechaValida   = fechaStr != null
                                        && !fechaStr.trim().isEmpty()
                                        && !noAplicaFecha;
                boolean loteValido    = loteStr  != null
                                        && !loteStr.trim().isEmpty()
                                        && !noAplicaLote;

                // Sólo aceptamos: ambos “No Aplica” O ambos con datos válidos
                if (!( (noAplicaFecha && noAplicaLote) 
                    || (fechaValida   && loteValido) )) {
                    bad("Debe completar Fecha de Vencimiento y Lote, o marcar ambos como “No Aplica”",
                        response, json);
                    return;
                }

                // 3) Montar el objeto Vencimiento
                Vencimiento v = new Vencimiento();
                if (fechaValida) {
                    v.setFechaVencimiento(Date.valueOf(fechaStr));
                }
                if (loteValido) {
                    v.setLote(loteStr.trim());
                }
                d.setVencimiento(v);

                // 4) Agregar el detalle a la lista
                detalles.add(d);
            }
            ingreso.setDetalles(detalles);

            // DAO
            IngresosDAO dao = new IngresosDAO();

            // Mapeo específico por tipo
            switch (tipo) {
                case "compra":
                ingreso.setTipoId(1);

                // noSolicitud
                String noSol = request.getParameter("nosolicitud");
                if (noSol == null || noSol.trim().isEmpty()) {
                    bad("Número de Solicitud es obligatorio", response, json);
                    return;
                }
                ingreso.setNoSolicitud(noSol.trim());

                // ordenCompra
                String orden = request.getParameter("orden_compra");
                if (orden == null || orden.trim().isEmpty()) {
                    bad("Orden de Compra es obligatoria", response, json);
                    return;
                }
                ingreso.setOrdenCompra(orden.trim());

                // proveedor
                String prov = request.getParameter("proveedor");
                if (prov == null || prov.trim().isEmpty()) {
                    bad("Proveedor es obligatorio", response, json);
                    return;
                }
                ingreso.setProveedor(prov.trim());

                // serieFactura
                String serie = request.getParameter("seriefactura");
                if (serie == null || serie.trim().isEmpty()) {
                    bad("Serie de factura es obligatoria", response, json);
                    return;
                }
                ingreso.setSerieFactura(serie.trim());

                // numeroFactura
                String numFac = request.getParameter("nofactura");
                if (numFac == null || numFac.trim().isEmpty()) {
                    bad("Número de factura es obligatorio", response, json);
                    return;
                }
                ingreso.setNumeroFactura(numFac.trim());

                // nitProveedor
                String nit = request.getParameter("nit_proveedor");
                if (nit == null || nit.trim().isEmpty()) {
                    bad("NIT del proveedor es obligatorio", response, json);
                    return;
                }
                ingreso.setNitProveedor(nit.trim());

                // observacionesCompra
                String obs = request.getParameter("observaciones_compra");
                ingreso.setObservacionesCompra(obs.trim());

                // finalmente, insertar
                dao.insertarCompra(ingreso);
                break;


                case "traslado":
                ingreso.setTipoId(2);

                // unidad_solicitante
                String uniSol = request.getParameter("unidad_solicitante");
                if (uniSol == null || uniSol.trim().isEmpty()) {
                    bad("Unidad solicitante es obligatoria", response, json);
                    return;
                }
                ingreso.setUnidadSolicitante(uniSol.trim());

                // unidad_otorga
                String uniOtg = request.getParameter("unidad_otorga");
                if (uniOtg == null || uniOtg.trim().isEmpty()) {
                    bad("Unidad que otorga es obligatoria", response, json);
                    return;
                }
                ingreso.setUnidadOtorga(uniOtg.trim());

                // tipo_movimiento
                String tipoMov = request.getParameter("tipo_movimiento");
                if (tipoMov == null || tipoMov.trim().isEmpty()) {
                    bad("Tipo de movimiento es obligatorio", response, json);
                    return;
                }
                ingreso.setTipoMovimiento(tipoMov.trim());

                // observaciones
                String obsTras = request.getParameter("observaciones");
                if (obsTras == null || obsTras.trim().isEmpty()) {
                    bad("Observaciones de traslado son obligatorias", response, json);
                    return;
                }
                ingreso.setObservacionesTraslado(obsTras.trim());

                // Inserción
                dao.insertarTraslado(ingreso);
                break;

                case "cambio":
                ingreso.setTipoId(4);

                // proveedor_cambio
                String provCambio = request.getParameter("proveedor_cambio");
                if (provCambio == null || provCambio.trim().isEmpty()) {
                    bad("Proveedor de cambio es obligatorio", response, json);
                    return;
                }
                ingreso.setProveedorCambio(provCambio.trim());

                // observaciones_cambio
                String obsCambio = request.getParameter("observaciones_cambio");
               
                ingreso.setObservacionesCambio(obsCambio.trim());

                dao.insertarCambioVencimiento(ingreso);
                break;

                case "devolucion":
                ingreso.setTipoId(5);

                // servicio_devuelve
                String servDev = request.getParameter("servicio_devuelve");
                if (servDev == null || servDev.trim().isEmpty()) {
                    bad("Servicio que devuelve es obligatorio", response, json);
                    return;
                }
                ingreso.setServicioDevuelve(servDev.trim());

                // observaciones_devolucion
                String obsDev = request.getParameter("observaciones_devolucion");
                
                ingreso.setObservacionesDevolucion(obsDev.trim());

                dao.insertarDevolucion(ingreso);
                break;

                case "donacion":
                    ingreso.setTipoId(3);
                    // A. Donante
                    ingreso.setProcedencia(request.getParameter("procedencia"));
                    ingreso.setDonante(request.getParameter("donante"));
                    ingreso.setSocioImplementador(request.getParameter("socio_implementador"));
                    ingreso.setPaisProcedencia(request.getParameter("pais_procedencia"));
                    ingreso.setCodigoIdentificacion(request.getParameter("codigo_identificacion"));
                    ingreso.setNumeroIdentificacionTributaria(
                        request.getParameter("numero_identificacion_tributaria"));
                    ingreso.setReferenciaDonante(request.getParameter("referencia_donante"));
                    ingreso.setDireccionDonante(request.getParameter("direccion_donante"));
                    // B. Donación
                    ingreso.setNombreProyecto(request.getParameter("nombre_proyecto"));
                    ingreso.setDocSoporte(request.getParameter("doc_soporte"));
                    String fs = request.getParameter("fecha_suscripcion");
                    if (fs!=null && !fs.isEmpty()) 
                        ingreso.setFechaSuscripcion(Date.valueOf(fs));
                    ingreso.setFinalidadCooperacion(request.getParameter("finalidad"));
                    String mo = request.getParameter("monto_original");
                    if (mo!=null && !mo.isEmpty()) 
                        ingreso.setMontoOriginal(new BigDecimal(mo));
                    ingreso.setTipoDonacion(request.getParameter("tipo_donacion"));
                    ingreso.setTipoMoneda(request.getParameter("tipo_moneda"));
                    String mt = request.getParameter("monto_total_original");
                    if (mt!=null && !mt.isEmpty()) 
                        ingreso.setMontoTotalOriginal(new BigDecimal(mt));
                    ingreso.setComentariosGenerales(request.getParameter("comentarios_generales"));
                    // C. Entidad
                    ingreso.setEntidadEjecutora(request.getParameter("entidad_ejecutora"));
                    ingreso.setUnidadEjecutora(request.getParameter("unidad_ejecutora"));
                    ingreso.setUnidadBeneficiaria(request.getParameter("unidad_beneficiaria"));
                    ingreso.setRepresentanteResponsable(
                        request.getParameter("representante_responsable"));
                    ingreso.setDireccionNotificaciones(
                        request.getParameter("direccion_notificaciones"));
                    ingreso.setFechaFirma(request.getParameter("fecha_firma"));
                    dao.insertarDonacion(ingreso);
                    break;

                default:
                    throw new ServletException("Tipo no soportado: " + tipo);
            }

            // Éxito
            json.put("success", true)
                .put("message", "Ingreso procesado con éxito.");
            response.setStatus(HttpServletResponse.SC_OK);

        } catch (SQLException ex) {
            log("Error BD en IngresosServlet", ex);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            json.put("success", false)
                .put("message", "Error de base de datos: " + ex.getMessage());
        } catch (ServletException | IOException ex) {
            // ya venía con código y mensaje adecuados
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            json.put("success", false)
                .put("message", ex.getMessage());
        } catch (Exception ex) {
            log("Error interno en IngresosServlet", ex);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            json.put("success", false)
                .put("message", "Error interno: " + ex.getMessage());
        }

        // Responder JSON
        writeJson(response, json);
    }

    private void bad(String msg, HttpServletResponse response, JSONObject json)
            throws IOException {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        json.put("success", false).put("message", msg);
        writeJson(response, json);
    }

    private void writeJson(HttpServletResponse response, JSONObject json)
            throws IOException {
        try (PrintWriter out = response.getWriter()) {
            out.print(json.toString());
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("anular".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            try {
                IngresosDAO dao = new IngresosDAO();
                dao.anularMovimiento(id);
                response.sendRedirect("ingresos.jsp?msg=anulado");
            } catch (Exception e) {
                throw new ServletException("Error anulando movimiento: " + e.getMessage(), e);
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}