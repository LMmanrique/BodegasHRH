<%
    // El objeto session ya está disponible en el JSP
    if (session == null || session.getAttribute("usuario") == null) {
        response.sendRedirect("authentication-login.jsp");
        return;
    }
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!doctype html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Almacen General</title>
  <style>
.destacado {
    
    color: black !important;
    font-weight: bold;
    padding: 10px;
    border-radius: 4px;
    text-align: center;
}
  </style>
  <script src="${pageContext.request.contextPath}/assets/js/quagga.min.js"></script>
  <link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/logos/favicon.png" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styles.min.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/sweetAlert2/sweetalert2.min.css">
</head>

<body>
  <!--  Body Wrapper -->
  <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
    data-sidebar-position="fixed" data-header-position="fixed">

    <!--  App Topstrip -->
    <jsp:include page="/apptopstrip.jsp" />    
    <!-- Sidebar Start -->
    <jsp:include page="/navbar.jsp" />
    <div class="body-wrapper">
     <div class="body-wrapper-inner">
      <div class="container-fluid">
        <div class="card">
          <div class="card-body">
            <div class="container mt-4">
              <h1 class="mb-4">Listado de Existencias</h1>
            <!-- Formulario de Filtros -->
            <form id="filterForm" class="row g-3 mb-4" method="get" action="${pageContext.request.contextPath}/ExistenciaServlet">
              <input type="hidden" name="accion" value="buscar">
              <!-- Campo de Código de Barras y botón de escaneo -->
                <div class="mb-3 d-flex align-items-center">
                <div class="flex-grow-1">
                  <label for="codbarras" class="form-label">Código de Barras</label>
                  <input type="text" class="form-control" id="codbarras" name="codbarras" placeholder="Código de Barras">
                </div>
                <button type="button" class="btn btn-outline-secondary ms-3" id="btnScanBarcode">
                  <iconify-icon icon="solar:camera-linear" width="24" height="24"></iconify-icon>
                </button>
              </div>
              
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
                  <button type="button" class="btn btn-success btn-sm flex-fill" data-bs-toggle="modal" data-bs-target="#consultarInsumosModal">
                    <div class="d-flex flex-column align-items-center">
                      <iconify-icon icon="solar:clipboard-add-linear" width="24" height="24" class="mb-1"></iconify-icon>
                      <span>Agregar Insumo</span>
                    </div>
                  </button>
                  <!-- Nuevo botón Ingreso Manual -->
                  <button type="button" class="btn btn-info btn-sm flex-fill" data-bs-toggle="modal" data-bs-target="#ingresoManualModal">
                    <div class="d-flex flex-column align-items-center">
                      <iconify-icon icon="solar:box-linear" width="24" height="24" class="mb-1"></iconify-icon>
                      <span>Ingreso Manual</span>
                    </div>
                  </button>
                </div>

                <!-- Modal para Ingreso Manual -->
                
            </form>
            
            <!-- Tabla de Existencias -->
            <div id="tablaExistenciasContainer" class="table-responsive">
              <table class="table table-striped table-bordered">
                <thead class="table-dark">
                  <tr>
                    <th style="display:none;">ID</th>
                    <th>Cod. Barras</th>
                    <th>Renglón</th>
                    <th>Código Insumo</th>
                    <th>Nombre</th>
                    <th>Características</th>
                    <th>Nombre Presentación</th>
                    <th>Medida Presentación</th>
                    <th>Código Presentación</th>
                    <th>Cantidad Actual</th>
                    <th>Precio Unitario</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="existencia" items="${listaExistencias}">
                    <tr>
                      <td style="display:none;">${existencia.id}</td>
                    <td>
                      <c:choose>
                        <c:when test="${fn:startsWith(existencia.codbarras, 'BAR')}">
                          <button type="button"
                                  onclick="window.open('generateBarcode.jsp?code=${existencia.codbarras}', '_blank')"
                                  style="border: none; background: none; cursor: pointer;">
                            <div style="display: flex; flex-direction: column; align-items: center;">
                              <!-- Opción 1: usando la notación con dos puntos -->
                              <i class="solar:scanner-linear" style="font-size:32px;"></i>
                              <!-- Opción 2: usando un guion, en caso de que sea la forma correcta -->
                              <!-- <i class="solar-scanner-linear" style="font-size:32px;"></i> -->
                              <span>${existencia.codbarras}</span>
                            </div>
                          </button>
                        </c:when>
                        <c:otherwise>
                          ${existencia.codbarras}
                        </c:otherwise>
                      </c:choose>
                    </td>
                      <td>${existencia.renglon}</td>
                      <td>${existencia.codinsumo}</td>
                      <td>${existencia.nombre}</td>
                      <td>${existencia.caracteristicas}</td>
                      <td>${existencia.npresentacion}</td>
                      <td>${existencia.mpresentacion}</td>
                      <td>${existencia.codpresentacion}</td>
                      <td class="destacado">${existencia.cantidad_actual}</td>
                      <td>Q${existencia.precio_unitario}</td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>
            <c:if test="${empty listaExistencias}">
              <p class="text-center mt-3">No hay registros para mostrar.</p>
            </c:if>

          </div>
        </div>
      </div>
    </div>
  </div>
  </div>
  </div>
    <div class="modal fade" id="consultarInsumosModal" tabindex="-1" aria-labelledby="consultarInsumosModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: auto; max-width: 80%;">
    <div class="modal-content" style="position: relative;">
    <button type="button"
            class="btn btn-danger d-flex align-items-center position-absolute top-0 end-0 m-3"
            style="z-index: 1051;"
            data-bs-dismiss="modal"
            aria-label="Close">
      <iconify-icon icon="solar:close-square-linear" width="24" height="24" class="me-1"></iconify-icon>
      <span>Cerrar</span>
    </button>
      <div class="modal-body">
          <h1 class="mb-4">Listado de Insumos</h1>
            <!-- Formulario de Filtros -->
            <form id="filterFormModal" class="row g-3 mb-4" method="get" action="${pageContext.request.contextPath}/ListarInsumosModalServlet">
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
                <label for="npresentacion" class="form-label">N° Presentación</label>
                <input type="text" class="form-control" id="npresentacion" name="npresentacion" placeholder="N° Presentación">
              </div>
              <div class="col-md-2">
                <label for="mpresentacion" class="form-label">M Presentación</label>
                <input type="text" class="form-control" id="mpresentacion" name="mpresentacion" placeholder="M Presentación">
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
                    <button type="button" id="clearBtnModal" class="btn btn-secondary btn-sm flex-fill" style="background-color: #6f42c1; border-color: #6f42c1; color: #fff;">
                      <div class="d-flex flex-column align-items-center">
                        <iconify-icon icon="solar:magic-stick-3-linear" width="24" height="24" class="mb-1"></iconify-icon>
                        <span>Limpiar Campos</span>
                      </div>
                    </button>
                  </div>
            </form>

            <!-- Contenedor de la Tabla de Insumos -->
            <div id="tablaInsumosContainer" class="table-responsive">
            <div id="tablaInsumosContainer" class="table-responsive">
            <table class="table table-striped table-bordered">
              <thead class="table-dark">
                <tr>
                  <th>ID</th>
                  <th>Renglón</th>
                  <th>Código Insumo</th>
                  <th>Nombre</th>
                  <th>Características</th>
                  <th>N° Presentación</th>
                  <th>M Presentación</th>
                  <th>Código Presentación</th>
                  <th>Acción</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="insumo" items="${listaInsumos}">
                  <tr>
                    <td>${insumo.id}</td>
                    <td>${insumo.renglon}</td>
                    <td>${insumo.codinsumo}</td>
                    <td>${insumo.nombre}</td>
                    <td>${insumo.caracteristicas}</td>
                    <td>${insumo.npresentacion}</td>
                    <td>${insumo.mpresentacion}</td>
                    <td>${insumo.codpresentacion}</td>
                      <td>
                        <button type="button" class="btn btn-success btn-sm flex-fill text-white agregarExistenciaBtnModal"
                                data-id="${insumo.id}"
                                data-renglon="${insumo.renglon}"
                                data-codinsumo="${insumo.codinsumo}"
                                data-nombre="${insumo.nombre}"
                                data-caracteristicas="${insumo.caracteristicas}"
                                data-npresentacion="${insumo.npresentacion}"
                                data-mpresentacion="${insumo.mpresentacion}"
                                data-codpresentacion="${insumo.codpresentacion}">
                          <div class="d-flex flex-column align-items-center">
                            <iconify-icon icon="solar:clipboard-add-linear" width="24" height="24" class="mb-1"></iconify-icon>
                            <span>Agregar a Existencias</span>
                          </div>
                        </button>
                      </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
            <c:if test="${empty listaInsumos}">
              <p class="text-center mt-3">No hay registros para mostrar.</p>
            </c:if>
          </div>

            <!-- Modal para Agregar Existencia -->
            <div class="modal fade" id="modalAgregarExistencia" tabindex="-1" aria-labelledby="modalAgregarExistenciaLabel" aria-hidden="true">
              <div class="modal-dialog modal-sm">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="modalAgregarExistenciaLabel">Agregar a Existencias</h5>
                    <button type="button" class="btn btn-sm" data-bs-dismiss="modal" aria-label="Cerrar">
                      <iconify-icon icon="solar:close-square-linear" width="24" height="24"></iconify-icon>
                    </button>
                  </div>
                  <div class="modal-body">
                    <form id="agregarExistenciaForm">
                      <!-- Campos ocultos para enviar todos los datos del insumo -->
                      <input type="hidden" id="insumoId" name="insumoId" value="">
                      <input type="hidden" id="modal_renglon" name="renglon" value="">
                      <input type="hidden" id="modal_codinsumo" name="codinsumo" value="">
                      <input type="hidden" id="modal_nombre" name="nombre" value="">
                      <input type="hidden" id="modal_caracteristicas" name="caracteristicas" value="">
                      <input type="hidden" id="modal_npresentacion" name="npresentacion" value="">
                      <input type="hidden" id="modal_mpresentacion" name="mpresentacion" value="">
                      <input type="hidden" id="modal_codpresentacion" name="codpresentacion" value="">
                      <!-- Campos para cantidad y precio -->
                      <div class="mb-3 d-flex align-items-center">
                        <div class="flex-grow-1">
                          <label for="modal_codbarras" class="form-label">Código de Barras</label>
                          <input type="text" class="form-control" id="modal_codbarras" name="modal_codbarras" placeholder="Código de Barras">
                        </div>
                        <button type="button" class="btn btn-outline-secondary ms-3" id="btnScanBarcodeModal">
                          <iconify-icon icon="solar:camera-linear" width="24" height="24"></iconify-icon>
                        </button>
                      </div>
                      <div class="mb-3">
                        <label for="cantidadExistencia" class="form-label">Cantidad en Existencias</label>
                        <input type="number" step="any" class="form-control" id="cantidadExistencia" name="cantidad_actual" placeholder="Cantidad" required>
                      </div>
                      <div class="mb-3">
                        <label for="precioUnitario" class="form-label">Precio Unitario</label>
                        <input type="number" step="any" class="form-control" id="precioUnitario" name="precio_unitario" placeholder="Precio Unitario" required>
                      </div>
                    </form>
                  </div>
                  <div class="modal-footer">
                      <button type="button" class="btn btn-danger" data-bs-dismiss="modal">
                        <div class="d-flex flex-column align-items-center">
                          <iconify-icon icon="solar:close-square-linear" width="24" height="24" class="mb-1"></iconify-icon>
                          <span>Cancelar</span>
                        </div>
                      </button>
                      <button type="button" id="guardarExistenciaBtnModal" class="btn btn-success">
                        <div class="d-flex flex-column align-items-center">
                          <iconify-icon icon="solar:cloud-upload-linear" width="24" height="24" class="mb-1"></iconify-icon>
                          <span>Guardar</span>
                        </div>
                      </button>
                  </div>
                </div>
              </div>
            </div>
        </div>
      </div>
    </div>
  </div>
  <div class="modal fade" id="ingresoManualModal" tabindex="-1" aria-labelledby="ingresoManualModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg" style="max-height: 80vh;">
    <div class="modal-content">
    <div class="modal-header">
        <h5 class="modal-title" id="ingresoManualModalLabel">Ingreso Manual</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
      </div>
      <div class="modal-body">
         <form id="formAgregarInsumoManual" class="needs-validation" novalidate action="${pageContext.request.contextPath}/ExistenciaServlet" method="post">
            <input type="hidden" name="accion" value="insertar">
            <!-- Renglón -->
            <div class="mb-3">
              <label for="renglon" class="form-label">Renglón</label>
              <input type="number" class="form-control" id="renglon" name="renglon" required step="1"
                     oninput="this.value = this.value.replace(/[^0-9]/g, '');">
              <div class="invalid-feedback">
                Por favor ingrese el renglón (número entero).
              </div>
            </div>

            <!-- Código de Insumo -->
            <div class="mb-3">
              <label for="codinsumo" class="form-label">Código Insumo</label>
              <input type="number" class="form-control" id="codinsumo" name="codinsumo" required step="1"
                     oninput="this.value = this.value.replace(/[^0-9]/g, '');">
              <div class="invalid-feedback">
                Por favor ingrese el código del insumo.
              </div>
            </div>

            <!-- Nombre -->
            <div class="mb-3">
              <label for="nombre" class="form-label">Nombre</label>
              <input type="text" class="form-control" id="nombre" name="nombre" maxlength="5000" required>
              <div class="invalid-feedback">
                Por favor ingrese el nombre.
              </div>
            </div>

            <!-- Características -->
            <div class="mb-3">
              <label for="caracteristicas" class="form-label">Características</label>
              <textarea class="form-control" id="caracteristicas" name="caracteristicas" rows="3" maxlength="5000" required></textarea>
              <div class="invalid-feedback">
                Por favor ingrese las características.
              </div>
            </div>

            <!-- Nombre Presentación -->
            <div class="mb-3">
              <label for="npresentacion" class="form-label">Nombre Presentación</label>
              <textarea class="form-control" id="npresentacion" name="npresentacion" rows="2" maxlength="5000" required></textarea>
              <div class="invalid-feedback">
                Por favor ingrese el nombre de presentación.
              </div>
            </div>

            <!-- Medida Presentación -->
            <div class="mb-3">
              <label for="mpresentacion" class="form-label">Medida Presentación</label>
              <input type="text" class="form-control" id="mpresentacion" name="mpresentacion" maxlength="255" required>
              <div class="invalid-feedback">
                Por favor ingrese la medida de presentación.
              </div>
            </div>

            <!-- Código Presentación -->
            <div class="mb-3">
              <label for="codpresentacion" class="form-label">Código Presentación</label>
              <input type="number" class="form-control" id="codpresentacion" name="codpresentacion" required step="1"
                     oninput="this.value = this.value.replace(/[^0-9]/g, '');">
              <div class="invalid-feedback">
                Por favor ingrese el código de presentación.
              </div>
            </div>

            <!-- Cantidad Actual -->
            <div class="mb-3">
              <label for="cantidad_actual" class="form-label">Cantidad Actual</label>
              <input type="number" step="0.01" class="form-control" id="cantidad_actual" name="cantidad_actual" value="0.00" required>
              <div class="invalid-feedback">
                Por favor ingrese la cantidad actual.
              </div>
            </div>

            <!-- Precio Unitario -->
            <div class="mb-3">
              <label for="precio_unitario" class="form-label">Precio Unitario</label>
              <input type="number" step="0.01" class="form-control" id="precio_unitario" name="precio_unitario" required>
              <div class="invalid-feedback">
                Por favor ingrese el precio unitario.
              </div>
            </div>

            <!-- Botón de envío -->
            <button type="submit" class="btn btn-primary">Guardar Insumo</button>
          </form>

      </div>
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
  <!-- Script para limpiar el formulario principal -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
      const clearBtn = document.getElementById('clearBtn');
      clearBtn.addEventListener('click', function() {
        document.getElementById('filterForm').reset();
      });
    });
