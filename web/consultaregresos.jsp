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
  <title>Almacén General - Consulta de Egresos</title>

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
              <h1 class="card-title fw-semibold mb-4">Consulta de Egresos</h1>
              <table id="tablaEgresos" class="table table-striped table-bordered" style="width:100%">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>Tipo</th>
                    <th>Fecha</th>
                    <th>Detalles</th>
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

  <!-- Modal Detalle Egreso -->
  <div class="modal fade" id="modalDetalleEgreso" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Detalle de Egreso</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          <div id="detalleCabeceraEgreso"></div>
          <div id="detalleEspecificoEgreso" class="mt-3"></div>
          <table class="table mt-3">
            <thead>
              <tr>
                <th>Insumo</th><th>Cantidad</th><th>Precio</th><th>Subtotal</th>
              </tr>
            </thead>
            <tbody id="detalleItemsEgreso"></tbody>
          </table>
        </div>
        <div class="modal-footer">
          <c:if test="${sessionScope.usuario.cargo == 'ADMIN'}">
            <button type="button" id="btnAnularEgreso" class="btn btn-danger">
              <iconify-icon icon="solar:clipboard-remove-linear" width="30" height="30"></iconify-icon> Anular
            </button>
          </c:if>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
            <iconify-icon icon="solar:close-square-linear" width="30" height="30"></iconify-icon> Cerrar
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
  $(document).ready(function() {
    var servletUrl = '<c:url value="/EgresosServlet"/>';
    var servletUrl2 = '<c:url value="/NuevoMovimientoServlet"/>';
    // Antes de inicializar la tabla:
    var detallesCache = {};         // { [id]: { html: string, text: string } }
    var detallesEnProgreso = {};    // evita llamadas duplicadas por fila

    var table = $('#tablaEgresos').DataTable({
      ajax: {
        url: servletUrl + '?action=list',
        dataSrc: ''
      },
      columns: [
        { data: 'id' },
        { data: 'tipo' },
        {
          data: 'fecha',
          render: function(d) {
            return d;
          }
        },
        {
          data: null,
          orderable: false,
          searchable: true,
          render: function(data, type, row) {
            var id = row.id;
            var cached = detallesCache[id];

            // Para filtrado/ordenamiento, devolver solo texto (esto es lo que DataTables indexa para el buscador)
            if (type === 'filter' || type === 'sort') {
              return cached ? cached.text : '';
            }

            // Para display, si ya está en caché mostramos el HTML
            if (cached) {
              return cached.html;
            }

            // Si no está en caché y no hay fetch en progreso, lo pedimos
            if (!detallesEnProgreso[id]) {
              detallesEnProgreso[id] = true;
              $.getJSON(servletUrl + '?action=especifico&id=' + id, function(espec) {
                var detalleHtml =
                  '<div class="small">' +
                    '<div><strong>Req:</strong> ' + (espec.noRequisicion || '-') + '</div>' +
                    '<div><strong>Serv:</strong> ' + (espec.servicio || '-') + '</div>' +
                    '<div><strong>Obs:</strong> ' + (espec.observaciones || '-') + '</div>' +
                  '</div>';

                var detalleText = [
                  espec.noRequisicion || '',
                  espec.servicio || '',
                  espec.observaciones || ''
                ].join(' ').trim();

                detallesCache[id] = { html: detalleHtml, text: detalleText };
                detallesEnProgreso[id] = false;

                // Invalida la fila para que se actualice la celda y el índice de búsqueda
                var rowIdx = table.row(function(idx, d){ return d.id === id; }).index();
                if (rowIdx !== undefined && rowIdx !== null) {
                  // Forzamos re-render de la celda y reindexación para búsqueda
                  table.cell({ row: rowIdx, column: 3 }).data(null);
                  table.rows(rowIdx).invalidate().draw(false);
                } else {
                  table.rows().invalidate().draw(false);
                }
              });
            }

            // Mientras carga
            return '<div class="small text-muted">Cargando...</div>';
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
            return '<button class="btn btn-primary btn-sm btn-detalle">' +
                   '<iconify-icon icon="solar:eye-scan-linear" width="25" height="25"></iconify-icon> Ver</button>';
          }
        }
      ],
      order: [[2, 'desc']]
    });

    // Al hacer click en Ver
    $('#tablaEgresos tbody').on('click', '.btn-detalle', function() {
      var data = table.row($(this).closest('tr')).data();
      var id   = data.id;

      // Cabecera
      $.getJSON(servletUrl + '?action=get&id=' + id, function(det) {
        $('#detalleCabeceraEgreso').html(
          '<p><strong>Tipo:</strong> ' + det.tipo + '</p>' +
          '<p><strong>Fecha:</strong> ' + det.fecha + ' ' + det.hora + '</p>'
        );
      });

      // Específico
      $('#detalleEspecificoEgreso').empty();
      $.getJSON(servletUrl + '?action=especifico&id=' + id, function(espec) {
        // Tu DTO EgresoEspecifico ahora expone noRequisicion, servicio y observaciones
        var html = '<h6>Datos adicionales</h6><dl class="row">';
        html += '<dt class="col-sm-3">No. Requisición:</dt><dd class="col-sm-9">' + espec.noRequisicion + '</dd>';
        html += '<dt class="col-sm-3">Servicio:</dt><dd class="col-sm-9">' + espec.servicio + '</dd>';
        html += '<dt class="col-sm-3">Observaciones:</dt><dd class="col-sm-9">' + espec.observaciones + '</dd>';
        html += '</dl>';
        $('#detalleEspecificoEgreso').html(html);
      });

      // Ítems
      $.getJSON(servletUrl + '?action=items&id=' + id, function(items) {
        var $body = $('#detalleItemsEgreso').empty();
        items.forEach(function(it) {
          $body.append(
            '<tr>' +
            '<td>' + it.insumo + '</td>' +
            '<td>' + it.cantidad + '</td>' +
            '<td>Q.' + it.precioUnitario.toFixed(2) + '</td>' +
            '<td>Q.' + (it.cantidad * it.precioUnitario).toFixed(2) + '</td>' +
            '</tr>'
          );
        });
      });

      $('#btnAnularEgreso').data('id', id);
      $('#modalDetalleEgreso').modal('show');
    });

    // Anular
$('#btnAnularEgreso').click(function() {
        var id = $(this).data('id');
        Swal.fire({
          title: '¿Anular movimiento?',
          showCancelButton: true,
          confirmButtonText: 'Sí'
        }).then(function(r) {
          if (!r.isConfirmed) return;
          $.post(servletUrl2, { action: 'anular', id: id }, function(resp) {
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