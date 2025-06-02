
<%
    // El objeto session ya está disponible en el JSP
    if (session == null || session.getAttribute("usuario") == null) {
        response.sendRedirect("authentication-login.jsp");
        return;
    }
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Almacen General</title>
  <script src="${pageContext.request.contextPath}/assets/js/jquery-3.7.1.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/quagga.min.js"></script>
  <link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/logos/favicon.png" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styles.min.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/sweetAlert2/sweetalert2.min.css">
  <style>
    /* Contenedor: quita el borde por defecto */
    #facturaTabs {
      border-bottom: none;
    }

    /* Todas las tabs: fondo gris suave, texto oscuro, bordes redondeados */
    #facturaTabs .nav-link {
      background-color: #f1f1f1;
      color: #495057;
      border: none;
      border-radius: 50px;      /* <-- píldora completa */
      margin-right: 0.25rem;
      padding: 0.5rem 1.25rem;   /* ajusta el alto/ancho interior */
      transition: background-color 0.2s, color 0.2s;
    }

    /* Hover: aclarar un poco */
    #facturaTabs .nav-link:hover {
      background-color: #e2e6ea;
    }

    /* Active: fondo de énfasis, texto blanco, sombra ligera */
    #facturaTabs .nav-link.active {
      background-color: #343a40;
      color: #fff;
      box-shadow: 0 2px 6px rgba(0,0,0,0.15);
      border-radius: 50px;      /* asegurar que la activa también */
    }

    /* Última tab no necesita margen */
    #facturaTabs .nav-link:last-child {
      margin-right: 0;
    }
    
  </style>
</head>

<body>
  <!--  Body Wrapper -->
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
    data-sidebar-position="fixed" data-header-position="fixed">
  
    <!-- Incluye topstrip y navbar -->
    <jsp:include page="/apptopstrip.jsp" /> 
    <jsp:include page="/navbar.jsp" />
  
    <div class="body-wrapper">
      <div class="body-wrapper-inner">
        <div class="container-fluid">
          <h1 class="mt-4">Egreso de Insumos</h1>
          <br>
          <br>
          <!-- Formulario para ingresar factura -->
          
<form id="formIngresos" action="IngresosServlet" method="post">
    <input type="hidden" name="usuario" value="${usuario.id_usuario}">
    <input type="hidden" name="tipo" id="inputTipo" value="compra">
<!-- Nav tabs -->
<ul class="nav nav-tabs nav-fill mb-3" id="facturaTabs" role="tablist">
  <li class="nav-item" role="presentation">
    <button class="nav-link active" id="compra-tab" data-bs-toggle="tab" data-bs-target="#compra" type="button" role="tab" aria-controls="compra" aria-selected="true">
      Compra
    </button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="traslado-tab" data-bs-toggle="tab" data-bs-target="#traslado" type="button" role="tab" aria-controls="traslado" aria-selected="false">
      Traslado, Cambio o Préstamo
    </button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="cambio-tab" data-bs-toggle="tab" data-bs-target="#cambio" type="button" role="tab" aria-controls="cambio" aria-selected="false">
      Cambio por Vencimiento
    </button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="devolucion-tab" data-bs-toggle="tab" data-bs-target="#devolucion" type="button" role="tab" aria-controls="devolucion" aria-selected="false">
      Devolucion
    </button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="donacion-tab" data-bs-toggle="tab" data-bs-target="#donacion" type="button" role="tab" aria-controls="donacion" aria-selected="false">
      Donación
    </button>
  </li>
</ul>

