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
    <jsp:include page="/navbar.jsp" />
    
    <div class="body-wrapper">
      <div class="body-wrapper-inner">
        <div class="container-fluid">
          <div class="card">
            <div class="card-body">
              <div class="container mt-4">
                <h1 class="mb-4">Listado de Insumos</h1>
                <!-- Formulario de Filtros -->
                <form id="filterForm" class="row g-3 mb-4" method="get" action="${pageContext.request.contextPath}/ListarInsumosServlet">
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

                <!-- Tabla de Resultados -->
                <div id="tablaInsumosContainer" class="table-responsive">
                
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
                        <th>Código Presentación</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="insumo" items="${listaInsumos}">
                        <tr>
                          <td style="display:none;">${existencia.id}</td>
                          <td>${insumo.renglon}</td>
                          <td>${insumo.codinsumo}</td>
                          <td>${insumo.nombre}</td>
                          <td>${insumo.caracteristicas}</td>
                          <td>${insumo.npresentacion}</td>
                          <td>${insumo.mpresentacion}</td>
                          <td>${insumo.codpresentacion}</td>
                        </tr>
                      </c:forEach>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>
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
  <script>
    $(document).ready(function(){
        $('#filterForm').on('submit', function(e){
            e.preventDefault(); // Evita el envío normal del formulario
            $.ajax({
                url: $(this).attr('action'),
                type: 'GET',
                data: $(this).serialize(),
                success: function(data){
                    // Supongamos que el servlet devuelve el HTML completo de la tabla o la parte de la tabla
                    // Actualizamos el contenedor de la tabla
                    // Aquí se asume que el servlet "ListarInsumosServlet" reenvía a "listarInsumos.jsp"
                    // y que puedes extraer el contenido del div con id "tablaInsumosContainer"
                    var nuevoContenido = $(data).find('#tablaInsumosContainer').html();
                    if(nuevoContenido){
                        $('#tablaInsumosContainer').html(nuevoContenido);
                    } else {
                        // Si no se encuentra, actualiza el contenedor completo
                        $('#tablaInsumosContainer').html(data);
                    }
                },
                error: function(xhr, status, error){
                    console.error("Error en la solicitud AJAX: " + error);
                }
            });
        });
    });
  </script>
  <script>
  document.addEventListener('DOMContentLoaded', function() {
    const clearBtn = document.getElementById('clearBtn');
    clearBtn.addEventListener('click', function() {
      // Reinicia el formulario, limpiando todos los campos
      document.getElementById('filterForm').reset();
    });
  });
</script>
</body>
</html>