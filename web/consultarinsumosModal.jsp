<%
    // El objeto session ya está disponible en el JSP
    if (session == null || session.getAttribute("usuario") == null) {
        response.sendRedirect("authentication-login.jsp");
        return;
    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <table class="table table-striped table-bordered">
              <thead class="table-dark">
                <tr>
                  <th>ID</th>
                  <th>Renglón</th>
                  <th>Código Insumo</th>
                  <th>Nombre</th>
                  <th>Características</th>
                  <th>N° Presentación</th>
                  <th>M Presentación</th>
                  <th>Código Presentación</th>
                  <th>Acción</th>
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