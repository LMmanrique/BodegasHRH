<div class="app-topstrip bg-dark py-6 px-3 w-100 d-lg-flex align-items-center justify-content-between">
  <!-- Izquierda: Datos del Usuario -->
  <div class="d-flex align-items-center gap-3">
    <iconify-icon icon="solar:user-circle-bold" style="font-size:2rem;" class="text-white"></iconify-icon>
    <span class="text-white fw-bold">${usuario.nombrecompleto}</span>
    <div class="d-flex align-items-center">
      <!-- Punto verde -->
      <span class="bg-success rounded-circle" style="width:10px; height:10px; display:inline-block; margin-right:5px;"></span>
      <span class="text-success">Online</span>
    </div>
  </div>
  <!-- Derecha: Botones de Soporte y Cerrar Sesi�n -->
  <div class="d-flex align-items-center gap-5 mb-2 mb-lg-0">
    <div class="d-none d-xl-flex align-items-center gap-3">
      <a id="helpBtn" href="#" class="btn btn-outline-primary d-flex align-items-center gap-1 border-0 text-white px-6">
        <i class="ti ti-help fs-5"></i>
        Necesitas Ayuda?
      </a>
      <a id="logoutBtn" href="LogoutServlet" class="btn btn-outline-primary d-flex align-items-center gap-1 border-0 text-white px-6">
        <iconify-icon icon="solar:logout-3-linear" class="fs-5"></iconify-icon>
        Cerrar Sesi�n
      </a>
    </div>
  </div>
</div>


        <script>
            document.addEventListener('DOMContentLoaded', function(){
              const helpBtn = document.getElementById('helpBtn');
              helpBtn.addEventListener('click', function(e){
                e.preventDefault(); // Evita la acci�n por defecto del enlace

                Swal.fire({
                  title: 'Ayuda',
                  html: 'Si necesitas ayuda contacta a la <strong>extensi�n 259</strong>.',
                  icon: 'info',
                  confirmButtonText: 'Aceptar'
                });
              });
            });
        </script>
        <script>
      // Espera a que se cargue el DOM
      document.addEventListener('DOMContentLoaded', function(){
        const logoutBtn = document.getElementById('logoutBtn');
        logoutBtn.addEventListener('click', function(e){
          e.preventDefault(); // Evita la redirecci�n inmediata

          Swal.fire({
            title: '�Est�s seguro?',
            text: "�Desea cerrar sesi�n?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'S�, cerrar sesi�n!',
            cancelButtonText: 'Cancelar'
          }).then((result) => {
            if (result.isConfirmed) {
              // Redirige al servlet de logout si se confirma
              window.location.href = logoutBtn.getAttribute('href');
            }
          });
        });
      });
    </script>