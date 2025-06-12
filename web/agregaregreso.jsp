

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
          
<form id="formEgresos" action="EgresosServlet" method="post">
    <input type="hidden" name="usuario" value="${usuario.id_usuario}">

<!-- Tab content -->
<div class="tab-content" id="egresosTabsContent">
<!-- Tab Compra -->
    <div class="tab-pane fade show active" id="despacho" role="tabpanel" aria-labelledby="despacho-tab">
      
        <div class="card mb-4 shadow-sm">
          <div class="card-header bg-primary">
            <h5 class="mb-0 text-white d-flex align-items-center gap-2">
              <iconify-icon icon="solar:box-linear"></iconify-icon>
              Despacho
            </h5>
          </div>
          <div class="card-body">
            <div class="row">
            <div class="row">
              <div class="col-md-6 mb-3">
                <label for="fecha" class="form-label">Fecha <span class="text-danger">*</span></label>
                <input type="date" class="form-control" id="fecha" name="fecha" required>
              </div>
              <div class="col-md-6 mb-3">
                <label for="tipo_movimiento" class="form-label">Tipo <span class="text-danger">*</span></label>
                <select class="form-select" id="tipo_movimiento" name="tipo_movimiento" required>
                  
                  <option value="Despacho">Despacho</option>
                  
                </select>
              </div>
              <div class="col-md-6 mb-3">
                <label for="proveedor" class="form-label">No. Requisición<span class="text-danger">*</span></label>
                <input type="text" class="form-control" id="proveedor" name="proveedor" required>
              </div>
              <div class="col-md-6 mb-3">
              <label for="servicio" class="form-label">
                Servicio<span class="text-danger">*</span>
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
                        <th>Existencia Total</th>
                        <th>Fecha de Vencimiento / Lote / Cantidad</th>
                        <th>Cantidad a despachar</th>
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

  <script src="${pageContext.request.contextPath}/assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/sidebarmenu.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/app.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/libs/apexcharts/dist/apexcharts.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/libs/simplebar/dist/simplebar.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/dashboard.js"></script>
  <!-- solar icons -->
  <script src="${pageContext.request.contextPath}/assets/js/iconify-icon.min"></script>
  <script src="${pageContext.request.contextPath}/assets/sweetAlert2/sweetalert2.all.min.js"></script>
  