<!-- Tab content -->
<div class="tab-content" id="facturaTabsContent">
<!-- Tab Compra -->
    <div class="tab-pane fade show active" id="compra" role="tabpanel" aria-labelledby="compra-tab">
      
        <div class="card mb-4 shadow-sm">
          <div class="card-header bg-primary">
            <h5 class="mb-0 text-white d-flex align-items-center gap-2">
              <iconify-icon icon="solar:box-linear"></iconify-icon>
              Compra
            </h5>
          </div>
          <div class="card-body">
            <div class="row">
              <div class="col-md-6 mb-3">
                <label for="nosolicitud" class="form-label">Número de Solicitud <span class="text-danger">*</span></label>
                <input type="text" class="form-control" id="nosolicitud" name="nosolicitud" required>
              </div>
              <div class="col-md-6 mb-3">
                <label for="orden_compra" class="form-label">Orden de Compra <span class="text-danger">*</span></label>
                <input type="text" class="form-control" id="orden_compra" name="orden_compra" required>
              </div>
            </div>
            <div class="row">
              <div class="col-md-6 mb-3">
                <label for="proveedor" class="form-label">Proveedor <span class="text-danger">*</span></label>
                <input type="text" class="form-control" id="proveedor" name="proveedor" required>
              </div>
              <div class="col-md-3 mb-3">
                <label for="seriefactura" class="form-label">Serie Factura <span class="text-danger">*</span></label>
                <input type="text" class="form-control" id="seriefactura" name="seriefactura" required>
              </div>
              <div class="col-md-3 mb-3">
                <label for="nofactura" class="form-label">No. Factura <span class="text-danger">*</span></label>
                <input type="text" class="form-control" id="nofactura" name="nofactura" required>
              </div>
            </div>
            <div class="row">
              <div class="col-md-6 mb-3">
                <label for="fecha" class="form-label">Fecha <span class="text-danger">*</span></label>
                <input type="date" class="form-control" id="fecha" name="fecha" required>
              </div>
              <div class="col-md-6 mb-3">
                <label for="nit_proveedor" class="form-label">Nit del Proveedor <span class="text-danger">*</span></label>
                <input type="text" class="form-control" id="nit_proveedor" name="nit_proveedor" required>
              </div>
            </div>
            <!-- Nueva fila de Observaciones -->
            <div class="row">
              <div class="col-12 mb-3">
                <label for="observaciones_compra" class="form-label">Observaciones</label>
                <textarea class="form-control" id="observaciones_compra" name="observaciones_compra" rows="3" placeholder=""></textarea>
              </div>
            </div>
          </div>
        </div>
      
    </div>


  <!-- Tab Traslado/Préstamo -->
    <div class="tab-pane fade" id="traslado" role="tabpanel" aria-labelledby="traslado-tab">
      
        <div class="card mb-4 shadow-sm">
          <div class="card-header bg-primary">
            <h5 class="mb-0 text-white d-flex align-items-center gap-2">
              <iconify-icon icon="solar:transfer-horizontal-bold" style="color: white;" width="22" height="22"></iconify-icon>
              Traslado, Cambio o Préstamo
            </h5>
          </div>
          <div class="card-body">
            <div class="row">
              <div class="col-md-6 mb-3">
                <label for="fecha_traslado" class="form-label">Fecha <span class="text-danger">*</span></label>
                <input type="date" class="form-control" id="fecha_traslado" name="fecha_traslado" required>
              </div>
              <div class="col-md-6 mb-3">
                <label for="numero_documento" class="form-label">Número de Documento <span class="text-danger">*</span></label>
                <input type="text" class="form-control" id="numero_documento" name="numero_documento" required>
              </div>
            </div>
            <div class="row">
              <div class="col-md-6 mb-3">
                <label for="unidad_solicitante" class="form-label">Unidad Solicitante <span class="text-danger">*</span></label>
                <input type="text" class="form-control" id="unidad_solicitante" name="unidad_solicitante" required>
              </div>
              <div class="col-md-6 mb-3">
                <label for="unidad_otorga" class="form-label">Unidad que Otorga <span class="text-danger">*</span></label>
                <input type="text" class="form-control" id="unidad_otorga" name="unidad_otorga" required>
              </div>
            </div>
            <div class="row">
              <div class="col-md-6 mb-3">
                <label for="tipo_movimiento" class="form-label">Tipo <span class="text-danger">*</span></label>
                <select class="form-select" id="tipo_movimiento" name="tipo_movimiento" required>
                  <option value="">Seleccione...</option>
                  <option value="Traslado">Traslado</option>
                  <option value="Cambio">Cambio</option>
                  <option value="Prestamo">Préstamo</option>
                </select>
              </div>
              <div class="col-md-6 mb-3">
                <label for="observaciones" class="form-label">Observaciones</label>
                <textarea class="form-control" id="observaciones" name="observaciones" rows="3"></textarea>
              </div>
            </div>
          </div>
        </div>
      
    </div>


    <!-- Tab Cambio por Vencimiento -->
    <div class="tab-pane fade" id="cambio" role="tabpanel" aria-labelledby="cambio-tab">
      
        <div class="card mb-4 shadow-sm">
          <div class="card-header bg-primary">
            <h5 class="mb-0 text-white d-flex align-items-center gap-2">
              <iconify-icon icon="solar:cart-cross-bold" style="color: white;" width="22" height="22"></iconify-icon>
              Cambio por Vencimiento
            </h5>
          </div>
          <div class="card-body">
            <div class="row">
              <div class="col-md-6 mb-3">
                <label for="fecha_cambio" class="form-label">Fecha <span class="text-danger">*</span></label>
                <input type="date" class="form-control" id="fecha_cambio" name="fecha_cambio" required>
              </div>
              <div class="col-md-3 mb-3">
                <label for="num_documento" class="form-label">Número de Documento <span class="text-danger">*</span></label>
                <input type="text" class="form-control" id="num_documento" name="num_documento" required>
              </div>
              <div class="col-md-3 mb-3">
                <label for="proveedor_cambio" class="form-label">Proveedor <span class="text-danger">*</span></label>
                <input type="text" class="form-control" id="proveedor_cambio" name="proveedor_cambio" required>
              </div>
            </div>
            <!-- Observaciones -->
            <div class="row">
              <div class="col-12 mb-3">
                <label for="observaciones_cambio" class="form-label">Observaciones</label>
                <textarea class="form-control" id="observaciones_cambio" name="observaciones_cambio" rows="3"></textarea>
              </div>
            </div>
          </div>
        </div>
      
    </div>


