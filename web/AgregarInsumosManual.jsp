<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Verificar si el usuario está autenticado
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
  <title>Almacén General - Agregar Insumo Manual</title>
  <link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/logos/favicon.png" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styles.min.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/sweetAlert2/sweetalert2.min.css">
</head>
<body>
  <!-- Contenedor principal -->
  <div class="card-body">
    <!-- Formulario con validaciones Bootstrap -->
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

  <!-- Scripts JS -->
  <script src="${pageContext.request.contextPath}/assets/libs/jquery/dist/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/sidebarmenu.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/app.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/libs/apexcharts/dist/apexcharts.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/libs/simplebar/dist/simplebar.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/dashboard.js"></script>
 
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