</script>
<script>
  $(document).ready(function(){
    $('#filterForm').on('submit', function(e) {
      e.preventDefault(); // Evita el envío normal del formulario
      $.ajax({
        url: $(this).attr('action'),
        type: 'GET',
        data: $(this).serialize(),
        success: function(data) {
          // Revisa en consola la respuesta para depurar la estructura HTML
          console.log("Respuesta AJAX:", data);
          // Intenta extraer el contenido del <tbody> dentro del contenedor con id "tablaExistenciasContainer"
          var nuevoTbody = $(data).find('#tablaExistenciasContainer tbody').html();
          if (nuevoTbody) {
            $('#tablaExistenciasContainer tbody').html(nuevoTbody);
          } else {
            // Si no encuentra el contenedor, intenta extraer el primer <tbody> encontrado
            nuevoTbody = $(data).find("tbody").first().html();
            if(nuevoTbody){
              $('#tablaExistenciasContainer tbody').html(nuevoTbody);
            } else {
              console.error("No se encontró el tbody en la respuesta AJAX.");
            }
          }
        },
        error: function(xhr, status, error) {
          console.error("Error en la solicitud AJAX: " + error);
        }
      });
    });
  });
</script>
<script>
    // Limpiar formulario de filtros
    document.addEventListener('DOMContentLoaded', function() {
      const clearBtnModal = document.getElementById('clearBtnModal');
      clearBtnModal.addEventListener('click', function() {
        document.getElementById('filterFormModal').reset();
      });
    });
     // Delegación para el botón "Agregar a Existencias" en la tabla
    $(document).on('click', '.agregarExistenciaBtnModal', function() {
      $('#insumoId').val($(this).attr('data-id'));
      $('#modal_renglon').val($(this).attr('data-renglon'));
      $('#modal_codinsumo').val($(this).attr('data-codinsumo'));
      $('#modal_nombre').val($(this).attr('data-nombre'));
      $('#modal_caracteristicas').val($(this).attr('data-caracteristicas'));
      $('#modal_npresentacion').val($(this).attr('data-npresentacion'));
      $('#modal_mpresentacion').val($(this).attr('data-mpresentacion'));
      $('#modal_codpresentacion').val($(this).attr('data-codpresentacion'));
      $('#modalAgregarExistenciaLabel').text("Agregar a Existencias - " + $(this).attr('data-nombre'));
      $('#modalAgregarExistencia').modal('show');
    });
    
