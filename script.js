$(document).ready(function () {
  // Mostrar modal al hacer clic
  $(document).on('click', '.crearoferta', function () {
    const modal = new bootstrap.Modal(document.getElementById('modalCrearOferta'));
    modal.show();
  });

  // Conexión al backend
  fetch('https://moira-back.vercel.app/api')
    .then(response => response.json())
    .then(data => {
      console.log('Conexión exitosa:', data);
      document.getElementById('resultado').textContent = 'Conectado con el backend';
    })
    .catch(error => {
      console.error('Error al conectar con el backend:', error);
      document.getElementById('resultado').textContent = 'Error de conexión';
    });

  // Crear usuario
  $('.form-sesion').on('submit', function (e) {
    e.preventDefault();

    const usuario = $('#usuario').val();
    const email = $('#email').val();
    const contra = $('#contra').val();
    const repiteContra = $('#repiteContra').val();

    if (contra !== repiteContra) {
      alert('Las contraseñas no coinciden');
      return;
    }

    const fechaNacimiento = $('#fechaNacimiento').val();

    $.ajax({
      url: 'https://moira-back.vercel.app/api/registrar',
      method: 'POST',
      contentType: 'application/json',
      data: JSON.stringify({ usuario, email, contra, fechaNacimiento }),
      success: function (response) {
        alert('Usuario registrado con éxito');
        window.location.href = 'sesion.html';
      },
      error: function (xhr) {
        const errorMsg = xhr.responseJSON?.message || 'Error al registrar';
        alert(errorMsg);
      }
    });
  });
//TEMAS Y SUBTEMAS
  const temaSelect = $('#tema');
  const subtemaSelect = $('#subtema');
  let temasData = [];

  // Obtener los temas y subtemas desde la API usando jQuery AJAX
  $.ajax({
    url: 'https://moira-back.vercel.app/api/tiposOfertas',
    method: 'GET',
    dataType: 'json',
    success: function (data) {
      temasData = data;

      temaSelect.append('<option selected disabled>Selecciona un tema</option>');
      data.forEach(function (item) {
        temaSelect.append(`<option value="${item.tema}">${item.tema}</option>`);
      });
    },
    error: function (xhr, status, error) {
      console.error('Error al cargar tipos de oferta:', error);
      temaSelect.append('<option disabled>Error al cargar temas</option>');
    }
  });
  // Manejar cambio en el select de temas
  temaSelect.on('change', function () {
    const temaSeleccionado = $(this).val();
    const temaObj = temasData.find(t => t.tema === temaSeleccionado);

    subtemaSelect.empty();
    if (temaObj && Array.isArray(temaObj.subtemas)) {
      subtemaSelect.append('<option selected disabled>Selecciona un subtema</option>');
      temaObj.subtemas.forEach(function (sub) {
        subtemaSelect.append(`<option value="${sub}">${sub}</option>`);
      });
    } else {
      subtemaSelect.append('<option disabled>No hay subtemas disponibles</option>');
    }
  });
 //ubicaciones: 
 let ubicaciones = {};
  // Cargar el JSON de ubicaciones
  $.getJSON('data/ubicaciones.json', function (data) {
    ubicaciones = data;

    // Rellenar el select de comunidades
    for (let comunidad in ubicaciones) {
      $('#comunidad').append(`<option value="${comunidad}">${comunidad}</option>`);
    }
  });

  // Cuando se cambia la comunidad
  $('#comunidad').on('change', function () {
    const comunidadSeleccionada = $(this).val();

    // Reset y habilitar el select de provincias
    $('#provincia').empty().append('<option value="">Selecciona una provincia</option>').prop('disabled', false);
    $('#ciudad').empty().append('<option value="">Selecciona una ciudad</option>').prop('disabled', true);

    if (comunidadSeleccionada && ubicaciones[comunidadSeleccionada]) {
      const provincias = ubicaciones[comunidadSeleccionada];
      for (let provincia in provincias) {
        $('#provincia').append(`<option value="${provincia}">${provincia}</option>`);
      }
    }
  });

  // Cuando se cambia la provincia
  $('#provincia').on('change', function () {
    const comunidadSeleccionada = $('#comunidad').val();
    const provinciaSeleccionada = $(this).val();

    $('#ciudad').empty().append('<option value="">Selecciona una ciudad</option>').prop('disabled', false);

    if (
      comunidadSeleccionada &&
      provinciaSeleccionada &&
      ubicaciones[comunidadSeleccionada] &&
      ubicaciones[comunidadSeleccionada][provinciaSeleccionada]
    ) {
      const ciudades = ubicaciones[comunidadSeleccionada][provinciaSeleccionada];
      ciudades.forEach(ciudad => {
        $('#ciudad').append(`<option value="${ciudad}">${ciudad}</option>`);
      });
    }
  });

  // Mostrar modal al hacer clic en "Crear Oferta"
  $('.crearoferta').on('click', function () {
    $('#modalCrearOferta').modal('show');
  });
  //LOGIN
   $('.form-log').on('submit', function (e) {
      e.preventDefault();

      const email = $('#email').val();
      const contra = $('#contra').val();

      $.ajax({
        url: 'https://moira-back.vercel.app/api/login',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({ email, contra }),
        success: function (data) {
          localStorage.setItem('usuario', JSON.stringify(data.usuario));
          window.location.href = 'perfil.html';
        },
        error: function (xhr) {
          const mensaje = xhr.responseJSON?.message || 'Error al iniciar sesión';
          alert(mensaje);
        }
      });
    });
  const usuario = JSON.parse(localStorage.getItem('usuario'));
  const navSesion = document.querySelector('.nav-link[href="sesion.html"]');

  if (usuario && navSesion) {
    navSesion.textContent = usuario.nombre;
    navSesion.href = 'perfil.html';
  }
$(document).on('click', '.cerrar-sesion', function () {
  localStorage.removeItem('usuario');
  window.location.href = 'sesion.html';
});
if (window.location.pathname.includes('perfil.html')) {
  const usuario = JSON.parse(localStorage.getItem('usuario'));

  if (usuario) {
    $('#perfil-nombre').text(usuario.nombre);
    $('#perfil-email').text(usuario.email);
  } else {
    // Si no hay sesión, redirige a la página de login
    window.location.href = 'sesion.html';
  }
}

  });
