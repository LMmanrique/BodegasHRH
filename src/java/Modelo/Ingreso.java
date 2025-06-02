package Modelo;

import java.math.BigDecimal;
import java.sql.Time;
import java.util.Date;
import java.util.List;

public class Ingreso {
    // Campos comunes (movimientos)
    private int id;
    private int tipoId;
    private int usuarioId;
    private Date fecha;
    private Time hora;
    private String documento;
    private String nitProveedor;
    private String observaciones;
    private boolean anulado;

    // Campos para Compra
    private String noSolicitud;
    private String ordenCompra;
    private String proveedor;
    private String serieFactura;
    private String numeroFactura;
    private String nitProveedorCompra;
    private String observacionesCompra;

    // Campos para Traslado/Cambio/Préstamo
    private String unidadSolicitante;
    private String unidadOtorga;
    private String tipoMovimiento; // Traslado, Cambio, Prestamo
    private String observacionesTraslado;

    // Campos para Cambio por Vencimiento
    private String proveedorCambio;
    private String observacionesCambio;

    // Campos para Devolución
    private String servicioDevuelve;
    private String observacionesDevolucion;

    // Campos para Donación
    private String procedencia;
    private String donante;
    private String socioImplementador;
    private String paisProcedencia;
    private String codigoIdentificacion;
    private String numeroIdentificacionTributaria;
    private String referenciaDonante;
    private String direccionDonante;
    private String nombreProyecto;
    private String docSoporte;
    private Date fechaSuscripcion;
    private String finalidadCooperacion;
    private BigDecimal montoOriginal;
    private String tipoDonacion;
    private String tipoMoneda;
    private BigDecimal montoTotalOriginal;
    private String comentariosGenerales;
    private String entidadEjecutora;
    private String unidadEjecutora;
    private String unidadBeneficiaria;
    private String representanteResponsable;
    private String direccionNotificaciones;
    private String fechaFirma;

    // Detalles de movimiento
    private List<DetalleMovimiento> detalles;

    // Getters y Setters

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getTipoId() { return tipoId; }
    public void setTipoId(int tipoId) { this.tipoId = tipoId; }

    public int getUsuarioId() { return usuarioId; }
    public void setUsuarioId(int usuarioId) { this.usuarioId = usuarioId; }

    public Date getFecha() { return fecha; }
    public void setFecha(Date fecha) { this.fecha = fecha; }

    public Time getHora() { return hora; }
    public void setHora(Time hora) { this.hora = hora; }

    public String getDocumento() { return documento; }
    public void setDocumento(String documento) { this.documento = documento; }

    public String getNitProveedor() { return nitProveedor; }
    public void setNitProveedor(String nitProveedor) { this.nitProveedor = nitProveedor; }

    public String getObservaciones() { return observaciones; }
    public void setObservaciones(String observaciones) { this.observaciones = observaciones; }

    public boolean isAnulado() { return anulado; }
    public void setAnulado(boolean anulado) { this.anulado = anulado; }

    public String getNoSolicitud() { return noSolicitud; }
    public void setNoSolicitud(String noSolicitud) { this.noSolicitud = noSolicitud; }

    public String getOrdenCompra() { return ordenCompra; }
    public void setOrdenCompra(String ordenCompra) { this.ordenCompra = ordenCompra; }

    public String getProveedor() { return proveedor; }
    public void setProveedor(String proveedor) { this.proveedor = proveedor; }

    public String getSerieFactura() { return serieFactura; }
    public void setSerieFactura(String serieFactura) { this.serieFactura = serieFactura; }

    public String getNumeroFactura() { return numeroFactura; }
    public void setNumeroFactura(String numeroFactura) { this.numeroFactura = numeroFactura; }

    public String getNitProveedorCompra() { return nitProveedorCompra; }
    public void setNitProveedorCompra(String nitProveedorCompra) { this.nitProveedorCompra = nitProveedorCompra; }

    public String getObservacionesCompra() { return observacionesCompra; }
    public void setObservacionesCompra(String observacionesCompra) { this.observacionesCompra = observacionesCompra; }

    public String getUnidadSolicitante() { return unidadSolicitante; }
    public void setUnidadSolicitante(String unidadSolicitante) { this.unidadSolicitante = unidadSolicitante; }

    public String getUnidadOtorga() { return unidadOtorga; }
    public void setUnidadOtorga(String unidadOtorga) { this.unidadOtorga = unidadOtorga; }

    public String getTipoMovimiento() { return tipoMovimiento; }
    public void setTipoMovimiento(String tipoMovimiento) { this.tipoMovimiento = tipoMovimiento; }

    public String getObservacionesTraslado() { return observacionesTraslado; }
    public void setObservacionesTraslado(String observacionesTraslado) { this.observacionesTraslado = observacionesTraslado; }

    public String getProveedorCambio() { return proveedorCambio; }
    public void setProveedorCambio(String proveedorCambio) { this.proveedorCambio = proveedorCambio; }