// Manejo del botón "Guardar" en el modal
$('#guardarExistenciaBtnModal').on('click', function() {
    var cantidad = $('#cantidadExistencia').val();
    var precio = $('#precioUnitario').val();
    var codbarras = $('#modal_codbarras').val();

    if (cantidad === "" || precio === "" || codbarras === "") {
        Swal.fire('Error', 'Complete los campos obligatorios.', 'error');
        return;
    }

    var formData = $('#agregarExistenciaForm').serialize() + '&codbarras=' + encodeURIComponent(codbarras);

    Swal.fire({
        title: '¿Está seguro?',
        text: "¿Desea agregar este insumo a existencias con cantidad " + cantidad + " y precio unitario " + precio + "?",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Sí, guardar',
        cancelButtonText: 'Cancelar'
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                url: '${pageContext.request.contextPath}/ExistenciaServlet?accion=insertar',
                type: 'POST',
                data: formData,
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        Swal.fire('Agregado!', response.message, 'success');
                        $('#modalAgregarExistencia').modal('hide');
                        setTimeout(() => location.reload(), 1500);
                    } else {
                        Swal.fire('Error', response.message, 'error');
                    }
                },
                error: function(xhr, status, error) {
                    Swal.fire('Error', 'Error del servidor: ' + error, 'error');
                }
            });
        }
    });
});

