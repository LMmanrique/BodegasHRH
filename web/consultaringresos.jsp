<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
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
              <h1 class="card-title fw-semibold mb-4">Consulta de Ingresos</h1>
              <table id="tablaIngresos" class="table table-striped table-bordered" style="width:100%">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>Tipo</th>
                    <th>Fecha</th>
                    <th>Usuario</th>
                    <th>Total</th>
                    <th>Acciones</th>
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

  <!-- Modal Detalle -->
  <div class="modal fade" id="modalDetalle" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Detalle de Movimiento</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          <div id="detalleCabecera"></div>
          <div id="detalleEspecifico" class="mt-3"></div>
          <table class="table mt-3">
            <thead>
              <tr>
                <th>Insumo</th><th>Cantidad</th><th>Precio</th><th>Subtotal</th>
              </tr>
            </thead>
            <tbody id="detalleItems"></tbody>
          </table>
        </div>
        <div class="modal-footer">
          <c:if test="${sessionScope.usuario.cargo == 'ADMIN'}">
            <button type="button" id="btnAnular" class="btn btn-danger d-flex align-items-center justify-content-center">
              <iconify-icon icon="solar:clipboard-remove-linear" width="30" height="30" style="margin-right:8px;"></iconify-icon>
              Anular
            </button>
          </c:if>
          <button type="button" class="btn btn-secondary d-flex align-items-center justify-content-center" data-bs-dismiss="modal">
            <iconify-icon icon="solar:close-square-linear" width="30" height="30" style="margin-right:8px;"></iconify-icon>
            Cerrar
          </button>
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

  <script>
    // --- Helpers de formato ---
    function formatDateYMD(dateStr) {
      if (!dateStr) return '';
      var parts = dateStr.split(' ')[0].split('-');
      return parts[2].padStart(2,'0') + '/' +
             parts[1].padStart(2,'0') + '/' +
             parts[0];
    }

    $(document).ready(function() {
      console.log('Inicializando tabla de ingresos');

      var servletUrl = '<c:url value="/NuevoMovimientoServlet"/>';
      var table = $('#tablaIngresos').DataTable({
        ajax: {
          url: servletUrl + '?action=list',
          dataSrc: '',
          error: function(xhr) {
            console.error('Error AJAX:', xhr.status, xhr.responseText);
          }
        },
        columns: [
          { data: 'id' },
          { data: 'tipo' },
          {
            data: 'fecha',
            render: function(data) {
              return formatDateYMD(data);
            }
          },
          { data: 'usuario' },
          {
            data: 'total',
            render: $.fn.dataTable.render.number(',', '.', '', '')
          },
          {
            data: null,
            orderable: false,
            render: function() {
              return '<button class="btn btn-sm btn-primary btn-detalle" style="width:60px;">' +
                     '<iconify-icon icon="solar:eye-scan-linear" width="25" height="25"></iconify-icon><br/>Ver</button>';
            }
          }
        ],
        order: [[2, 'desc']]
      });

      // Click en “Ver detalle”
      $('#tablaIngresos tbody').on('click', '.btn-detalle', function() {
        var data = table.row($(this).closest('tr')).data(),
            id   = data.id;

        // Cabecera
        $.getJSON(servletUrl + '?action=get&id=' + id, function(det) {
          $('#detalleCabecera').html(
            '<p><strong>Tipo:</strong> ' + det.tipo + '</p>' +
            '<p><strong>Fecha:</strong> ' + formatDateYMD(det.fecha) + ' ' + det.hora + '</p>'
          );
        });

        // Específico
        $('#detalleEspecifico').empty();
        $.getJSON(servletUrl + '?action=especifico&id=' + id, function(espec) {
          if (espec.datos) {
            var html = '<h6>Datos adicionales (' + espec.tipo + ')</h6><dl class="row">';
            $.each(espec.datos, function(k, v) {
              html += '<dt class="col-sm-3">' + k.replace(/_/g,' ') + ':</dt>' +
                      '<dd class="col-sm-9">' + v + '</dd>';
            });
            html += '</dl>';
            $('#detalleEspecifico').html(html);
          }
        });

        // Ítems
        $.getJSON(servletUrl + '?action=items&id=' + id, function(items) {
          var $b = $('#detalleItems').empty();
          items.forEach(function(it) {
            $b.append(
              '<tr>' +
              '<td>' + it.insumo + '</td>' +
              '<td>' + it.cantidad + '</td>' +
              '<td>Q.' + it.precioUnitario.toFixed(2) + '</td>' +
              '<td>Q.' + (it.cantidad * it.precioUnitario).toFixed(2) + '</td>' +
              '</tr>'
            );
          });
        });

        $('#btnAnular').data('id', id);
        $('#modalDetalle').modal('show');
      });

      // Botón Anular
      $('#btnAnular').click(function() {
        var id = $(this).data('id');
        Swal.fire({
          title: '¿Anular movimiento?',
          showCancelButton: true,
          confirmButtonText: 'Sí'
        }).then(function(r) {
          if (!r.isConfirmed) return;
          $.post(servletUrl, { action: 'anular', id: id }, function(resp) {
            if (resp.success) {
              Swal.fire('Anulado','','success');
              table.ajax.reload();
              $('#modalDetalle').modal('hide');
            } else {
              Swal.fire('Error', resp.message || '', 'error');
            }
          });
        });
      });
    });
  </script>
</body>
</html>