<!-- Tab Devolución -->
<div class="tab-pane fade" id="devolucion" role="tabpanel" aria-labelledby="devolucion-tab">
  
    <div class="card mb-4 shadow-sm">
      <div class="card-header bg-primary">
        <h5 class="mb-0 text-white d-flex align-items-center gap-2">
          <iconify-icon icon="solar:minimize-square-bold" style="color: white;" width="22" height="22"></iconify-icon>
          Devolución
        </h5>
      </div>
      <div class="card-body">
        <div class="row">
          <div class="col-md-6 mb-3">
            <label for="fecha_devolucion" class="form-label">Fecha <span class="text-danger">*</span></label>
            <input type="date" class="form-control" id="fecha_devolucion" name="fecha_devolucion" required>
          </div>
          <div class="col-md-3 mb-3">
            <label for="num_devolucion" class="form-label">Número de Documento <span class="text-danger">*</span></label>
            <input type="text" class="form-control" id="num_devolucion" name="num_devolucion" required>
          </div>
          <div class="col-md-3 mb-3">
              <label for="servicio_devuelve" class="form-label">
                Servicio que Devuelve <span class="text-danger">*</span>
              </label>
              <select class="form-select" id="servicio_devuelve" name="servicio_devuelve" required>
                
                <option value="activos fijos e inventario">Activos Fijos e Inventario</option>
                <option value="asesoría jurídica">Asesoría Jurídica</option>
                <option value="banco de leche">Banco de Leche</option>
                <option value="banco de sangre">Banco de Sangre</option>
                <option value="bodega de material médico-quirúrgico">Bodega de Material Médico-Quirúrgico</option>
                <option value="bodega de medicamento">Bodega de Medicamento</option>
                <option value="central de equipos">Central de Equipos</option>
                <option value="centro de recuperación nutricional">Centro de Recuperación Nutricional</option>
                <option value="cirugía de hombres">Cirugía de Hombres</option>
                <option value="cirugía de mujeres">Cirugía de Mujeres</option>
                <option value="clínica de vsvs">Clínica de VSVS</option>
                <option value="cocina">Cocina</option>
                <option value="compras">Compras</option>
                <option value="consulta externa">Consulta Externa</option>
                <option value="contabilidad">Contabilidad</option>
                <option value="costurería">Costurería</option>
                <option value="dirección ejecutiva">Dirección Ejecutiva</option>
                <option value="emergencia general">Emergencia General</option>
                <option value="emergencia materno-neonatal">Emergencia Materno-Neonatal</option>
                <option value="epidemiología">Epidemiología</option>
                <option value="farmacia estatal">Farmacia Estatal</option>
                <option value="farmacia interna">Farmacia Interna</option>
                <option value="gerencia administrativa">Gerencia Administrativa</option>
                <option value="ginecología">Ginecología</option>
                <option value="hemodiálisis">Hemodiálisis</option>
                <option value="infectología">Infectología</option>
                <option value="informática">Informática</option>
                <option value="intendencia">Intendencia</option>
                <option value="labor y partos">Labor y Partos</option>
                <option value="laboratorio">Laboratorio</option>
                <option value="lactario">Lactario</option>
                <option value="lavandería">Lavandería</option>
                <option value="mantenimiento">Mantenimiento</option>
                <option value="maternidad">Maternidad</option>
                <option value="medicina de hombres">Medicina de Hombres</option>
                <option value="medicina de mujeres">Medicina de Mujeres</option>
                <option value="medicina física y fisioterapia">Medicina Física y Fisioterapia</option>
                <option value="neonatología">Neonatología</option>
                <option value="neumología">Neumología</option>
                <option value="nutrición">Nutrición</option>
                <option value="patología">Patología</option>
                <option value="pediatría">Pediatría</option>
                <option value="planificación familiar">Planificación Familiar</option>
                <option value="presupuestos">Presupuestos</option>
                <option value="productos afines">Productos Afines</option>
                <option value="programa canguro">Programa Canguro</option>
                <option value="psicología">Psicología</option>
                <option value="rayos x">Rayos X</option>
                <option value="registros médicos">Registros Médicos</option>
                <option value="resguardo y vigilancia">Resguardo y Vigilancia</option>
                <option value="sala de operaciones general">Sala de Operaciones General</option>
                <option value="sala de operaciones materno-neonatal">Sala de Operaciones Materno-Neonatal</option>
                <option value="subdirección de enfermería">Subdirección de Enfermería</option>
                <option value="subdirección de recursos humanos">Subdirección de Recursos Humanos</option>
                <option value="subdirección médica">Subdirección Médica</option>
                <option value="subdirección técnica">Subdirección Técnica</option>
                <option value="sueldos y salarios">Sueldos y Salarios</option>
                <option value="tesorería">Tesorería</option>
                <option value="trabajo social">Trabajo Social</option>
                <option value="transporte">Transporte</option>
                <option value="unidad de atención integral">Unidad de Atención Integral</option>
                <option value="unidad de cuidados intensivos adultos a">Unidad de Cuidados Intensivos Adultos A</option>
                <option value="unidad de cuidados intensivos adultos b">Unidad de Cuidados Intensivos Adultos B</option>
                <option value="unidad de cuidados intensivos neonatos">Unidad de Cuidados Intensivos Neonatos</option>
                <option value="unidad de cuidados intensivos pediátricos">Unidad de Cuidados Intensivos Pediátricos</option>
                <option value="unidad de información en salud y atención al usuario">
                  Unidad de Información en Salud y Atención al Usuario
                </option>
                <option value="upe">Upe</option>
              </select>
            </div>

        </div>
        <!-- Observaciones -->
        <div class="row">
          <div class="col-12 mb-3">
            <label for="observaciones_devolucion" class="form-label">Observaciones</label>
            <textarea class="form-control" id="observaciones_devolucion" name="observaciones_devolucion" rows="3"></textarea>
          </div>
        </div>
      </div>
    </div>
  
