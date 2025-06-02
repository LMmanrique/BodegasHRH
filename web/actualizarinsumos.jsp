<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // El objeto session ya está disponible en el JSP
    if (session == null || session.getAttribute("usuario") == null) {
        response.sendRedirect("authentication-login.jsp");
        return;
    }
%>
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
      <!-- Header Start -->
      <!-- Puedes incluir aquí tu header si lo tienes -->
      <!-- Header End -->
      <div class="body-wrapper-inner">
        <div class="container-fluid">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title fw-semibold mb-4">Subir Archivo CSV</h5>
              <form action="${pageContext.request.contextPath}/ActualizarInsumos" method="post" enctype="multipart/form-data">
                <div class="mb-3">
                  <label for="csvFile" class="form-label">Selecciona el archivo CSV:</label>
                  <input type="file" class="form-control" name="csvFile" id="csvFile" accept=".csv" required>
                </div>
                <button type="submit" class="btn btn-primary">
                    <div class="d-flex flex-column align-items-center">
                      <iconify-icon icon="solar:cloud-upload-linear" width="32" height="32"></iconify-icon>
                      <span>Subir CSV</span>
                    </div>
                </button>
              </form>
              <!-- Sección para mostrar mensaje (opcional) -->
              <c:if test="${not empty mensaje}">
                <div class="alert alert-info mt-3" role="alert">
                  ${mensaje}
                </div>
              </c:if>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <script>
    document.addEventListener('DOMContentLoaded', function() {
      // Selecciona el formulario por su acción (puedes ajustar si tienes un id específico)
      const form = document.querySelector('form[action="${pageContext.request.contextPath}/ActualizarInsumos"]');

      form.addEventListener('submit', function(e) {
        // Muestra el SweetAlert2 de carga
        Swal.fire({
          title: 'Cargando...',
          html: 'Por favor, espere mientras se procesa el archivo',
          allowOutsideClick: false,
          didOpen: () => {
            Swal.showLoading();
          }
        });
      });
    });
  </script>
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
  // Cargar localmente los iconos desde solar.json
  fetch('${pageContext.request.contextPath}/assets/icons/solar.json')
    .then(response => response.json())
    .then(data => {
      Iconify.addCollection(data); // Añadir colección solar al Iconify
    })
    .catch(err => console.error("Error cargando iconos:", err));
</script>
</body>

</html>