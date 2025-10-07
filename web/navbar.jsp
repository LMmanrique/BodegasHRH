<aside class="left-sidebar">
  <!-- Sidebar scroll-->
  <div>
    <div class="brand-logo d-flex align-items-center justify-content-between">
      <a href="./index.jsp" class="text-nowrap logo-img">
        <img src="${pageContext.request.contextPath}/assets/images/logos/logo.svg" alt="" />
      </a>
      <script src="${pageContext.request.contextPath}/assets/js/sessionTimeout.js"></script>
      
      <div class="close-btn d-xl-none d-block sidebartoggler cursor-pointer" id="sidebarCollapse">
        <i class="ti ti-x fs-8"></i>
      </div>
    </div>
    <p class="text-center">Sistema Bodegas</p>
    
    <!-- Sidebar navigation-->
    <nav class="sidebar-nav scroll-sidebar" data-simplebar="">
      <ul id="sidebarnav">
        
        <!-- ================================== -->
        <!-- SECCIÓN INICIO -->
        <!-- ================================== -->
        <li class="nav-small-cap">
          <iconify-icon icon="solar:menu-dots-linear" class="nav-small-cap-icon fs-4"></iconify-icon>
          <span class="hide-menu">Inicio</span>
        </li>
        <li class="sidebar-item">
          <a class="sidebar-link" href="./index.jsp" aria-expanded="false">
            <iconify-icon icon="solar:atom-line-duotone"></iconify-icon>
            <span class="hide-menu">Dashboard</span>
          </a>
        </li>
        
        <!-- ================================== -->
        <!-- MÓDULO ALMACÉN -->
        <!-- ================================== -->
        <li>
          <span class="sidebar-divider lg"></span>
        </li>
        <li class="nav-small-cap">
          <iconify-icon icon="solar:menu-dots-linear" class="nav-small-cap-icon fs-4"></iconify-icon>
          <span class="hide-menu">Almacén</span>
        </li>
        
        <!-- Ingreso de Insumos -->
        <li class="sidebar-item">
          <a class="sidebar-link justify-content-between has-arrow" href="javascript:void(0)" aria-expanded="false">
            <div class="d-flex align-items-center gap-3">
              <span class="d-flex">
                <iconify-icon icon="solar:document-linear"></iconify-icon>
              </span>
              <span class="hide-menu">Ingreso de Insumos</span>
            </div>
          </a>
          <ul aria-expanded="false" class="collapse first-level">
            <li class="sidebar-item">
              <a class="sidebar-link justify-content-between" href="agregarfactura.jsp">
                <div class="d-flex align-items-center gap-3">
                  <span class="d-flex">
                    <iconify-icon icon="solar:clipboard-add-linear"></iconify-icon>
                  </span>
                  <span class="hide-menu">Ingresar</span>
                </div>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link justify-content-between" href="consultaringresos.jsp">
                <div class="d-flex align-items-center gap-3">
                  <span class="d-flex">
                    <iconify-icon icon="solar:document-add-linear"></iconify-icon>
                  </span>
                  <span class="hide-menu">Consultar</span>
                </div>
              </a>
            </li>
          </ul>
        </li>
        
        <!-- SIGES -->
        <li class="sidebar-item">
          <a class="sidebar-link justify-content-between has-arrow" href="javascript:void(0)" aria-expanded="false">
            <div class="d-flex align-items-center gap-3">
              <span class="d-flex">
                <iconify-icon icon="solar:delivery-outline"></iconify-icon>
              </span>
              <span class="hide-menu">SIGES</span>
            </div>
          </a>
          <ul aria-expanded="false" class="collapse first-level">
            <li class="sidebar-item">
              <a class="sidebar-link justify-content-between" href="actualizarinsumos.jsp">
                <div class="d-flex align-items-center gap-3">
                  <span class="d-flex">
                    <iconify-icon icon="solar:database-linear"></iconify-icon>
                  </span>
                  <span class="hide-menu">Actualizar Base de Datos</span>
                </div>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link justify-content-between" href="consultarinsumosNEW.jsp">
                <div class="d-flex align-items-center gap-3">
                  <span class="d-flex">
                    <iconify-icon icon="solar:document-add-linear"></iconify-icon>
                  </span>
                  <span class="hide-menu">Consultar</span>
                </div>
              </a>
            </li>
          </ul>
        </li>
        
        <!-- Existencias -->
        <li class="sidebar-item">
          <a class="sidebar-link justify-content-between has-arrow" href="javascript:void(0)" aria-expanded="false">
            <div class="d-flex align-items-center gap-3">
              <span class="d-flex">
                <iconify-icon icon="solar:garage-linear"></iconify-icon>
              </span>
              <span class="hide-menu">Existencias</span>
            </div>
          </a>
          <ul aria-expanded="false" class="collapse first-level">
            <li class="sidebar-item">
              <a class="sidebar-link justify-content-between" href="${pageContext.request.contextPath}/ExistenciaServlet?accion=listar">
                <div class="d-flex align-items-center gap-3">
                  <span class="d-flex">
                    <iconify-icon icon="solar:document-add-linear"></iconify-icon>
                  </span>
                  <span class="hide-menu">Consultar</span>
                </div>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link justify-content-between" href="consultarvencimientos.jsp">
                <div class="d-flex align-items-center gap-3">
                  <span class="d-flex">
                    <iconify-icon icon="solar:clipboard-remove-linear"></iconify-icon>
                  </span>
                  <span class="hide-menu">Próximos a Vencer</span>
                </div>
              </a>
            </li>
          </ul>
        </li>
        
        <!-- Despachos -->
        <li class="sidebar-item">
          <a class="sidebar-link justify-content-between has-arrow" href="javascript:void(0)" aria-expanded="false">
            <div class="d-flex align-items-center gap-3">
              <span class="d-flex">
                <iconify-icon icon="solar:cart-large-4-linear"></iconify-icon>
              </span>
              <span class="hide-menu">Despachos</span>
            </div>
          </a>
          <ul aria-expanded="false" class="collapse first-level">
            <li class="sidebar-item">
              <a class="sidebar-link justify-content-between" href="agregaregreso.jsp">
                <div class="d-flex align-items-center gap-3">
                  <span class="d-flex">
                    <iconify-icon icon="solar:clipboard-add-linear"></iconify-icon>
                  </span>
                  <span class="hide-menu">Ingresar</span>
                </div>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link justify-content-between" href="consultaregresos.jsp">
                <div class="d-flex align-items-center gap-3">
                  <span class="d-flex">
                    <iconify-icon icon="solar:document-add-linear"></iconify-icon>
                  </span>
                  <span class="hide-menu">Consultar</span>
                </div>
              </a>
            </li>
          </ul>
        </li>
        
        <!-- Generar Reportes -->
        <li class="sidebar-item">
          <a class="sidebar-link justify-content-between has-arrow" href="javascript:void(0)" aria-expanded="false">
            <div class="d-flex align-items-center gap-3">
              <span class="d-flex">
                <iconify-icon icon="solar:checklist-linear"></iconify-icon>
              </span>
              <span class="hide-menu">Generar Reportes</span>
            </div>
          </a>
          <ul aria-expanded="false" class="collapse first-level">
            <li class="sidebar-item">
              <a class="sidebar-link justify-content-between" target="_blank" href="generarinformeexistencias.jsp">
                <div class="d-flex align-items-center gap-3">
                  <span class="d-flex">
                    <iconify-icon icon="solar:cloud-download-linear"></iconify-icon>
                  </span>
                  <span class="hide-menu">Informe de Existencias</span>
                </div>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link justify-content-between" target="_blank" href="informemensualinsumos.jsp">
                <div class="d-flex align-items-center gap-3">
                  <span class="d-flex">
                    <iconify-icon icon="solar:cloud-download-linear"></iconify-icon>
                  </span>
                  <span class="hide-menu">KARDEX</span>
                </div>
              </a>
            </li>
          </ul>
        </li>

        <!-- ================================== -->
        <!-- MÓDULO COMPRAS -->
        <!-- ================================== -->
        <li>
          <span class="sidebar-divider lg"></span>
        </li>
        <li class="nav-small-cap">
          <iconify-icon icon="solar:menu-dots-linear" class="nav-small-cap-icon fs-4"></iconify-icon>
          <span class="hide-menu">Compras</span>
        </li>
        
        <!-- Órdenes de Compra -->
        <li class="sidebar-item">
          <a class="sidebar-link justify-content-between has-arrow" href="javascript:void(0)" aria-expanded="false">
            <div class="d-flex align-items-center gap-3">
              <span class="d-flex">
                <iconify-icon icon="solar:wallet-outline"></iconify-icon>
              </span>
              <span class="hide-menu">Órdenes de Compra</span>
            </div>
          </a>
          <ul aria-expanded="false" class="collapse first-level">
            <li class="sidebar-item">
              <a class="sidebar-link justify-content-between" href="crearorden.jsp">
                <div class="d-flex align-items-center gap-3">
                  <span class="d-flex">
                    <iconify-icon icon="solar:clipboard-add-linear"></iconify-icon>
                  </span>
                  <span class="hide-menu">Crear Orden</span>
                </div>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link justify-content-between" href="consultarordenes.jsp">
                <div class="d-flex align-items-center gap-3">
                  <span class="d-flex">
                    <iconify-icon icon="solar:document-text-linear"></iconify-icon>
                  </span>
                  <span class="hide-menu">Consultar Órdenes</span>
                </div>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link justify-content-between" href="aprobarordenes.jsp">
                <div class="d-flex align-items-center gap-3">
                  <span class="d-flex">
                    <iconify-icon icon="solar:check-circle-linear"></iconify-icon>
                  </span>
                  <span class="hide-menu">Aprobar Órdenes</span>
                </div>
              </a>
            </li>
          </ul>
        </li>
        
        <!-- Proveedores -->
        <li class="sidebar-item">
          <a class="sidebar-link justify-content-between has-arrow" href="javascript:void(0)" aria-expanded="false">
            <div class="d-flex align-items-center gap-3">
              <span class="d-flex">
                <iconify-icon icon="solar:users-group-two-rounded-outline"></iconify-icon>
              </span>
              <span class="hide-menu">Proveedores</span>
            </div>
          </a>
          <ul aria-expanded="false" class="collapse first-level">
            <li class="sidebar-item">
              <a class="sidebar-link justify-content-between" href="agregarproveedores.jsp">
                <div class="d-flex align-items-center gap-3">
                  <span class="d-flex">
                    <iconify-icon icon="solar:user-plus-linear"></iconify-icon>
                  </span>
                  <span class="hide-menu">Agregar Proveedor</span>
                </div>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link justify-content-between" href="consultarproveedores.jsp">
                <div class="d-flex align-items-center gap-3">
                  <span class="d-flex">
                    <iconify-icon icon="solar:users-group-rounded-linear"></iconify-icon>
                  </span>
                  <span class="hide-menu">Consultar Proveedores</span>
                </div>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link justify-content-between" href="evaluarproveedores.jsp">
                <div class="d-flex align-items-center gap-3">
                  <span class="d-flex">
                    <iconify-icon icon="solar:star-linear"></iconify-icon>
                  </span>
                  <span class="hide-menu">Evaluar Proveedores</span>
                </div>
              </a>
            </li>
          </ul>
        </li>
        
        <!-- Cotizaciones -->
        <li class="sidebar-item">
          <a class="sidebar-link justify-content-between has-arrow" href="javascript:void(0)" aria-expanded="false">
            <div class="d-flex align-items-center gap-3">
              <span class="d-flex">
                <iconify-icon icon="solar:calculator-linear"></iconify-icon>
              </span>
              <span class="hide-menu">Cotizaciones</span>
            </div>
          </a>
          <ul aria-expanded="false" class="collapse first-level">
            <li class="sidebar-item">
              <a class="sidebar-link justify-content-between" href="solicitarcotizacion.jsp">
                <div class="d-flex align-items-center gap-3">
                  <span class="d-flex">
                    <iconify-icon icon="solar:document-add-linear"></iconify-icon>
                  </span>
                  <span class="hide-menu">Solicitar Cotización</span>
                </div>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link justify-content-between" href="consultarcotizaciones.jsp">
                <div class="d-flex align-items-center gap-3">
                  <span class="d-flex">
                    <iconify-icon icon="solar:document-text-linear"></iconify-icon>
                  </span>
                  <span class="hide-menu">Consultar Cotizaciones</span>
                </div>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link justify-content-between" href="compararcotizaciones.jsp">
                <div class="d-flex align-items-center gap-3">
                  <span class="d-flex">
                    <iconify-icon icon="solar:scale-linear"></iconify-icon>
                  </span>
                  <span class="hide-menu">Comparar Cotizaciones</span>
                </div>
              </a>
            </li>
          </ul>
        </li>
        
        <!-- Pagos y Facturación -->
        <li class="sidebar-item">
          <a class="sidebar-link justify-content-between has-arrow" href="javascript:void(0)" aria-expanded="false">
            <div class="d-flex align-items-center gap-3">
              <span class="d-flex">
                <iconify-icon icon="solar:card-linear"></iconify-icon>
              </span>
              <span class="hide-menu">Pagos y Facturación</span>
            </div>
          </a>
          <ul aria-expanded="false" class="collapse first-level">
            <li class="sidebar-item">
              <a class="sidebar-link justify-content-between" href="registrarpagos.jsp">
                <div class="d-flex align-items-center gap-3">
                  <span class="d-flex">
                    <iconify-icon icon="solar:dollar-linear"></iconify-icon>
                  </span>
                  <span class="hide-menu">Registrar Pagos</span>
                </div>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link justify-content-between" href="consultarpagos.jsp">
                <div class="d-flex align-items-center gap-3">
                  <span class="d-flex">
                    <iconify-icon icon="solar:bill-list-linear"></iconify-icon>
                  </span>
                  <span class="hide-menu">Consultar Pagos</span>
                </div>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link justify-content-between" href="cuentasporpagar.jsp">
                <div class="d-flex align-items-center gap-3">
                  <span class="d-flex">
                    <iconify-icon icon="solar:clock-circle-linear"></iconify-icon>
                  </span>
                  <span class="hide-menu">Cuentas por Pagar</span>
                </div>
              </a>
            </li>
          </ul>
        </li>
        
        <!-- Reportes de Compras -->
        <li class="sidebar-item">
          <a class="sidebar-link justify-content-between has-arrow" href="javascript:void(0)" aria-expanded="false">
            <div class="d-flex align-items-center gap-3">
              <span class="d-flex">
                <iconify-icon icon="solar:chart-linear"></iconify-icon>
              </span>
              <span class="hide-menu">Reportes de Compras</span>
            </div>
          </a>
          <ul aria-expanded="false" class="collapse first-level">
            <li class="sidebar-item">
              <a class="sidebar-link justify-content-between" target="_blank" href="reportecompras.jsp">
                <div class="d-flex align-items-center gap-3">
                  <span class="d-flex">
                    <iconify-icon icon="solar:cloud-download-linear"></iconify-icon>
                  </span>
                  <span class="hide-menu">Reporte de Compras</span>
                </div>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link justify-content-between" target="_blank" href="reporteproveedores.jsp">
                <div class="d-flex align-items-center gap-3">
                  <span class="d-flex">
                    <iconify-icon icon="solar:cloud-download-linear"></iconify-icon>
                  </span>
                  <span class="hide-menu">Reporte de Proveedores</span>
                </div>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link justify-content-between" target="_blank" href="reportepresupuesto.jsp">
                <div class="d-flex align-items-center gap-3">
                  <span class="d-flex">
                    <iconify-icon icon="solar:cloud-download-linear"></iconify-icon>
                  </span>
                  <span class="hide-menu">Control Presupuestario</span>
                </div>
              </a>
            </li>
          </ul>
        </li>

      </ul>
    </nav>
    <!-- End Sidebar navigation -->
  </div>
  <!-- End Sidebar scroll-->
</aside>