</div>

  
<!-- Tab Donación -->
<div class="tab-pane fade" id="donacion" role="tabpanel" aria-labelledby="donacion-tab">
  
    <div class="card mb-4 shadow-sm">
      <div class="card-header bg-primary">
        <h5 class="mb-0 text-white d-flex align-items-center gap-2">
          <iconify-icon icon="solar:gift-linear" style="color: white;" width="22" height="22"></iconify-icon>
          Donación
        </h5>
      </div>
      <div class="card-body">
        <!-- A. Datos Generales del Donante -->
        <div class="row">
          <div class="col-12 mb-3">
            <h6 class="bg-secondary text-white px-2 py-1">A. Datos Generales del Donante:</h6>
          </div>
        </div>
        <div class="row">
          <div class="col-12 mb-3">
            <label class="form-label">Procedencia de la Donación</label><br>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="procedencia" id="procedencia_interna" value="Interna" checked>
              <label class="form-check-label" for="procedencia_interna">Interna</label>
            </div>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="procedencia" id="procedencia_externa" value="Externa">
              <label class="form-check-label" for="procedencia_externa">Externa</label>
            </div>
          </div>
          <div class="col-md-6 mb-3">
            <label for="donante" class="form-label">Donante</label>
            <input type="text" class="form-control" id="donante" name="donante" value="">
          </div>
          <div class="col-md-6 mb-3">
            <label for="socio_implementador" class="form-label">Socio Implementador</label>
            <input type="text" class="form-control" id="socio_implementador" name="socio_implementador" value="">
          </div>
          <div class="col-md-4 mb-3">
            <label for="pais_procedencia" class="form-label">País de Procedencia</label>
            <input type="text" class="form-control" id="pais_procedencia" name="pais_procedencia" value="">
          </div>
          <div class="col-md-4 mb-3">
            <label for="codigo_identificacion" class="form-label">Código Único de Identificación (DPI / Pasaporte / NA)</label>
            <input type="text" class="form-control" id="codigo_identificacion" name="codigo_identificacion" value="">
          </div>
          <div class="col-md-4 mb-3">
            <label for="numero_identificacion_tributaria" class="form-label">Número de Identificación Tributaria (Cuando Aplique)</label>
            <input type="text" class="form-control" id="numero_identificacion_tributaria" name="numero_identificacion_tributaria" value="">
          </div>
          <div class="col-md-6 mb-3">
            <label for="referencia_donante" class="form-label">Referencia Donante (SIGLAS, Cuando Aplique)</label>
            <input type="text" class="form-control" id="referencia_donante" name="referencia_donante" value="">
          </div>
          <div class="col-md-6 mb-3">
            <label for="direccion_donante" class="form-label">Dirección Donante</label>
            <textarea class="form-control" id="direccion_donante" name="direccion_donante" rows="2"></textarea>
          </div>
        </div>

        <!-- B. Datos de la Donación -->
        <div class="row">
          <div class="col-12 mb-3">
            <h6 class="bg-secondary text-white px-2 py-1">B. Datos de la Donación:</h6>
          </div>
        </div>
        <div class="row">
          <div class="col-md-6 mb-3">
            <label for="nombre_proyecto" class="form-label">Nombre del Proyecto o Propósito de la Donación</label>
            <textarea class="form-control" id="nombre_proyecto" name="nombre_proyecto" rows="2"></textarea>
          </div>
          <div class="col-md-6 mb-3">
            <label class="form-label">Documento de Soporte</label><br>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="doc_soporte" id="doc_convenio_marco" value="Convenio Marco">
              <label class="form-check-label" for="doc_convenio_marco">Convenio Marco</label>
            </div>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="doc_soporte" id="doc_convenio_especifico" value="Convenio Específico">
              <label class="form-check-label" for="doc_convenio_especifico">Convenio Específico</label>
            </div>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="doc_soporte" id="doc_formulario_anexo" value="Formulario Anexo 1" checked>
              <label class="form-check-label" for="doc_formulario_anexo">Formulario Anexo 1</label>
            </div>
          </div>
          <div class="col-md-6 mb-3">
            <label for="fecha_suscripcion" class="form-label">Fecha de Suscripción de la Donación (Cuando Aplique)</label>
            <input type="date" class="form-control" id="fecha_suscripcion" name="fecha_suscripcion" value="">
          </div>
          <div class="col-md-6 mb-3">
            <label class="form-label">Finalidad de la Cooperación</label><br>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="finalidad" id="finalidad_funcionamiento" value="Funcionamiento" checked>
              <label class="form-check-label" for="finalidad_funcionamiento">Funcionamiento</label>
            </div>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="finalidad" id="finalidad_inversion" value="Inversión">
              <label class="form-check-label" for="finalidad_inversion">Inversión</label>
            </div>
          </div>
          <div class="col-md-6 mb-3">
            <label for="monto_original" class="form-label">Monto en Moneda Original (Funcionamiento / Inversión)</label>
            <div class="input-group">
              <span class="input-group-text">Q</span>
              <input type="number" step="0.01" class="form-control" id="monto_original" name="monto_original" value="">
            </div>
          </div>
            <div class="col-md-6 mb-3">
              <label class="form-label">Tipo de la Donación</label><br>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="tipo_donacion" id="tipo_efectivo" value="Efectivo">
                <label class="form-check-label" for="tipo_efectivo">Efectivo</label>
              </div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="tipo_donacion" id="tipo_especie" value="Especie" checked>
                <label class="form-check-label" for="tipo_especie">Especie</label>
              </div>
            </div>
          <div class="col-md-6 mb-3">
            <label for="tipo_moneda" class="form-label">Tipo de Moneda</label>
            <select class="form-select" id="tipo_moneda" name="tipo_moneda">
              <option value="Dólares">Dólares</option>
              <option value="Quetzales" selected>Quetzales</option>
            </select>
          </div>
          <div class="col-md-6 mb-3">
            <label for="monto_total_original" class="form-label">Monto Total de la Donación en Moneda Original</label>
            <div class="input-group">
              <span class="input-group-text">Q</span>
              <input type="number" step="0.01" class="form-control" id="monto_total_original" name="monto_total_original" value="">
            </div>
          </div>
          <div class="col-md-6 mb-3">
            <label for="comentarios_generales" class="form-label">Comentarios Generales (Cuando Aplique)</label>
            <textarea class="form-control" id="comentarios_generales" name="comentarios_generales" rows="2"></textarea>
          </div>
        </div>

        <!-- C. Información de la Entidad -->
        <div class="row">
          <div class="col-12 mb-3">
            <h6 class="bg-secondary text-white px-2 py-1">C. Información de la Entidad:</h6>
          </div>
        </div>
        <div class="row">
          <div class="col-md-6 mb-3">
            <label for="entidad_ejecutora" class="form-label">Entidad Ejecutora</label>
            <input type="text" class="form-control" id="entidad_ejecutora" name="entidad_ejecutora"
                   value="MINISTERIO DE SALUD PÚBLICA Y ASISTENCIA SOCIAL">
          </div>
          <div class="col-md-6 mb-3">
            <label for="unidad_ejecutora" class="form-label">Unidad Ejecutora</label>
            <input type="text" class="form-control" id="unidad_ejecutora" name="unidad_ejecutora"
                   value='UE 250. HOSPITAL REGIONAL DE HUEHUETENANGO "DR. JORGE VIDES MOLINA"'>
          </div>
          <div class="col-md-6 mb-3">
            <label for="unidad_beneficiaria" class="form-label">Unidad Beneficiaria (Depto. Unidad, Sección)</label>
            <input type="text" class="form-control" id="unidad_beneficiaria" name="unidad_beneficiaria"
                   value="">
          </div>
          <div class="col-md-6 mb-3">
            <label for="representante_responsable" class="form-label">Nombre(s) y cargo(s) del Representante/Responsable</label>
            <textarea class="form-control" id="representante_responsable" name="representante_responsable" rows="2">Dr. Jorge Vinicio Martínez Castillo
