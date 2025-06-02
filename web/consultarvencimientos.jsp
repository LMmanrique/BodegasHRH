<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Verifica sesión
    if (session == null || session.getAttribute("usuario") == null) {
        response.sendRedirect("authentication-login.jsp");
        return;
    }
%>
<!doctype html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Almacén General - Consulta de Ingresos</title>

  <!-- jQuery y Quagga -->
  <script src="${pageContext.request.contextPath}/assets/js/jquery-3.7.1.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/quagga.min.js"></script>

  <!-- CSS: Bootstrap, DataTables, Estilos -->
  <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/assets/css/datatables.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styles.min.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/sweetAlert2/sweetalert2.min.css" />
</head>
<body>
  <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6"
       data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed">

    <jsp:include page="/apptopstrip.jsp"/>
    <jsp:include page="/navbar.jsp"/>

    <div class="body-wrapper">
      <div class="body-wrapper-inner">
        <div class="container-fluid">
          <div class="card">
            <div class="card-body">
              <h1 class="card-title fw-semibold mb-4">Consulta de Vencimientos</h1>
              <table id="tablaVencimientos" class="table table-striped table-bordered" style="width:100%">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>Insumo</th>
                    <th>Características</th>
                    <th>Fecha Vencimiento</th>
                    <th>Lote</th>
                    <th>Cantidad</th>
                    <th>Usuario</th>
                    <th>Creado el</th>
                  </tr>
                </thead>
                <tbody></tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Scripts: Bootstrap, DataTables, Plugins, App -->
  <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/datatables.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/sidebarmenu.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/app.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/libs/apexcharts/dist/apexcharts.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/libs/simplebar/dist/simplebar.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/dashboard.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/iconify-icon.min"></script>
  <script src="${pageContext.request.contextPath}/assets/sweetAlert2/sweetalert2.all.min.js"></script>

<style>
  /* Si quieres colores personalizados, en lugar de Bootstrap */
  .venc-rojo   { background-color: #f8d7da !important; }
  .venc-amarillo { background-color: #fff3cd !important; }
  .venc-verde  { background-color: #d4edda !important; }
</style>

<script>
$(document).ready(function() {
  $('#tablaVencimientos').DataTable({
    ajax: {
      url: '${pageContext.request.contextPath}/VencimientosServlet',
      dataSrc: ''
    },
    columns: [
      { data: 'id' },
      { data: 'insumo' },
      { data: 'caracteristicas' },
      { data: 'fechaVencimiento' },
      { data: 'lote' },
      { data: 'cantidad' },
      { data: 'usuario' },
      { data: 'creadoEn' }
    ],
    order: [[3, 'asc']],
    createdRow: function(row, data) {
      if (!data.fechaVencimiento) return;
      // Calcula diferencia en meses
      var hoy    = new Date();
      var vence  = new Date(data.fechaVencimiento);
      var meses  = (vence.getFullYear() - hoy.getFullYear()) * 12
                   + (vence.getMonth() - hoy.getMonth());
      // Aplica clases según rango
      if (meses < 6) {
        $(row).addClass('table-danger');     // o '.venc-rojo'
      }
      else if (meses < 12) {
        $(row).addClass('table-warning');    // o '.venc-amarillo'
      }
      else {
        $(row).addClass('table-success');    // o '.venc-verde'
      }
    }
  });
});
</script>
</body>
</html>