</script>
<script>
        $('#filterFormModal').on('submit', function(e){
          e.preventDefault();
          $.ajax({
            url: $(this).attr('action'),
            type: 'GET',
            data: $(this).serialize(),
            success: function(data){
              // Intenta extraer el primer <tbody> encontrado
              var nuevoTbodyModal = $(data).find('tbody').first().html();
              if(nuevoTbodyModal){
                $('#tablaInsumosContainer tbody').html(nuevoTbodyModal);
              } else {
                console.error("No se encontró el tbody en la respuesta AJAX.");
              }
            },
            error: function(xhr, status, error){
              console.error("Error en la solicitud AJAX: " + error);
            }
          });
        });
</script>
  <script>
    (function () {
      'use strict';
      var forms = document.querySelectorAll('.needs-validation');
      Array.prototype.slice.call(forms)
        .forEach(function (form) {
          form.addEventListener('submit', function (event) {
            event.preventDefault();
            event.stopPropagation();

            // Validar el formulario
            if (!form.checkValidity()) {
              form.classList.add('was-validated');
              return;
            }

            // Mostrar SweetAlert indicando que se están guardando los datos
            Swal.fire({
              title: 'Guardando datos',
              allowOutsideClick: false,
              didOpen: () => {
                Swal.showLoading();
              }
            });

            // Enviar el formulario mediante AJAX
            $.ajax({
              url: form.action,
              type: form.method,
              data: $(form).serialize(),
              success: function(response) {
                // Cerrar el modal (asegúrate de que el id coincida con el de tu modal)
                $('#ingresoManualModal').modal('hide');
                // Mostrar mensaje de éxito y recargar la página
                Swal.fire({
                  icon: 'success',
                  title: 'Insumo guardado',
                  showConfirmButton: false,
                  timer: 1500
                }).then(() => {
                  location.reload();
                });
              },
              error: function(error) {
                Swal.fire({
                  icon: 'error',
                  title: 'Error',
                  text: 'No se pudo guardar el insumo. Inténtalo de nuevo.'
                });
              }
            });

            form.classList.add('was-validated');
          }, false);
        });
    })();
  </script>
