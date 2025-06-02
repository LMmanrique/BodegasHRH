<%
    // El objeto session ya está disponible en el JSP
    if (session == null || session.getAttribute("usuario") == null) {
        response.sendRedirect("authentication-login.jsp");
        return;
    }
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${not empty listaExistencias}">
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
        <th>Código Barras</th>
        <th>Acciones</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="existencia" items="${listaExistencias}">
        <tr>
          <td style="display:none;">${existencia.id}</td>
          <td>${existencia.renglon}</td>
          <td>${existencia.codinsumo}</td>
          <td>${existencia.nombre}</td>
          <td>${existencia.caracteristicas}</td>
          <td>${existencia.npresentacion}</td>
          <td>${existencia.mpresentacion}</td>
          <td>${existencia.codbarras}</td>
          <td>
            <button type="button" class="btn btn-success btn-sm flex-fill text-white agregarExistenciaBtn"
              data-id="${existencia.id}"
              data-renglon="${existencia.renglon}"
              data-codinsumo="${existencia.codinsumo}"
              data-nombre="${existencia.nombre}"
              data-caracteristicas="${existencia.caracteristicas}"
              data-npresentacion="${existencia.npresentacion}"
              data-mpresentacion="${existencia.mpresentacion}"
              data-codbarras="${existencia.codbarras}">
              <div class="d-flex flex-column align-items-center">
                <iconify-icon icon="solar:clipboard-add-linear" width="24" height="24" class="mb-1"></iconify-icon>
                <span>Agregar</span>
              </div>
            </button>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</c:if>
<c:if test="${empty listaExistencias}">
  <p class="text-center mt-3">No hay registros para mostrar.</p>
</c:if>