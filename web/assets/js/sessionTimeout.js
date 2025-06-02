// sessionTimeout.js
(function(){
  const tiempoInactividad = 29 * 60 * 1000;
  const avisoAnticipado   = 60 * 1000;
  let tiempoAdvertencia, tiempoLogout;

  function resetTimers() {
    clearTimeout(tiempoAdvertencia);
    clearTimeout(tiempoLogout);
    startTimers();
  }

  function startTimers() {
    tiempoAdvertencia = setTimeout(mostrarAviso, tiempoInactividad - avisoAnticipado);
    tiempoLogout      = setTimeout(cerrarSesion, tiempoInactividad);
  }

  function mostrarAviso() {
    let intervalId;
    Swal.fire({
      title: 'Inactividad detectada',
      html: 'Serás desconectado en <b></b> segundos',
      timer: avisoAnticipado,
      timerProgressBar: true,
      allowOutsideClick: false,
      allowEscapeKey: false,
      didOpen: () => {
        const b = Swal.getHtmlContainer().querySelector('b');
        intervalId = setInterval(() => {
          const seg = Math.ceil(Swal.getTimerLeft() / 1000);
          b.textContent = seg;
        }, 500);
      },
      willClose: () => clearInterval(intervalId)
    }).then((result) => {
      if (result.dismiss === Swal.DismissReason.timer) {
        cerrarSesion();
      } else {
        resetTimers();
      }
    });
  }

  function cerrarSesion() {
    Swal.fire({
      icon: 'info',
      title: 'Sesión cerrada',
      text: 'Has sido desconectado por inactividad',
      allowOutsideClick: false,
      allowEscapeKey: false
    }).then(() => {
      window.location = 'authentication-login.jsp?timeout=true';
    });
  }

  ['mousemove','mousedown','keypress','scroll','touchstart']
    .forEach(evt => document.addEventListener(evt, resetTimers, true));

  startTimers();
})();