<script>
  function startCameraCapture() {
    let captureModal = document.getElementById('captureModal');
    if (!captureModal) {
      captureModal = document.createElement('div');
      captureModal.id = 'captureModal';
      captureModal.style.position = 'fixed';
      captureModal.style.top = '0';
      captureModal.style.left = '0';
      captureModal.style.width = '100%';
      captureModal.style.height = '100%';
      captureModal.style.backgroundColor = 'rgba(0,0,0,0.8)';
      captureModal.style.display = 'flex';
      captureModal.style.flexDirection = 'column';
      captureModal.style.alignItems = 'center';
      captureModal.style.justifyContent = 'center';
      captureModal.style.zIndex = '1050';
      captureModal.innerHTML = `
        <video id="videoCapture" autoplay style="width:300px; height:300px; background: #000;"></video>
        <button id="takePhoto" class="btn btn-primary mt-3">Tomar Foto</button>
        <button id="closeCapture" class="btn btn-danger mt-3">Cerrar</button>
      `;
      document.body.appendChild(captureModal);

      // Botón para cerrar y detener la cámara
      document.getElementById('closeCapture').addEventListener('click', function() {
        let video = document.getElementById('videoCapture');
        if (video.srcObject) {
          video.srcObject.getTracks().forEach(track => track.stop());
        }
        captureModal.style.display = 'none';
      });
    }
    captureModal.style.display = 'flex';

    // Inicia la cámara con la opción de usar la cámara trasera (en móviles)
    const video = document.getElementById('videoCapture');
    navigator.mediaDevices.getUserMedia({ video: { facingMode: "environment" }})
      .then(function(stream) {
        video.srcObject = stream;
        video.play();
      })
      .catch(function(err) {
        console.error("Error al acceder a la cámara: ", err);
      });

    // Captura la imagen al pulsar "Tomar Foto"
    document.getElementById('takePhoto').onclick = function(){
      let canvas = document.createElement('canvas');
      canvas.width = video.videoWidth;
      canvas.height = video.videoHeight;
      let ctx = canvas.getContext('2d');
      ctx.drawImage(video, 0, 0, canvas.width, canvas.height);

      // Detenemos el stream de video
      if (video.srcObject) {
        video.srcObject.getTracks().forEach(track => track.stop());
      }

      // Convertimos la imagen capturada a formato DataURL
      let dataUrl = canvas.toDataURL('image/png');

      // Mostramos SweetAlert indicando que se está analizando el código
      Swal.fire({
        title: "Analizando código de barras",
        allowOutsideClick: false,
        didOpen: () => {
          Swal.showLoading();
        }
      });

      // Procesamos la imagen usando Quagga.decodeSingle
      Quagga.decodeSingle({
        src: dataUrl,
        numOfWorkers: 0,  // Se recomienda 0 para decodeSingle
        inputStream: { size: 300 },
        decoder: {
          readers: ["code_128_reader", "ean_reader", "ean_8_reader", "upc_reader"]
        }
      }, function(result) {
        Swal.close();
        if(result && result.codeResult){
          const code = result.codeResult.code;
          const codbarrasInput = document.getElementById('codbarras');
          if(codbarrasInput){
            codbarrasInput.value = code;
            codbarrasInput.focus();
            // Opcional: simulamos el "Enter" si tu lógica lo requiere
            const event = new KeyboardEvent('keypress', {
              key: 'Enter',
              code: 'Enter',
              charCode: 13,
              keyCode: 13,
              bubbles: true,
              cancelable: true
            });
            codbarrasInput.dispatchEvent(event);
          }
        } else {
          Swal.fire('Error', 'No se detectó ningún código de barras', 'error');
        }
        captureModal.style.display = 'none';
      });
    };
  }

  // Asignamos la función al botón de la cámara de la página principal
  document.getElementById('btnScanBarcode').addEventListener('click', startCameraCapture);