    public String getObservacionesCambio() { return observacionesCambio; }
    public void setObservacionesCambio(String observacionesCambio) { this.observacionesCambio = observacionesCambio; }

    public String getServicioDevuelve() { return servicioDevuelve; }
    public void setServicioDevuelve(String servicioDevuelve) { this.servicioDevuelve = servicioDevuelve; }

    public String getObservacionesDevolucion() { return observacionesDevolucion; }
    public void setObservacionesDevolucion(String observacionesDevolucion) { this.observacionesDevolucion = observacionesDevolucion; }

    public String getProcedencia() { return procedencia; }
    public void setProcedencia(String procedencia) { this.procedencia = procedencia; }

    public String getDonante() { return donante; }
    public void setDonante(String donante) { this.donante = donante; }

    public String getSocioImplementador() { return socioImplementador; }
    public void setSocioImplementador(String socioImplementador) { this.socioImplementador = socioImplementador; }

    public String getPaisProcedencia() { return paisProcedencia; }
    public void setPaisProcedencia(String paisProcedencia) { this.paisProcedencia = paisProcedencia; }

    public String getCodigoIdentificacion() { return codigoIdentificacion; }
    public void setCodigoIdentificacion(String codigoIdentificacion) { this.codigoIdentificacion = codigoIdentificacion; }

    public String getNumeroIdentificacionTributaria() { return numeroIdentificacionTributaria; }
    public void setNumeroIdentificacionTributaria(String numeroIdentificacionTributaria) { this.numeroIdentificacionTributaria = numeroIdentificacionTributaria; }

    public String getReferenciaDonante() { return referenciaDonante; }
    public void setReferenciaDonante(String referenciaDonante) { this.referenciaDonante = referenciaDonante; }

    public String getDireccionDonante() { return direccionDonante; }
    public void setDireccionDonante(String direccionDonante) { this.direccionDonante = direccionDonante; }

    public String getNombreProyecto() { return nombreProyecto; }
    public void setNombreProyecto(String nombreProyecto) { this.nombreProyecto = nombreProyecto; }

    public String getDocSoporte() { return docSoporte; }
    public void setDocSoporte(String docSoporte) { this.docSoporte = docSoporte; }

    public Date getFechaSuscripcion() { return fechaSuscripcion; }
    public void setFechaSuscripcion(Date fechaSuscripcion) { this.fechaSuscripcion = fechaSuscripcion; }

    public String getFinalidadCooperacion() { return finalidadCooperacion; }
    public void setFinalidadCooperacion(String finalidadCooperacion) { this.finalidadCooperacion = finalidadCooperacion; }

    public BigDecimal getMontoOriginal() { return montoOriginal; }
    public void setMontoOriginal(BigDecimal montoOriginal) { this.montoOriginal = montoOriginal; }

    public String getTipoDonacion() { return tipoDonacion; }
    public void setTipoDonacion(String tipoDonacion) { this.tipoDonacion = tipoDonacion; }

    public String getTipoMoneda() { return tipoMoneda; }
    public void setTipoMoneda(String tipoMoneda) { this.tipoMoneda = tipoMoneda; }

    public BigDecimal getMontoTotalOriginal() { return montoTotalOriginal; }
    public void setMontoTotalOriginal(BigDecimal montoTotalOriginal) { this.montoTotalOriginal = montoTotalOriginal; }

    public String getComentariosGenerales() { return comentariosGenerales; }
    public void setComentariosGenerales(String comentariosGenerales) { this.comentariosGenerales = comentariosGenerales; }

    public String getEntidadEjecutora() { return entidadEjecutora; }
    public void setEntidadEjecutora(String entidadEjecutora) { this.entidadEjecutora = entidadEjecutora; }

    public String getUnidadEjecutora() { return unidadEjecutora; }
    public void setUnidadEjecutora(String unidadEjecutora) { this.unidadEjecutora = unidadEjecutora; }

    public String getUnidadBeneficiaria() { return unidadBeneficiaria; }
    public void setUnidadBeneficiaria(String unidadBeneficiaria) { this.unidadBeneficiaria = unidadBeneficiaria; }

    public String getRepresentanteResponsable() { return representanteResponsable; }
    public void setRepresentanteResponsable(String representanteResponsable) { this.representanteResponsable = representanteResponsable; }

    public String getDireccionNotificaciones() { return direccionNotificaciones; }
    public void setDireccionNotificaciones(String direccionNotificaciones) { this.direccionNotificaciones = direccionNotificaciones; }

    public String getFechaFirma() { return fechaFirma; }
    public void setFechaFirma(String fechaFirma) { this.fechaFirma = fechaFirma; }

    public List<DetalleMovimiento> getDetalles() { return detalles; }
    public void setDetalles(List<DetalleMovimiento> detalles) { this.detalles = detalles; }
}
