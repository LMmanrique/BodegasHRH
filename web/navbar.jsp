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
            <!-- ---------------------------------- -->
            <!-- Dashboard -->
            <!-- ---------------------------------- -->
            <li>
              <span class="sidebar-divider lg"></span>
            </li>
            <li class="nav-small-cap">
              <iconify-icon icon="solar:menu-dots-linear" class="nav-small-cap-icon fs-4"></iconify-icon>
              <span class="hide-menu">Almacen</span>
            </li>
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
                    <a class="sidebar-link justify-content-between" target="" href="consultaringresos.jsp">
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
                    <a class="sidebar-link justify-content-between" href="consultarinsumos.jsp">
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
                    <a class="sidebar-link justify-content-between"  href="${pageContext.request.contextPath}/ExistenciaServlet?accion=listar">
                      <div class="d-flex align-items-center gap-3">
                        <span class="d-flex">
                          <iconify-icon icon="solar:document-add-linear"></iconify-icon>
                        </span>
                        <span class="hide-menu">Consultar</span>
                      </div>
                    </a>
                </li>
                <li class="sidebar-item">
                    <a class="sidebar-link justify-content-between" target="" href="consultarvencimientos.jsp">
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
                    <a class="sidebar-link justify-content-between" target="" href="agregaregreso.jsp">
                      <div class="d-flex align-items-center gap-3">
                        <span class="d-flex">
                          <iconify-icon icon="solar:clipboard-add-linear"></iconify-icon>
                        </span>
                        <span class="hide-menu">Ingresar</span>
                      </div>
                    </a>
                </li>
                <li class="sidebar-item">
                    <a class="sidebar-link justify-content-between" target="" href="consultaregresos.jsp">
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
            <li class="sidebar-item">
              <a class="sidebar-link justify-content-between has-arrow" href="javascript:void(0)" aria-expanded="false">
                <div class="d-flex align-items-center gap-3">
                  <span class="d-flex">
                    <iconify-icon icon="solar:checklist-linear"></iconify-icon>
                  </span>
                  <span class="hide-menu">BRES</span>
                </div>
              </a>
              <ul aria-expanded="false" class="collapse first-level">
               <li class="sidebar-item">
                    <a class="sidebar-link justify-content-between" target="_blank" href="#">
                      <div class="d-flex align-items-center gap-3">
                        <span class="d-flex">
                          <iconify-icon icon="solar:cloud-download-linear"></iconify-icon>
                        </span>
                        <span class="hide-menu">Generar BRES</span>
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