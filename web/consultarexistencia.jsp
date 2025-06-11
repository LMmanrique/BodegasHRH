<%
    // El objeto session ya est� disponible en el JSP
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
      .btn-square {
  width: 4rem;        /* ancho fijo */
  height: 4rem;       /* igual al alto para hacerlo cuadrado */
  padding: 0.5rem;    /* algo de espacio alrededor del icono */
}
  /* 1. Anula el scroll horizontal */
  #tablaExistenciasContainer.table-responsive {
    overflow-x: hidden;
  }

  /* 2. Fuerza ancho completo y columnas fijas */
  #tablaExistenciasContainer table {
    width: 100%;
    table-layout: fixed;
  }

  /* 3. Envuelve texto y ajusta tama�o din�micamente */
  #tablaExistenciasContainer th,
  #tablaExistenciasContainer td {
    white-space: normal !important;
    overflow-wrap: break-word;
    font-size: clamp(0.75rem, 1.2vw, 1rem);
    padding: clamp(0.3rem, 0.8vw, 0.75rem);
  }

  /* 4. Ajustes finos por breakpoint */
  @media (max-width: 992px) {
    #tablaExistenciasContainer th,
    #tablaExistenciasContainer td {
      font-size: 0.85rem;
      padding: 0.4rem;
    }
  }
  @media (max-width: 768px) {
    #tablaExistenciasContainer th,
    #tablaExistenciasContainer td {
      font-size: 0.75rem;
      padding: 0.3rem;
    }
  }
      
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
              <!-- Campo de C�digo de Barras y bot�n de escaneo -->
                <div class="mb-3 d-flex align-items-center">
                <div class="flex-grow-1">
                  <label for="codbarras" class="form-label">C�digo de Barras</label>
                  <input type="text" class="form-control" id="codbarras" name="codbarras" placeholder="C�digo de Barras">
                </div>
                
              </div>
              
              <div class="col-md-2">
                <label for="renglon" class="form-label">Rengl�n</label>
                <input type="text" class="form-control" id="renglon" name="renglon" placeholder="Rengl�n">
              </div>
              <div class="col-md-2">
                <label for="codinsumo" class="form-label">C�digo Insumo</label>
                <input type="text" class="form-control" id="codinsumo" name="codinsumo" placeholder="C�digo">
              </div>
              <div class="col-md-2">
                <label for="nombre" class="form-label">Nombre</label>
                <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Nombre">
              </div>
              <div class="col-md-2">
                <label for="caracteristicas" class="form-label">Caracter�sticas</label>
                <input type="text" class="form-control" id="caracteristicas" name="caracteristicas" placeholder="Caracter�sticas">
              </div>
              <div class="col-md-2">
                <label for="npresentacion" class="form-label">Nombre Presentaci�n</label>
                <input type="text" class="form-control" id="npresentacion" name="npresentacion" placeholder="Nombre Presentaci�n">
              </div>
              <div class="col-md-2">
                <label for="mpresentacion" class="form-label">Medida Presentaci�n</label>
                <input type="text" class="form-control" id="mpresentacion" name="mpresentacion" placeholder="Medida Presentaci�n">
              </div>
              <div class="col-md-2">
                <label for="codpresentacion" class="form-label">C�digo Presentaci�n</label>
                <input type="text" class="form-control" id="codpresentacion" name="codpresentacion" placeholder="C�digo">
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
                  <!-- Nuevo bot�n Ingreso Manual -->
                  <button type="button" class="btn btn-info btn-sm flex-fill" data-bs-toggle="modal" data-bs-target="#ingresoManualModal">
                    <div class="d-flex flex-column align-items-center">
                      <iconify-icon icon="solar:box-linear" width="24" height="24" class="mb-1"></iconify-icon>
                      <span>Ingreso Manual</span>
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
                    <th>Cod. Barras</th>
                    <th>Rengl�n</th>
                    <th>C�digo Insumo</th>
                    <th>Nombre</th>
                    <th>Caracter�sticas</th>
                    <th>Nombre Presentaci�n</th>
                    <th>Medida Presentaci�n</th>
                    <th>C�digo Presentaci�n</th>
                    <th>Cantidad Actual</th>
                    <th>Precio Unitario</th>
                    <th>Opciones</th> <!-- NUEVA COLUMNA -->
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
                                <i class="solar:scanner-linear" style="font-size:32px;"></i>
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
                      <td> <!-- NUEVA CELDA DE OPCIONES -->
                          <a href="editarExistencia.jsp?id=${existencia.id}"
                            class="btn btn-warning btn-sm btn-square
                                   d-flex flex-column align-items-center justify-content-center">
                           <iconify-icon
                             icon="solar:document-add-linear"
                             width="24" height="24">
                           </iconify-icon>
                           <span class="small mt-1">Editar</span>
                         </a>
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
        </div>
      </div>
    </div>
  </div>
  </div>
  </div>
  <!-- MODAL AGREGAR INSUMO A EXISTENCIA, CON BUSQUEDA -->
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
                <label for="renglon" class="form-label">Rengl�n</label>
                <input type="text" class="form-control" id="renglon" name="renglon" placeholder="Rengl�n">
              </div>
              <div class="col-md-2">
                <label for="codinsumo" class="form-label">C�digo Insumo</label>
                <input type="text" class="form-control" id="codinsumo" name="codinsumo" placeholder="C�digo">
              </div>
              <div class="col-md-2">
                <label for="nombre" class="form-label">Nombre</label>
                <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Nombre">
              </div>
              <div class="col-md-2">
                <label for="caracteristicas" class="form-label">Caracter�sticas</label>
                <input type="text" class="form-control" id="caracteristicas" name="caracteristicas" placeholder="Caracter�sticas">
              </div>
              <div class="col-md-2">
                <label for="npresentacion" class="form-label">N� Presentaci�n</label>
                <input type="text" class="form-control" id="npresentacion" name="npresentacion" placeholder="N� Presentaci�n">
              </div>
              <div class="col-md-2">
                <label for="mpresentacion" class="form-label">M Presentaci�n</label>
                <input type="text" class="form-control" id="mpresentacion" name="mpresentacion" placeholder="M Presentaci�n">
              </div>
              <div class="col-md-2">
                <label for="codpresentacion" class="form-label">C�digo Presentaci�n</label>
                <input type="text" class="form-control" id="codpresentacion" name="codpresentacion" placeholder="C�digo">
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
            <table class="table table-striped table-bordered">
              <thead class="table-dark">
                <tr>
                  <th>ID</th>
                  <th>Rengl�n</th>
                  <th>C�digo Insumo</th>
                  <th>Nombre</th>
                  <th>Caracter�sticas</th>
                  <th>N� Presentaci�n</th>
                  <th>M Presentaci�n</th>
                  <th>C�digo Presentaci�n</th>
                  <th>Acci�n</th>
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
                            <label for="modal_codbarras" class="form-label">C�digo de Barras</label>
                            <input type="text"
                                   class="form-control"
                                   id="modal_codbarras"
                                   name="modal_codbarras"
                                   placeholder="C�digo de Barras">
                          </div>

                          <!-- Checkbox Generar Autom�ticamente -->
                          <div class="form-check mt-4">
                            <input class="form-check-input"
                                   type="checkbox"
                                   id="autoGenerate"
                                   name="autoGenerate">
                            <label class="form-check-label" for="autoGenerate">
                              Generar Autom�ticamente
                            </label>
                          </div>
                      
                        
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
  
  <!-- MODAL INGRESO DE INSUMO MANUAL -->
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
            <!-- Rengl�n -->
            <div class="mb-3">
              <label for="renglon" class="form-label">Rengl�n</label>
              <input type="number" class="form-control" id="renglon" name="renglon" required step="1"
                     oninput="this.value = this.value.replace(/[^0-9]/g, '');">
              <div class="invalid-feedback">
                Por favor ingrese el rengl�n (n�mero entero).
              </div>
            </div>

            <!-- C�digo de Insumo -->
            <div class="mb-3">
              <label for="codinsumo" class="form-label">C�digo Insumo</label>
              <input type="number" class="form-control" id="codinsumo" name="codinsumo" required step="1"
                     oninput="this.value = this.value.replace(/[^0-9]/g, '');">
              <div class="invalid-feedback">
                Por favor ingrese el c�digo del insumo.
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

            <!-- Caracter�sticas -->
            <div class="mb-3">
              <label for="caracteristicas" class="form-label">Caracter�sticas</label>
              <textarea class="form-control" id="caracteristicas" name="caracteristicas" rows="3" maxlength="5000" required></textarea>
              <div class="invalid-feedback">
                Por favor ingrese las caracter�sticas.
              </div>
            </div>

            <!-- Nombre Presentaci�n -->
            <div class="mb-3">
              <label for="npresentacion" class="form-label">Nombre Presentaci�n</label>
              <textarea class="form-control" id="npresentacion" name="npresentacion" rows="2" maxlength="5000" required></textarea>
              <div class="invalid-feedback">
                Por favor ingrese el nombre de presentaci�n.
              </div>
            </div>

            <!-- Medida Presentaci�n -->
            <div class="mb-3">
              <label for="mpresentacion" class="form-label">Medida Presentaci�n</label>
              <input type="text" class="form-control" id="mpresentacion" name="mpresentacion" maxlength="255" required>
              <div class="invalid-feedback">
                Por favor ingrese la medida de presentaci�n.
              </div>
            </div>

            <!-- C�digo Presentaci�n -->
            <div class="mb-3">
              <label for="codpresentacion" class="form-label">C�digo Presentaci�n</label>
              <input type="number" class="form-control" id="codpresentacion" name="codpresentacion" required step="1"
                     oninput="this.value = this.value.replace(/[^0-9]/g, '');">
              <div class="invalid-feedback">
                Por favor ingrese el c�digo de presentaci�n.
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

            <!-- Bot�n de env�o -->
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
     document.addEventListener('change', function(e) {
    // Si el checkbox que cambi� es el nuestro...
    if (e.target && e.target.id === 'autoGenerate') {
      const chk = e.target;
      const inp = document.getElementById('modal_codbarras');
      if (!inp) return;   // si no existe a�n, salimos

      if (chk.checked) {
        inp.value = '';    // vac�a el campo ? lo leer�s como null en el servidor
        inp.disabled = true;
      } else {
        inp.disabled = false;
        inp.focus();       // opcional: da foco para que escriban
      }
    }
  });
  
    document.addEventListener('DOMContentLoaded', function() {
      const clearBtn = document.getElementById('clearBtn');
      clearBtn.addEventListener('click', function() {
        document.getElementById('filterForm').reset();
      });
    });

  $(document).ready(function(){
    $('#filterForm').on('submit', function(e) {
      e.preventDefault(); // Evita el env�o normal del formulario
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
              console.error("No se encontr� el tbody en la respuesta AJAX.");
            }
          }
        },
        error: function(xhr, status, error) {
          console.error("Error en la solicitud AJAX: " + error);
        }
      });
    });
  });

    // Limpiar formulario de filtros
    document.addEventListener('DOMContentLoaded', function() {
      const clearBtnModal = document.getElementById('clearBtnModal');
      clearBtnModal.addEventListener('click', function() {
        document.getElementById('filterFormModal').reset();
      });
    });
     // Delegaci�n para el bot�n "Agregar a Existencias" en la tabla
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
    
