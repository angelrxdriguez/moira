/*INICIO DE SESION*/
$('.form-log').on('submit', function (e) {
  e.preventDefault();

  const email = $('#email').val();
  const contra = $('#contra').val();

  $.post('php/loguin.php', { email, contra }, function (res) {
    const data = JSON.parse(res);

    if (data.success) {
      // Redirige a perfil y guarda usuario en sessionStorage
      sessionStorage.setItem('usuarioNombre', ''); // por si lo quieres luego usar
      window.location.href = 'perfil.html';
    } else {
      alert(data.message);
    }
  });
});
$("#formCrearOferta").on("submit", function (e) {
  e.preventDefault();

  const datos = $(this).serialize();

  $.post("php/guardar_oferta.php", datos, function (respuesta) {
    if (respuesta.success) {
      alert("✅ Oferta guardada correctamente");
      window.location.href = "ofertar.html"; // o donde quieras redirigir
    } else {
      alert("❌ Error: " + respuesta.message);
    }
  }, "json");
});

/*DOC READY------------------------------------------------------------------------------------------------------------*/
$(document).ready(function () {
  $.get('php/usuario.php', function (res) {
    const data = JSON.parse(res);
    if (data.usuario) {
      $('.sesion-link').text(data.usuario).attr('href', 'perfil.html');
    }
  });
  //UBICACIONES--------
      let ubicaciones = {};

    $.getJSON('data/ubicaciones.json', function (data) {
      ubicaciones = data;
      cargarComunidades();
    });

    function cargarComunidades() {
      $('#comunidad').append('<option value="">Selecciona una comunidad</option>');
      $.each(ubicaciones, function (comunidad, provincias) {
        $('#comunidad').append('<option value="' + comunidad + '">' + comunidad + '</option>');
      });
    }

    $('#comunidad').on('change', function () {
      const comunidad = $(this).val();
      const provincias = ubicaciones[comunidad] || {};

      $('#provincia').empty().append('<option value="">Selecciona una provincia</option>');
      $('#ciudad').empty().append('<option value="">Selecciona una ciudad</option>').prop('disabled', true);

      $.each(provincias, function (provincia, ciudades) {
        $('#provincia').append('<option value="' + provincia + '">' + provincia + '</option>');
      });

      $('#provincia').prop('disabled', false);
    });

    $('#provincia').on('change', function () {
      const comunidad = $('#comunidad').val();
      const provincia = $(this).val();
      const ciudades = (ubicaciones[comunidad] && ubicaciones[comunidad][provincia]) || [];

      $('#ciudad').empty().append('<option value="">Selecciona una ciudad</option>');

      $.each(ciudades, function (i, ciudad) {
        $('#ciudad').append('<option value="' + ciudad + '">' + ciudad + '</option>');
      });

      $('#ciudad').prop('disabled', ciudades.length === 0);
    });
    //OBTENER TEMAS Y SUBTEMAS---
    $.getJSON('php/temas-subtemas.php', function (data) {
  $('#tema').append('<option value="">Selecciona un tema</option>');
  
  $.each(data, function (id, tema) {
    $('#tema').append('<option value="' + id + '">' + tema.nombre + '</option>');
  });

  window.temasSubtemas = data;
});

$('#tema').on('change', function () {
  const temaId = $(this).val();
  const subtemas = window.temasSubtemas?.[temaId]?.subtemas || [];

  $('#subtema').empty().append('<option value="">Selecciona un subtema</option>');

  $.each(subtemas, function (i, sub) {
    $('#subtema').append('<option value="' + sub.id + '">' + sub.nombre + '</option>');
  });

  $('#subtema').prop('disabled', subtemas.length === 0);
});
});