<script type="text/javascript">
$(function(){
  var base = '<%= request.getContextPath() %>';

  var $form = $("#formEgresos");
  var $btnGuardar = $("#btnGuardarDatos");
  // 1) Filtrar en el modal de existencias
  $('#filterForm').on('submit', function(e){
    e.preventDefault();
    $.ajax({
      url: this.action,
      type: this.method,
      data: $(this).serialize(),
      success: function(response){
        $('#tablaExistenciasContainer').html(response);
      },
      error: function(xhr, status, error){
        console.error('Error en la búsqueda:', error);
      }
    });
  });
  $('#clearBtn').on('click', function(){
    $('#filterForm')[0].reset();
  });

  // 2) Agregar insumo desde el modal
  $('#tablaExistenciasContainer').on('click', '.agregarExistenciaBtn', function(){
    var barcode = $(this).data('codbarras');
    var input   = $('#codbarras');
    input.val(barcode).focus();
    ['keydown','keypress','keyup'].forEach(function(type){
      input[0].dispatchEvent(new KeyboardEvent(type, {
        key: 'Enter', code: 'Enter', keyCode: 13, which: 13, bubbles: true
      }));
    });
    $('#consultarInsumosModal').modal('hide');
  });

  // 3) Escanear o ingresar manual código
  $('#codbarras').focus().on('keydown', function(e){
    if (e.which === 13) {
      e.preventDefault();
      var code = $(this).val().trim();
      if (!code) return;
      buscarCodigo(code);
    }
  });
  function buscarCodigo(code){
    $.getJSON(base + '/ExistenciaServlet', {
      accion: 'buscarPorCodigoJSON',
      codbarras: code
    })
    .done(function(data){
      if (data.id) {
        addDetalleRow(data);
        updateTotalGeneral();
      } else {
        Swal.fire('No encontrado','El insumo no existe','warning');
      }
      $('#codbarras').val('').focus();
    })
    .fail(function(){
      Swal.fire('Error','No se pudo consultar el insumo','error');
    });
  }

  // 4) Añadir fila con validación de cantidad
  window.addDetalleRow = function(item){
    var $tr = $('<tr>');
    $tr.append('<td>' + item.id + '</td>');
    $tr.append('<td>' + item.nombre + '</td>');
    $tr.append('<td>' + item.caracteristicas + '</td>');
    $tr.append('<td>' + parseFloat(item.cantidad_actual).toFixed(2) + '</td>');

    // Preparar lotes
    var lotes = (Array.isArray(item.lotes) && item.lotes.length)
      ? item.lotes
      : [{ fecha_vencimiento:null, lote:null, cantidad:item.cantidad_actual }];
    var $sel = $('<select class="form-select loteSelect"></select>');
    lotes.forEach(function(l){
      var txt = (l.fecha_vencimiento && l.lote)
        ? l.fecha_vencimiento + ' / ' + l.lote + ' / ' + parseFloat(l.cantidad).toFixed(2)
        : 'Sin lote / Sin fecha';
      $sel.append('<option value=\'' + JSON.stringify(l) + '\'>' + txt + '</option>');
    });
    $tr.append($('<td>').append($sel));

    // Cantidad con atributo max
    var initialLote = lotes[0];
    var maxQty = parseFloat(initialLote.cantidad) || parseFloat(item.cantidad_actual);
    var $qty = $('<input type="number" class="form-control qty" value="1" min="1" step="0.01">')
               .attr('max', maxQty.toFixed(2));
    $tr.append($('<td>').append($qty));

    // Precio readonly
    $tr.append('<td><input type="number" class="form-control price" value="' +
           parseFloat(item.precio_unitario).toFixed(2) +
           '" step="0.01" readonly></td>');
    $tr.append('<td class="subtotal">0.00</td>');
    $tr.append('<td><button type="button" class="btn btn-danger btn-sm removeRow">Eliminar</button></td>');

    $('#detalleTable tbody').append($tr);
    recalcRow($tr);
    updateTotalGeneral();
  };

  // 5) Funciones de recálculo
  function recalcRow($tr){
    var q = parseFloat($tr.find('.qty').val()) || 0;
    var p = parseFloat($tr.find('.price').val()) || 0;
    $tr.find('.subtotal').text((q * p).toFixed(2));
  }
  function updateTotalGeneral(){
    var total = 0;
    $('#detalleTable tbody .subtotal').each(function(){
      total += parseFloat($(this).text()) || 0;
    });
    $('#totalGeneral').text(total.toFixed(2));
  }

  // 6) Delegación de eventos
  $(document).on('change', '.qty', function(){
    var $this = $(this),
        val   = parseFloat($this.val()) || 0,
        max   = parseFloat($this.attr('max')) || 0,
        $tr   = $this.closest('tr');
    if (val > max) {
  $('#btnGuardarDatos').on('click', function(e){
    e.preventDefault();
    $btnGuardar.prop('disabled', true);
  var detalles = [];
  $('#detalleTable tbody tr').each(function(){
    var $tr = $(this), cols = $tr.find('td'), loteData;
    try { loteData = JSON.parse($tr.find('.loteSelect').val()); } catch(_) { loteData = { fecha_vencimiento:null, lote:null }; }
    detalles.push({
      existencia_id:     parseInt(cols.eq(0).text(),10),
      fecha_vencimiento: loteData.fecha_vencimiento,
      lote:              loteData.lote,
      cantidad:          parseFloat($tr.find('.qty').val())||0,
      precio_unitario:   parseFloat($tr.find('.price').val())||0
    });
  });
  var payload = {
    usuario: $('input[name="usuario"]').val(),
    fecha: $('#fecha').val(),
    tipo_movimiento: $('#tipo_movimiento').val(),
    proveedor: $('#proveedor').val(),
    servicio_devuelve: $('#servicio_devuelve').val(),
    observaciones_compra: $('#observaciones_compra').val(),
    detalles: detalles
  };

  Swal.fire({
    title: 'Procesando egreso',
    didOpen: () => Swal.showLoading()
  });

  $.ajax({
    url: base + '/EgresosServlet',
    method: 'POST',
    contentType: 'application/json; charset=UTF-8',
    data: JSON.stringify(payload),
    dataType: 'json',
    statusCode: {
      400: function(xhr){
        Swal.close();
        var msg = 'Error de validación en el servidor.';
        try {
          var res = JSON.parse(xhr.responseText);
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
      Swal.fire('Listo!','Egreso guardado','success')
        .then(()=> window.location = base + '/agregaregreso.jsp');
    } else {
      Swal.fire('Error', res.message || res.error || 'Falló guardado','error');
      $btnGuardar.prop('disabled', false);
    }
  })
  .fail(function(){
    Swal.close();
    Swal.fire('Error','No se pudo conectar con el servidor.','error');
    $btnGuardar.prop('disabled', false);
  });
      servicio_devuelve: $('#servicio_devuelve').val(),
      observaciones_compra: $('#observaciones_compra').val(),
      detalles: detalles
    };
    $.ajax({
      url: base + '/EgresosServlet',
      method: 'POST',
      contentType: 'application/json; charset=UTF-8',
      data: JSON.stringify(payload),
      dataType: 'json'
    })
    .done(function(res){
      if (res.success) {
        Swal.fire('¡Listo!','Egreso guardado','success')
          .then(()=> window.location = base + '/agregaregreso.jsp');
      } else {
        Swal.fire('Error', res.error||'Falló guardado','error');
      }
    })
    .fail(function(xhr){
      Swal.fire('Error','Fallo de servidor','error');
    });
  });
});
</script>


  
</body>

</html>