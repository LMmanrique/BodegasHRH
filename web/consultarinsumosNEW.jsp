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
  <title>Consultar Insumos - Almacen General</title>
  <link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/logos/favicon.png" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styles.min.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/sweetAlert2/sweetalert2.min.css">
  <!-- DataTables CSS -->
  <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
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
                <h1 class="mb-4">
                  <i class="ti ti-package me-2"></i>Consultar Insumos
                </h1>
                
                <div class="alert alert-info" role="alert">
                  <i class="ti ti-info-circle me-2"></i>
                  <strong>Catálogo de Insumos:</strong> Busque y consulte información detallada de todos los insumos disponibles en el sistema.
                </div>

                <!-- Tabla de Insumos -->
                <div class="table-responsive">
                  <table id="tablaInsumosNEW" class="table table-striped table-hover" style="width:100%">
                    <thead class="table-dark">
                      <tr>
                        <th>ID</th>
                        <th>Renglón</th>
                        <th>Código</th>
                        <th>Nombre</th>
                        <th>Características</th>
                        <th>Presentación</th>
                        <th>Medida</th>
                        <th>Cód. Presentación</th>
                      </tr>
                    </thead>
                    <tbody>
                      <!-- Los datos se cargan dinámicamente via AJAX -->
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
  
  <!-- DataTables JS -->
  <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
  <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>

  <script>
    $(document).ready(function() {
      $('#tablaInsumosNEW').DataTable({
        processing: true,
        serverSide: true,
        pageLength: 50,
        lengthMenu: [[25, 50, 100, 200], [25, 50, 100, 200]],
        ajax: {
          url: '${pageContext.request.contextPath}/ListarInsumoNEWServlet',
          type: 'POST',
          error: function(xhr, error, code) {
            console.log('Error en AJAX:', error);
            Swal.fire({
              icon: 'error',
              title: 'Error de conexión',
              text: 'No se pudieron cargar los datos. Verifique su conexión.',
              confirmButtonColor: '#d33'
            });
          }
        },
        columns: [
          { data: 0, title: "ID", width: "5%" },
          { data: 1, title: "Renglón", width: "8%" },
          { data: 2, title: "Código", width: "10%" },
          { data: 3, title: "Nombre", width: "25%" },
          { data: 4, title: "Características", width: "25%" },
          { data: 5, title: "Presentación", width: "12%" },
          { data: 6, title: "Medida", width: "10%" },
          { data: 7, title: "Cód. Presentación", width: "5%" }
        ],
        language: {
          processing: "Procesando...",
          search: "Buscar:",
          lengthMenu: "Mostrar _MENU_ registros",
          info: "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
          infoEmpty: "Mostrando registros del 0 al 0 de un total de 0 registros",
          infoFiltered: "(filtrado de un total de _MAX_ registros)",
          loadingRecords: "Cargando...",
          zeroRecords: "No se encontraron resultados",
          emptyTable: "No hay datos disponibles en la tabla",
          paginate: {
            first: "Primero",
            previous: "Anterior",
            next: "Siguiente",
            last: "Último"
          }
        },
        dom: '<"row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-6"f>>' +
             '<"row"<"col-sm-12"tr>>' +
             '<"row"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7"p>>',
        responsive: true,
        order: [[0, 'asc']]
      });
    });
  </script>
</body>
</html>