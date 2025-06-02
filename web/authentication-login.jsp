<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Almacen</title>
        <link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/logos/favicon.png" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styles.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/sweetAlert2/sweetalert2.min.css">
    </head>
  <body>
    <!--  Body Wrapper -->
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
         data-sidebar-position="fixed" data-header-position="fixed">
      <div class="position-relative overflow-hidden text-bg-light min-vh-100 d-flex align-items-center justify-content-center">
        <div class="d-flex align-items-center justify-content-center w-100">
          <div class="row justify-content-center w-100">
            <div class="col-md-8 col-lg-6 col-xxl-3">
              <div class="card mb-0">
                <div class="card-body">
                  <a href="#" class="text-nowrap logo-img text-center d-block py-3 w-100">
                    <img src="${pageContext.request.contextPath}/assets/images/logos/logo.svg" alt="">
                  </a>
                  <p class="text-center">Sistema Bodegas</p>
                  <!-- Se agrega el formulario con action y method -->
                  <form action="LoginServlet" method="post">
                    <div class="mb-3">
                      <label for="txtUsuario" class="form-label">Usuario</label>
                      <input type="text" name="txtUsuario" class="form-control" id="txtUsuario" placeholder="Ingresa tu usuario" required>
                    </div>
                    <div class="mb-4">
                      <label for="txtPassword" class="form-label">Contraseña</label>
                      <input type="password" name="txtPassword" class="form-control" id="txtPassword" placeholder="Ingresa tu contraseña" required>
                    </div>
                    <!-- Botón de envío -->
                    <input type="submit" value="Iniciar Sesión" class="btn btn-primary w-100 py-8 fs-4 mb-4 rounded-2">
                  </form>
                  <!-- Mostrar mensaje de error (si existe) -->
                  
                  <%
                    if(request.getAttribute("error") != null){
                  %>
                    <div style="color: red; text-align: center;">
                      <%= request.getAttribute("error") %>
                    </div>
                  <%
                    }
                  %>
                  <div class="d-flex align-items-center justify-content-center">
                    <p class="fs-4 mb-0 fw-bold">Problemas con tu usuario?</p>
                    <!-- Se agrega el id "soporte" y se evita la navegación con href="#" -->
                    <a id="soporte" class="text-primary fw-bold ms-2" href="#">Soporte</a>
                  </div>
                  <script>
                    document.addEventListener('DOMContentLoaded', function(){
                      const soporteLink = document.getElementById('soporte');
                      soporteLink.addEventListener('click', function(e){
                        e.preventDefault(); // Evita la acción por defecto del enlace
                        Swal.fire({
                          title: 'Soporte',
                          html: 'Si necesitas ayuda contacta a la <strong>extensión 259</strong>.',
                          icon: 'info',
                          confirmButtonText: 'Aceptar'
                        });
                      });
                    });
                  </script>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <script src="${pageContext.request.contextPath}/assets/libs/jquery/dist/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <!-- solar icons -->
     <script src="${pageContext.request.contextPath}/assets/js/iconify-icon.min"></script>
    <script src="${pageContext.request.contextPath}/assets/sweetAlert2/sweetalert2.all.min.js"></script>
  </body>
</html>