// Manejo del bot�n "Guardar" en el modal
$('#guardarExistenciaBtnModal').on('click', function() {
    var cantidad = $('#cantidadExistencia').val();
    var precio = $('#precioUnitario').val();
    var codbarras = $('#modal_codbarras').val();

    if (cantidad === "" || precio === "") {
        Swal.fire('Error', 'Complete los campos obligatorios.', 'error');
        return;
    }

    var formData = $('#agregarExistenciaForm').serialize() + '&codbarras=' + encodeURIComponent(codbarras);

    Swal.fire({
        title: '�Est� seguro?',
        text: "�Desea agregar este insumo a existencias con cantidad " + cantidad + " y precio unitario " + precio + "?",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'S�, guardar',
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
                console.error("No se encontr� el tbody en la respuesta AJAX.");
              }
            },
            error: function(xhr, status, error){
              console.error("Error en la solicitud AJAX: " + error);
            }
          });
        });

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

            // Mostrar SweetAlert indicando que se est�n guardando los datos
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
                // Cerrar el modal (aseg�rate de que el id coincida con el de tu modal)
                $('#ingresoManualModal').modal('hide');
                // Mostrar mensaje de �xito y recargar la p�gina
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
                  text: 'No se pudo guardar el insumo. Int�ntalo de nuevo.'
                });
              }
            });

            form.classList.add('was-validated');
          }, false);
        });
    })();
  </script>

</body>

</html>