Director</textarea>
          </div>
          <div class="col-md-6 mb-3">
            <label for="direccion_notificaciones" class="form-label">Dirección para Notificaciones</label>
            <input type="text" class="form-control" id="direccion_notificaciones" name="direccion_notificaciones"
                   value="Aldea Las Lagunas, Zona 10, Huehuetenango">
          </div>
          <div class="col-md-6 mb-3">
            <label for="fecha_firma" class="form-label">Fecha de firma del presente documento</label>
            <input type="text" class="form-control" id="fecha_firma" name="fecha_firma"
                   value="">
          </div>
        </div>

      </div>
    </div>
  
</div>


</div>
  
            <!-- Detalle de Insumos -->
            <div class="card mb-4">
            <div class="card-header bg-primary">
              <h5 class="mb-0 text-white d-flex align-items-center gap-2">
                <iconify-icon icon="solar:delivery-linear" style="color: white;" width="22" height="22"></iconify-icon>
                Detalle de Insumos
              </h5>
            </div>
                <div class="card-body">
                  <div class="d-flex gap-3 mb-3">
                    <!-- Botón para agregar manualmente -->
                    <button  type="button" class="btn btn-success d-flex align-items-center gap-2" data-bs-toggle="modal" data-bs-target="#consultarInsumosModal">
                      <iconify-icon icon="solar:clipboard-add-linear" width="20" height="20"></iconify-icon>
                      Agregar Insumo
                    </button>

                    <!-- Campo para escanear código de barras -->
                    <input type="text" id="codbarras" class="form-control w-auto" placeholder="Código" autocomplete="off">
                  </div>

                  <table id="detalleTable" class="table table-bordered">
                    <thead>
                      <tr>
                        <th>ID</th>
                        <th>Insumo</th>
                        <th>Características</th>
                        <th>Cantidad</th>
                        <th>Fecha de Vencimiento</th>
                        <th>Lote</th>
                        <th>Precio Unitario</th>
                        <th>Total</th>
                        <th>Acciones</th>
                      </tr>
                    </thead>
                    <tbody>
                      <!-- Se agregan aquí las filas -->
                    </tbody>
                  </table>
                  <div class="d-flex justify-content-end mt-2">
                    <h5>Total General: Q<span id="totalGeneral">0.00</span></h5>
                  </div>
                </div>
            </div>
            <button id="btnGuardarDatos" type="button" class="btn btn-primary">
              <iconify-icon icon="solar:document-add-bold" width="32" height="32"></iconify-icon>
              Guardar
            </button>
            </form>          
        </div>
      </div>
    </div>