</script>
<script>
  function startCameraCaptureModal() {
    let captureModal = document.getElementById('captureModalModal');
    if (!captureModal) {
      captureModal = document.createElement('div');
      captureModal.id = 'captureModalModal';
      captureModal.style.position = 'fixed';
      captureModal.style.top = '0';
      captureModal.style.left = '0';
      captureModal.style.width = '100%';
      captureModal.style.height = '100%';
      captureModal.style.backgroundColor = 'rgba(0,0,0,0.8)';
      captureModal.style.display = 'flex';
      captureModal.style.flexDirection = 'column';
      captureModal.style.alignItems = 'center';
      captureModal.style.justifyContent = 'center';
      captureModal.style.zIndex = '1055';
      captureModal.innerHTML = `
        <video id="videoCaptureModal" autoplay style="width:300px; height:300px; background: #000;"></video>
        <button id="takePhotoModal" class="btn btn-primary mt-3">Tomar Foto</button>
        <button id="closeCaptureModal" class="btn btn-danger mt-3">Cerrar</button>
      `;
      document.body.appendChild(captureModal);

      // Botón para cerrar y detener la cámara
      document.getElementById('closeCaptureModal').addEventListener('click', function() {
        let video = document.getElementById('videoCaptureModal');
        if (video.srcObject) {
          video.srcObject.getTracks().forEach(track => track.stop());
        }
        captureModal.style.display = 'none';
      });
    }
    captureModal.style.display = 'flex';

    // Inicia la cámara para el modal
    const video = document.getElementById('videoCaptureModal');
    navigator.mediaDevices.getUserMedia({ video: { facingMode: "environment" }})
      .then(function(stream) {
        video.srcObject = stream;
        video.play();
      })
      .catch(function(err) {
        console.error("Error al acceder a la cámara: ", err);
      });

    // Captura la foto al hacer clic en "Tomar Foto"
    document.getElementById('takePhotoModal').onclick = function(){
      let canvas = document.createElement('canvas');
      canvas.width = video.videoWidth;
      canvas.height = video.videoHeight;
      let ctx = canvas.getContext('2d');
      ctx.drawImage(video, 0, 0, canvas.width, canvas.height);

      if (video.srcObject) {
        video.srcObject.getTracks().forEach(track => track.stop());
      }

      let dataUrl = canvas.toDataURL('image/png');

      Swal.fire({
        title: "Analizando código de barras",
        allowOutsideClick: false,
        didOpen: () => {
          Swal.showLoading();
        }
      });

      Quagga.decodeSingle({
        src: dataUrl,
        numOfWorkers: 0,
        inputStream: { size: 300 },
        decoder: {
          readers: ["code_128_reader", "ean_reader", "ean_8_reader", "upc_reader"]
        }
      }, function(result) {
        Swal.close();
        if(result && result.codeResult){
          const code = result.codeResult.code;
          const modalInput = document.getElementById('modal_codbarras');
          if(modalInput){
            modalInput.value = code;
            modalInput.focus();
          }
        } else {
          Swal.fire('Error', 'No se detectó ningún código de barras', 'error');
        }
        captureModal.style.display = 'none';
      });
    };
  }

  // Asignamos la función al botón de la cámara del modal
  document.getElementById('btnScanBarcodeModal').addEventListener('click', startCameraCaptureModal);
</script>
</body>

</html>