</div>
    

    
    
    <div class="modal fade" id="consultarInsumosModal" tabindex="-1" aria-labelledby="consultarExistenciaModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: auto; max-width: 80%;">
    <div class="modal-content">
      <!-- Modal Header con botón de cierre -->
      <div class="modal-header">
        <h1 class="modal-title" id="consultarExistenciaModalLabel">Listado de Existencias</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
      </div>
      <!-- Modal Body -->
      <div class="modal-body">
        <!-- Formulario de Filtros -->
        <form id="filterForm" class="row g-3 mb-4" method="get" action="${pageContext.request.contextPath}/ExistenciaServlet">
          <input type="hidden" name="accion" value="buscarmodal">
          <div class="col-md-2">
            <label for="renglon" class="form-label">Renglón</label>
            <input type="text" class="form-control" id="renglon" name="renglon" placeholder="Renglón">
          </div>
          <div class="col-md-2">
            <label for="codinsumo" class="form-label">Código Insumo</label>
            <input type="text" class="form-control" id="codinsumo" name="codinsumo" placeholder="Código">
          </div>
          <div class="col-md-2">
            <label for="nombre" class="form-label">Nombre</label>
            <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Nombre">
          </div>
          <div class="col-md-2">
            <label for="caracteristicas" class="form-label">Características</label>
            <input type="text" class="form-control" id="caracteristicas" name="caracteristicas" placeholder="Características">
          </div>
          <div class="col-md-2">
            <label for="npresentacion" class="form-label">Nombre Presentación</label>
            <input type="text" class="form-control" id="npresentacion" name="npresentacion" placeholder="Nombre Presentación">
          </div>
          <div class="col-md-2">
            <label for="mpresentacion" class="form-label">Medida Presentación</label>
            <input type="text" class="form-control" id="mpresentacion" name="mpresentacion" placeholder="Medida Presentación">
          </div>
          <div class="col-md-2">
            <label for="codpresentacion" class="form-label">Código Presentación</label>
            <input type="text" class="form-control" id="codpresentacion" name="codpresentacion" placeholder="Código">
          </div>
          <div class="col-12 d-flex gap-2">
            <button type="submit" class="btn btn-primary btn-sm flex-fill">
              <div class="d-flex flex-column align-items-center">
                <iconify-icon icon="solar:filter-linear" width="24" height="24" class="mb-1"></iconify-icon>
                <span>Filtrar</span>
              </div>
            </button>
            <button type="button" id="clearBtn" class="btn btn-secondary btn-sm flex-fill">
              <div class="d-flex flex-column align-items-center">
                <iconify-icon icon="solar:magic-stick-3-linear" width="24" height="24" class="mb-1"></iconify-icon>
                <span>Limpiar Campos</span>
              </div>
            </button>
          </div>
        </form>

        <!-- Tabla de Existencias -->
        <div id="tablaExistenciasContainer" class="table-responsive">
          <table class="table table-striped table-bordered">
            <thead class="table-dark">
              <tr>
                <th style="display:none;">ID</th>
                <th>Renglón</th>
                <th>Código Insumo</th>
                <th>Nombre</th>
                <th>Características</th>
                <th>Nombre Presentación</th>
                <th>Medida Presentación</th>
                <th>Código Barras</th>
                <th>Acciones</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="existencia" items="${listaExistencias}">
                <tr>
                  <td style="display:none;">${existencia.id}</td>
                  <td>${existencia.renglon}</td>
                  <td>${existencia.codinsumo}</td>
                  <td>${existencia.nombre}</td>
                  <td>${existencia.caracteristicas}</td>
                  <td>${existencia.npresentacion}</td>
                  <td>${existencia.mpresentacion}</td>
                  <td>${existencia.codbarras}</td>
                  <td>
                    <button type="button" class="btn btn-success btn-sm flex-fill text-white agregarExistenciaBtn"
                            data-id="${existencia.id}"
                            data-renglon="${existencia.renglon}"
                            data-codinsumo="${existencia.codinsumo}"
                            data-nombre="${existencia.nombre}"
                            data-caracteristicas="${existencia.caracteristicas}"
                            data-npresentacion="${existencia.npresentacion}"
                            data-mpresentacion="${existencia.mpresentacion}"
                            data-codbarras="${existencia.codbarras}">
                      <div class="d-flex flex-column align-items-center">
                        <iconify-icon icon="solar:clipboard-add-linear" width="24" height="24" class="mb-1"></iconify-icon>
                        <span>Agregar</span>
                      </div>
                    </button>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
        <c:if test="${empty listaExistencias}">
          <p class="text-center mt-3">No hay registros para mostrar.</p>
        </c:if>
      </div>
      <!-- Se elimina el modal-footer -->
    </div>
  </div>
</div>


  
  <script src="${pageContext.request.contextPath}/assets/libs/jquery/dist/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/sidebarmenu.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/app.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/libs/apexcharts/dist/apexcharts.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/libs/simplebar/dist/simplebar.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/dashboard.js"></script>
  <!-- solar icons -->
  <script src="${pageContext.request.contextPath}/assets/js/iconify-icon.min"></script>
  <script src="${pageContext.request.contextPath}/assets/sweetAlert2/sweetalert2.all.min.js"></script>
  
  <script>
    $(document).ready(function() {
    // Intercepta el envío del formulario de filtros
    $("#filterForm").submit(function(e) {
      e.preventDefault(); // Evita el envío tradicional del formulario

      $.ajax({
        url: $(this).attr("action"), // URL definida en el atributo action del formulario
        type: $(this).attr("method"), // Método definido en el formulario (GET o POST)
        data: $(this).serialize(), // Serializa todos los campos del formulario
        success: function(response) {
          // Actualiza el contenedor de la tabla con la respuesta HTML del servlet
          $("#tablaExistenciasContainer").html(response);
        },
        error: function(xhr, status, error) {
          console.error("Error en la búsqueda: ", error);
        }
      });
    });

    // Botón para limpiar los campos
    $("#clearBtn").click(function() {
      $("#filterForm")[0].reset();
    });
  });
  
  // Cada vez que haces click en ?Agregar? dentro del modal:
$('#tablaExistenciasContainer').on('click', '.agregarExistenciaBtn', function() {
  var barcode = $(this).data('codbarras');
  var input = document.getElementById('codbarras');

  // 1) Rellenar y enfocar
  input.value = barcode;
  input.focus();

  // 2) Simular Enter con eventos nativos
  ['keydown','keypress','keyup'].forEach(function(type) {
    var ev = new KeyboardEvent(type, {
      key: 'Enter',
      code: 'Enter',
      keyCode: 13,
      which: 13,
      bubbles: true,
      cancelable: true
    });
    input.dispatchEvent(ev);
  });

  // 3) Cerrar modal
  $('#consultarInsumosModal').modal('hide');
});



$(document).ready(function(){

  // ================= Funciones de Totales =================

  // Suma todos los .total de cada fila y actualiza #totalGeneral
  function updateTotalGeneral() {
    let suma = 0;
    $('#detalleTable tbody tr').each(function() {
      const texto = $(this).find('.total').text().trim().replace(/,/g, '');
      const valor = parseFloat(texto) || 0;
      suma += valor;
    });
    $('#totalGeneral').text(suma.toFixed(2));
  }

  // Calcula el total de una sola fila: qty * price
  function actualizarTotal($row){
    const qty   = parseFloat($row.find('.cantidad').val()) || 0;
    const price = parseFloat($row.find('.precioUnitario').val()) || 0;
    $row.find('.total').text((qty * price).toFixed(2));
  }

  // ================= Agregar Fila =================

  function agregarFila(ex) {
  const $row = $(
    '<tr>' +
      '<td>' +
        '<input type="hidden" name="detalle_existencia_id[]" value="' + ex.id + '"/>' +
        ex.id +
      '</td>' +
      '<td>' + ex.nombre + '</td>' +
      '<td>' + ex.caracteristicas + '</td>' +
      '<td><input type="number" name="detalle_cantidad[]" class="form-control cantidad" value="1" min="1"/></td>' +
      '<td>' +
        '<div class="vto-wrapper">' +
          '<input type="date" name="detalle_fecha_vencimiento[]" class="form-control fechaVto"/>' +
        '</div>' +
        '<label style="display:block; font-weight:normal; margin-top:4px;">' +
          '<input type="checkbox" class="no-vto-checkbox"> No Aplica' +
        '</label>' +
      '</td>' +
      '<td>' +
        '<div class="lote-wrapper">' +
          '<input type="text" name="detalle_lote[]" class="form-control lote"/>' +
        '</div>' +
        '<label style="display:block; font-weight:normal; margin-top:4px;">' +
          '<input type="checkbox" class="no-lote-checkbox"> No Aplica' +
        '</label>' +
      '</td>' +
      '<td>' +
        '<input type="number" name="detalle_precio_unitario[]" class="form-control precioUnitario" ' +
          'value="' + parseFloat(ex.precio_unitario).toFixed(2) + '" step="0.01"/>' +
      '</td>' +
      '<td class="total"></td>' +
      '<td>' +
        '<button type="button" class="btn btn-danger btn-sm eliminar d-flex flex-column align-items-center justify-content-center" style="width:80px;height:80px;"><iconify-icon icon="solar:trash-bin-minimalistic-linear" width="24" height="24"></iconify-icon><span style="font-size:.75rem;">Eliminar</span></button>' +
      '</td>' +
    '</tr>'
  );
  $('#detalleTable tbody').append($row);
  actualizarTotal($row);
  updateTotalGeneral();
  $('#codbarras').val('').focus();
}


  // ================= Escaneo de Código =================

  function handleScan(){
    const code = $('#codbarras').val().trim();
    if (!code) return;
    $.ajax({
      url: '${pageContext.request.contextPath}/ExistenciaServlet',
      method: 'GET',
      dataType: 'json',
      data: { accion: 'buscarajax', codbarras: code },
      success: function(list){
        if (!list.length) {
          Swal.fire('No encontrado', 'No se encontró ningún insumo con ese código.', 'warning');
          return;
        }
        const ex = list[0];
        const existe = $('#detalleTable tbody input[name="detalle_existencia_id[]"][value="' + ex.id + '"]').length > 0;
        if (existe) {
          Swal.fire({
            title: 'Insumo ya agregado',
            text: '¿Desea agregarlo de igual manera?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Sí, agregar',
            cancelButtonText: 'No'
          }).then((result) => {
            if (result.isConfirmed) agregarFila(ex);
          });
        } else {
          agregarFila(ex);
        }
      },
      error: function(){
        Swal.fire('Error', 'Error al consultar el insumo.', 'error');
      }
    });
  }

  $('#btnScanBarcode').on('click', handleScan);
  $('#codbarras').on('keydown', function(e){
    if (e.key === 'Enter') {
      e.preventDefault();
      handleScan();
    }
  });

  // ================= Checkboxes No Aplica =================

  $(document).on('change', '.no-vto-checkbox', function(){
    const $w = $(this).closest('td').find('.vto-wrapper');
    if (this.checked) {
      $w.html('<input type="hidden" name="detalle_fecha_vencimiento[]" value="No Aplica">No Aplica');
    } else {
      $w.html('<input type="date" name="detalle_fecha_vencimiento[]" class="form-control fechaVto"/>');
    }
  });

  $(document).on('change', '.no-lote-checkbox', function(){
    const $w = $(this).closest('td').find('.lote-wrapper');
    if (this.checked) {
      $w.html('<input type="hidden" name="detalle_lote[]" value="No Aplica">No Aplica');
    } else {
      $w.html('<input type="text" name="detalle_lote[]" class="form-control lote"/>');
    }
  });

  // ================= Eliminación de Fila =================

  $('#detalleTable').on('click', '.eliminar', function(){
    $(this).closest('tr').remove();
    updateTotalGeneral();
  });

  // ================= Validaciones y Recalculos =================

  // Cantidad: sólo enteros
  $('#detalleTable')
    .on('keypress', '.cantidad', function(e){
      if (e.which < 48 || e.which > 57) e.preventDefault();
    })
    .on('input', '.cantidad', function(){
      this.value = this.value.replace(/\D/g, '');
      const $fila = $(this).closest('tr');
      actualizarTotal($fila);
      updateTotalGeneral();
    });

  // Precio Unitario: hasta 2 decimales, cursor preservado
  $('#detalleTable')
    .on('keypress', '.precioUnitario', function(e){
      const char = String.fromCharCode(e.which), val = this.value;
      if (!/[0-9.]/.test(char)) {
        e.preventDefault(); return;
      }
      if (char === '.') {
        if (val.includes('.') || val.length === 0) e.preventDefault();
        return;
      }
      if (val.includes('.')) {
        const dec = val.split('.')[1] || '';
        if (dec.length >= 2) e.preventDefault();
      }
    })
    .on('input', '.precioUnitario', function(){
      const input = this;
      const start = input.selectionStart;
      const oldVal = input.value;
      let v = oldVal.replace(/[^0-9.]/g, '');
      const parts = v.split('.');
      if (parts.length > 2) v = parts.shift() + '.' + parts.join('');
      if (v.includes('.')) {
        const [i,d] = v.split('.');
        v = i + '.' + d.slice(0,2);
      }
      if (v !== oldVal) {
        const diff = v.length - oldVal.length;
        input.value = v;
        const pos = Math.max(start + diff, 0);
        input.setSelectionRange(pos, pos);
      }
      // Luego de sanear, recalcular
      const $fila = $(this).closest('tr');
      actualizarTotal($fila);
      updateTotalGeneral();
    })
    .on('blur', '.precioUnitario', function(){
      let v = this.value;
      if (!v) return;
      if (/^\d+\.\d{2}$/.test(v)) return;
      if (/^\d+$/.test(v)) {
        this.value = v + '.00';
      } else if (/^\d+\.\d$/.test(v)) {
        this.value = v + '0';
      } else {
        this.value = '';
      }
      const $fila = $(this).closest('tr');
      actualizarTotal($fila);
      updateTotalGeneral();
    });

});

document.addEventListener("DOMContentLoaded", function () {
  // Cada botón de tab
  document.querySelectorAll('button[data-bs-toggle="tab"]').forEach(function(btn){
    btn.addEventListener('hide.bs.tab', function(event){
      // Selector del panel que se oculta
      const selector = event.target.getAttribute('data-bs-target');
      const pane = document.querySelector(selector);
      if (!pane) return;
      // Resetear todos los inputs, selects y textareas dentro de ese pane
      pane.querySelectorAll('input, select, textarea').forEach(el => {
        if (el.type === 'checkbox' || el.type === 'radio') {
          el.checked = false;
        } else if (el.tagName === 'SELECT') {
          el.selectedIndex = 0;
        } else {
          el.value = '';
        }
      });
    });
  });
});
    
$(function(){
  const $form = $('#formIngresos');
  const $btnGuardar = $('#btnGuardarDatos');

  // Cuando cambias de pestaña, actualiza el hidden 'tipo' y habilita solo esa pestaña
  $('button[data-bs-toggle="tab"]').on('shown.bs.tab', function(e){
    // e.target ? botón activado; obtenemos "#compra", "#traslado", etc.
    const targetSelector = $(e.target).data('bs-target');
    const tipo = targetSelector.substring(1); // quita el '#'
    // Fijamos el input hidden
    $form.find('input[name="tipo"]').val(tipo);

    // Habilitar campos solo de la pestaña activa
    $('.tab-pane').each(function(){
      const isActive = '#' + this.id === targetSelector;
      $(this).find(':input').prop('disabled', !isActive);
    });
    // Asegurarnos de que el hidden 'tipo' quede habilitado
    $form.find('input[name="tipo"]').prop('disabled', false);
  });

  // Inicializar (dispara el evento en la pestaña que ya está activa al cargar)
  $('button[data-bs-toggle="tab"].active').trigger('shown.bs.tab');

  // Al hacer clic en Guardar
  $btnGuardar.on('click', function(){
    $btnGuardar.prop('disabled', true);

    Swal.fire({
      title: 'Procesando ingreso',
      didOpen: () => Swal.showLoading()
    });

    $.ajax({
      url:    $form.attr('action'),
      method: $form.attr('method'),
      data:   $form.serialize(),
      dataType: 'json',
      statusCode: {
        400: function(xhr) {
          Swal.close();
          let msg = 'Error de validación en el servidor.';
          try {
            const res = JSON.parse(xhr.responseText);
            if (res.message) msg = res.message;
          } catch(e){}
          Swal.fire('Error', msg, 'error');
          $btnGuardar.prop('disabled', false);
        }
      }
    })
    .done(function(res){
      Swal.close();
      if (res.success) {
        Swal.fire('¡Listo!', res.message, 'success')
          .then(() => window.location.reload());
      } else {
        Swal.fire('Error', res.message, 'error');
        $btnGuardar.prop('disabled', false);
      }
    })
    .fail(function(){
      Swal.close();
      Swal.fire('Error', 'No se pudo conectar con el servidor.', 'error');
      $btnGuardar.prop('disabled', false);
    });
  });
});
  
  
  
  
</script>
</body>

</html>