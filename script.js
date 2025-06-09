/*INICIO DE SESION*/
$('.form-log').on('submit', function (e) {
  e.preventDefault();

  const email = $('#email').val();
  const contra = $('#contra').val();

  $.post('php/loguin.php', { email, contra }, function (res) {
    const data = JSON.parse(res);

    if (data.success) {
 sessionStorage.setItem('usuario', data.usuario);
sessionStorage.setItem('email', data.email);
  window.location.href = 'perfil.html';

}
 else {
      alert(data.message);
    }
  });
});
$("#formCrearOferta").on("submit", function (e) {
  e.preventDefault();

  const datos = $(this).serialize();
  console.log("Formulario capturado con datos:", datos);

  $.post("php/guardar_oferta.php", datos, function (respuesta) {
    console.log("Respuesta del servidor:", respuesta);

    if (respuesta.success) {
      alert("Oferta guardada correctamente");
      window.location.href = "ofertar.html";
    } else {
      alert("Error: " + respuesta.message);
    }
  }, "json").fail(function (xhr, status, error) {
    console.error("Error en la petición:", error);
    console.log("Detalles:", xhr.responseText);
  });
});



/*DOC READY------------------------------------------------------------------------------------------------------------*/
$(document).ready(function () {
  $.get('php/usuario.php', function (res) {
    const data = JSON.parse(res);
    if (data.usuario) {
      $('.sesion-link').text(data.usuario).attr('href', 'perfil.html');
    }
  });
   $(".nav-link .icono-like").hover(
    function () {
      $(this).removeClass("bi-heart").addClass("bi-heart-fill");
    },
    function () {
      $(this).removeClass("bi-heart-fill").addClass("bi-heart");
    }
  );
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
//para que te lleve a sesion o a nueva oferta
 $(".masoferta").on("click", function (e) {
      const usuario = sessionStorage.getItem("usuario");

      if (!usuario) {
        e.preventDefault();
        window.location.href = "sesion.html";
      } else {
        window.location.href = "nueva-oferta.html";
      }
    });
  //perfil.html lo metí en script sino bug
    // Verificar si hay sesión
    // Solo redirige en perfil.html si no hay sesión
if (window.location.pathname.includes("perfil.html")) {
    const usuario = sessionStorage.getItem("usuario");
    const email = sessionStorage.getItem("email");

    if (!usuario) {
      window.location.href = "sesion.html";
    } else {
      $("#perfil-nombre").text(usuario);
      $("#perfil-email").text(email ?? "(sin correo)");
    }

    $(".cerrar-sesion").on("click", function () {
      $.get("php/logout.php", function () {
        sessionStorage.clear();
        window.location.href = "index.html";
      });
    });
  }

  //ofertas
if (window.location.pathname.includes("ofertar.html")) {
  $.get("php/ofertas_usuario.php", function (data) {
    console.log("Respuesta de ofertas_usuario.php:", data);

    if (data.success) {
      if (data.ofertas.length > 0) {
        $(".sinoferta").hide();
        $(".conoferta").show();

        const contenedor = $(".ofertascreadas");
        contenedor.empty();

    $.each(data.ofertas, function (i, oferta) {
  const tarjeta = $("<div>").addClass("card mb-3 oferta");
  const body = $("<div>").addClass("card-body oferta");

  if (oferta.imagen) {
    $("<img>")
      .addClass("img-fluid mb-3 rounded oferta-img")
      .attr("src", oferta.imagen)
      .attr("alt", "Imagen de la oferta")
      .appendTo(body);
  }

  $("<h3>").addClass("card-title titoferta").text(oferta.titulo).appendTo(body);
  $("<p>").addClass("card-text suboferta").text(oferta.descripcion).appendTo(body);
  $("<p>").addClass("card-text ubioferta").html("<strong>Ubicación:</strong> " + oferta.ciudad + ", " + oferta.provincia + ", " + oferta.comunidad).appendTo(body);
  $("<p>").addClass("card-text dateoferta").html("<strong>Fechas:</strong> " + oferta.fecha_inicio + " - " + oferta.fecha_fin).appendTo(body);
  $("<p>").addClass("card-text pagooferta").html(`<strong>Pago:</strong> <span class="cantidad-oferta">${oferta.cantidad} €</span> (${oferta.tipo_pago})`).appendTo(body);

  const acciones = $("<div>").addClass("acciones-oferta mt-3 d-flex justify-content-center gap-2");

  $("<button>")
    .addClass("btn btn-sm btn-outline-primary btn-editar")
    .text("Editar")
    .attr("data-id", oferta.id)
    .appendTo(acciones);

  $("<button>")
    .addClass("btn btn-sm btn-outline-danger btn-eliminar")
    .text("Eliminar")
    .attr("data-id", oferta.id)
    .appendTo(acciones);

  // NUEVO BOTÓN DE VER SOLICITUDES
  $("<a>")
    .addClass("btn btn-sm btn-outline-success")
    .text("Solicitudes")
    .attr("href", `solicitudes.html?id=${oferta.id}`)
    .appendTo(acciones);

  body.append(acciones);
  tarjeta.append(body);
  contenedor.append(tarjeta);
});



      } else {
        $(".sinoferta").show();
        $(".conoferta").hide();
      }
    } else {
      console.warn(data.message);
      $(".sinoferta").show();
      $(".conoferta").hide();
    }
  }, "json");
}
//editar oferta
$(document).on("click", ".btn-editar", function () {
  const ofertaId = $(this).data("id");
  const tarjeta = $(this).closest(".card");

  const titulo = tarjeta.find(".titoferta").text();
  const descripcion = tarjeta.find(".suboferta").text();
  const imagen = tarjeta.find("img.oferta-img").attr("src") || "";

  const ubicacionTexto = tarjeta.find(".ubioferta").text();
  const ubicacionPartes = ubicacionTexto.match(/Ubicación:\s*(.*?),\s*(.*?),\s*(.*)/);
  const ciudad = ubicacionPartes?.[1] ?? "";
  const provincia = ubicacionPartes?.[2] ?? "";
  const comunidad = ubicacionPartes?.[3] ?? "";

  const fechas = tarjeta.find(".dateoferta").text().match(/\d{4}-\d{2}-\d{2}/g);
  const fechaInicio = fechas?.[0] ?? "";
  const fechaFin = fechas?.[1] ?? "";

  const cantidad = tarjeta.find(".cantidad-oferta").text().replace(" €", "");
  const tipoPago = tarjeta.find(".pagooferta").text().match(/\((.*?)\)/)?.[1] ?? "";
  const tipoRemuneracion = tarjeta.find(".pagooferta").text().match(/Pago:\s*(.*?)\s*\d/)[1].trim();

  // Rellenar los campos del modal
  $("#editar-id").val(ofertaId);
  $("#editar-imagen").val(imagen);
  $("#editar-titulo").val(titulo);
  $("#editar-descripcion").val(descripcion);

  $("#editar-ciudad").val(ciudad);
  $("#editar-provincia").val(provincia);
  $("#editar-comunidad").val(comunidad);

  $("#editar-fecha-inicio").val(fechaInicio);
  $("#editar-fecha-fin").val(fechaFin);

  $("#editar-cantidad").val(cantidad);
  $("#editar-tipo-pago").val(tipoPago);
  $("#editar-tipo-remuneracion").val(tipoRemuneracion);

  $("#modalEditarOferta").modal("show");
});


// Enviar formulario
$("#formEditarOferta").on("submit", function (e) {
  e.preventDefault();

  $.post("php/editar_oferta.php", $(this).serialize(), function (res) {
    if (res.success) {
      alert("Oferta actualizada correctamente.");
      location.reload(); // recargar para ver cambios
    } else {
      alert("Error: " + res.message);
    }
  }, "json");
});
//eliminar oferta
let ofertaAEliminar = null;
$(document).on("click", ".btn-eliminar", function () {
  ofertaAEliminar = $(this).data("id"); 
  $("#modalConfirmarEliminar").modal("show"); 
});

$("#btnConfirmarEliminar").on("click", function () {
  if (!ofertaAEliminar) return;

  $.post("php/eliminar_oferta.php", { id: ofertaAEliminar }, function (res) {
    if (res.success) {
      alert("Oferta eliminada con éxito.");
      location.reload();
    } else {
      alert("Error al eliminar: " + res.message);
    }
  }, "json");

  $("#modalConfirmarEliminar").modal("hide");
});
//DEMANDAS----------------------
if (window.location.pathname.includes("demandar.html")) {
  cargarOfertasFiltradas(); // ✅ cargar la primera vez
}



$(document).on("click", ".btn-like", function () {
  const btn = $(this);
  const ofertaId = btn.data("id");

  $.post("php/guardar_favorito.php", { oferta_id: ofertaId }, function (res) {
    if (res.success) {
      if (res.action === "added") {
        btn.removeClass("btn-outline-danger").addClass("btn-danger text-white active");
      } else if (res.action === "removed") {
        btn.removeClass("btn-danger text-white active").addClass("btn-outline-danger");
      }
    } else {
      alert("Error: " + res.message);
    }
  }, "json").fail(function (xhr, status, error) {
    console.error("Error al guardar/eliminar favorito:", error);
  });
});
//favorito html
if (window.location.pathname.includes("favorito.html")) {
  $.get("php/favoritos_usuario.php", function (data) {
    const contenedor = $(".favs");

    if (data.success && data.ofertas.length > 0) {
      contenedor.empty();

      $.each(data.ofertas, function (i, oferta) {
        const card = $("<div>").addClass("card mb-3 fav position-relative");
        const body = $("<div>").addClass("card-body");

     if (oferta.imagen) {
  $("<img>")
    .addClass("img-fluid rounded mb-3 oferta-img-mini")
    .attr("src", oferta.imagen)
    .attr("alt", "Imagen oferta")
    .appendTo(body);
}


        $("<h5>").addClass("card-title").text(oferta.titulo).appendTo(body);
        $("<p>").addClass("card-text").text(oferta.descripcion).appendTo(body);
        $("<p>").addClass("card-text").html(`<strong>Ubicación:</strong> ${oferta.ciudad}, ${oferta.provincia}, ${oferta.comunidad}`).appendTo(body);
        $("<p>").addClass("card-text").html(`<strong>Fechas:</strong> ${oferta.fecha_inicio} - ${oferta.fecha_fin}`).appendTo(body);
        $("<p>").addClass("card-text").html(`<strong>Pago:</strong> ${oferta.cantidad} € (${oferta.tipo_pago})`).appendTo(body);

        card.append(body);

        const btnOfrecer = $("<button>")
       .addClass("btn btn-primary w-100 btn-ofrecer-servicio")
          .text("Ofrecer servicio")
          .attr("data-id", oferta.id);

        card.append(btnOfrecer);
        contenedor.append(card);
      });
    } else {
      contenedor.html("<p class='text-center text-muted'>No tienes ofertas marcadas como favoritas.</p>");
    }
  });
}
//servicio
$(document).on("click", ".btn-ofrecer-servicio", function () {
  const ofertaId = $(this).data("id");
  $("#solicitud-oferta-id").val(ofertaId);
  $("#modalSolicitudServicio").modal("show");
});
// servicio

$("#formSolicitudServicio").on("submit", function (e) {
  e.preventDefault();

  const datos = $(this).serialize();

  $.post("php/guardar_solicitud.php", datos, function (respuesta) {
    if (respuesta.success) {
      alert("Solicitud enviada correctamente.");
      $("#modalSolicitudServicio").modal("hide");
      $("#formSolicitudServicio")[0].reset();
    } else {
      alert("Error: " + respuesta.message);
    }
  }, "json").fail(function (xhr, status, error) {
    console.error("Error al enviar solicitud:", error);
    console.log("Detalles:", xhr.responseText);
  });
});

if (window.location.pathname.includes("solicitudes.html")) {
  const urlParams = new URLSearchParams(window.location.search);
  const ofertaId = urlParams.get("id");

  if (!ofertaId) {
    $(".solicitudes").html("<p class='text-center text-muted'>ID de oferta no proporcionado.</p>");
    return;
  }

  $.get("php/solicitudes_oferta.php", { id: ofertaId }, function (data) {
    const contenedor = $(".solicitudes");

    if (data.success && data.solicitudes.length > 0) {
      contenedor.empty();
data.solicitudes.forEach(solicitud => {
  let estadoClass = "solicitud"; // por defecto
if (solicitud.estado === "aceptado") estadoClass = "aceptado";
else if (solicitud.estado === "rechazado") estadoClass = "rechazado";

const card = $("<div>")
  .addClass(`card shadow-sm mb-4 ${estadoClass}`)
    .attr("data-id", solicitud.id); // <- aquí lo insertas
console.log("Solicitudes recibidas:", data.solicitudes);

  const body = $("<div>").addClass("card-body");

  $("<h5>").addClass("card-title fw-bold text-primary").text(`${solicitud.nombre} ${solicitud.apellidos}`).appendTo(body);
  $("<hr>").appendTo(body);
  $("<p>").addClass("mb-1").html(`<i class="bi bi-telephone"></i> <strong>Teléfono:</strong> ${solicitud.telefono}`).appendTo(body);
  $("<p>").addClass("mb-1").html(`<i class="bi bi-envelope"></i> <strong>Email:</strong> ${solicitud.email}`).appendTo(body);
  $("<p>").addClass("mb-1").html(`<i class="bi bi-person-lines-fill"></i> <strong>Presentación:</strong><br> ${solicitud.presentacion}`).appendTo(body);

  if (solicitud.archivo) {
    $("<p>").addClass("mb-1").html(`<i class="bi bi-paperclip"></i> <strong>Archivo:</strong> <a href="data/${solicitud.archivo}" target="_blank">${solicitud.archivo}</a>`).appendTo(body);
  }

  $("<p>").addClass("text-light small mt-2").html(`<i class="bi bi-clock"></i> Enviado el: ${solicitud.fecha_envio}`).appendTo(body);

const acciones = $("<div>").addClass("d-flex justify-content-end gap-2 mt-3");

if (solicitud.estado === "pendiente") {
  $("<button>").addClass("btn btn-outline-success btn-sm btn-aceptar")
    .html('<i class="bi bi-check-circle"></i> Aceptar')
    .appendTo(acciones);

  $("<button>").addClass("btn btn-outline-danger btn-sm btn-rechazar")
    .html('<i class="bi bi-x-circle"></i> Rechazar')
    .appendTo(acciones);
} else if (solicitud.estado === "rechazado") {
  const mensajeEstado = $("<div>")
    .addClass("mt-3 fw-bold text-danger")
    .text("Solicitud rechazada");
  acciones.append(mensajeEstado);
} else if (solicitud.estado === "aceptado") {
  const btnFinalizado = $("<button>")
    .addClass("btn btn-sm btn-outline-light btn-finalizado mt-3")
    .html('<i class="bi bi-x-diamond"></i> Finalizado');
  acciones.append(btnFinalizado);
}




  body.append(acciones);
  card.append(body);
  contenedor.append(card);
});

    } else {
      contenedor.html("<p class='text-center text-light'>No hay solicitudes para esta oferta.</p>");
    }
  });
}

//FILTROS
  // Cargar temas desde PHP
  $.getJSON("php/temas.php", function (temas) {
    temas.forEach(function (tema) {
      $("#filtro-tema").append(new Option(tema.nombre, tema.nombre));
    });
  });

 // Cargar ubicaciones desde JSON
let ubicacionesData = {};

$.getJSON("data/ubicaciones.json", function (data) {
  ubicacionesData = data;
  Object.keys(data).forEach(function (comunidad) {
    $("#filtro-comunidad").append(new Option(comunidad, comunidad));
  });
});

$("#filtro-comunidad").on("change", function () {
  const comunidad = $(this).val();
  const provincias = comunidad ? Object.keys(ubicacionesData[comunidad]) : [];
  $("#filtro-provincia").empty().append(new Option("Todas", "")).prop("disabled", !comunidad);
  $("#filtro-ciudad").empty().append(new Option("Todas", "")).prop("disabled", true);

  provincias.forEach(function (provincia) {
    $("#filtro-provincia").append(new Option(provincia, provincia));
  });
});

$("#filtro-provincia").on("change", function () {
  const comunidad = $("#filtro-comunidad").val();
  const provincia = $(this).val();
  const ciudades = comunidad && provincia ? ubicacionesData[comunidad][provincia] : [];
  $("#filtro-ciudad").empty().append(new Option("Todas", "")).prop("disabled", !provincia);

  ciudades.forEach(function (ciudad) {
    $("#filtro-ciudad").append(new Option(ciudad, ciudad));
  });
});
// Acciones de aceptar o rechazar solicitud
$(document).on("click", ".btn-aceptar, .btn-rechazar", function () {
  const boton = $(this);
  const card = boton.closest(".card");
  const solicitudId = card.attr("data-id");  // <-- cambia aquí
  const nuevoEstado = boton.hasClass("btn-aceptar") ? "aceptado" : "rechazado";

 console.log("Solicitud ID:", solicitudId, "| Estado:", nuevoEstado);

  $.post("php/actualizar_estado.php", {
    id: solicitudId,
    estado: nuevoEstado
  }, function (res) {
    if (res.success) {
      card.removeClass("border-primary border-success border-danger aceptado rechazado")
          .addClass(`${nuevoEstado} ${nuevoEstado === "aceptado" ? "border-success" : "border-danger"}`);

      card.find(".btn-aceptar, .btn-rechazar").remove();
      //card.find(".card-body").append(`<div class="mt-3 text-${nuevoEstado === "aceptado" ? "success" : "danger"} fw-bold">Solicitud ${nuevoEstado}</div>`);
    } else {
      alert("Error al actualizar el estado: " + res.message);
    }
  }, "json").fail(function (xhr, status, error) {
    console.error("Fallo en AJAX:", xhr.responseText);
  });
});






  // Filtrar al cambiar cualquier select
  $("#filtro-tema, #filtro-comunidad, #filtro-provincia, #filtro-ciudad").on("change", function () {
    cargarOfertasFiltradas();
  });
function cargarOfertasFiltradas() {
  const filtros = {
    tema: $("#filtro-tema").val(),
    comunidad: $("#filtro-comunidad").val(),
    provincia: $("#filtro-provincia").val(),
    ciudad: $("#filtro-ciudad").val()
  };

  $.get("php/ofertas_demanda.php", filtros, function (data) {
    const contenedor = $(".demandas");
    contenedor.empty();

    if (data.success && data.ofertas.length > 0) {
      data.ofertas.forEach(function (oferta) {
        const card = $("<div>").addClass("card mb-3 demanda position-relative");

        const body = $("<div>").addClass("card-body");

        if (oferta.imagen) {
          $("<img>")
            .addClass("img-fluid rounded mb-3")
            .attr("src", oferta.imagen)
            .attr("alt", "Imagen oferta")
            .appendTo(body);
        }

        $("<h5>").addClass("card-title").text(oferta.titulo).appendTo(body);
        $("<p>").addClass("card-text").text(oferta.descripcion).appendTo(body);
        $("<p>").addClass("card-text").html(`<strong>Ubicación:</strong> ${oferta.ciudad}, ${oferta.provincia}, ${oferta.comunidad}`).appendTo(body);
        $("<p>").addClass("card-text").html(`<strong>Fechas:</strong> ${oferta.fecha_inicio} - ${oferta.fecha_fin}`).appendTo(body);
        $("<p>").addClass("card-text").html(`<strong>Pago:</strong> ${oferta.cantidad} € (${oferta.tipo_pago})`).appendTo(body);

       const btnOfrecer = $("<button>")
  .addClass("btn btn-primary w-100 btn-ofrecer-servicio") 
  .text("Ofrecer servicio")
  .attr("data-id", oferta.id);


        card.append(body).append(btnOfrecer);
        contenedor.append(card);
      });
    } else {
      contenedor.html("<p class='text-center text-muted'>No hay ofertas que coincidan con los filtros.</p>");
    }
  }, "json");
}
$("#filtro-tema, #filtro-comunidad, #filtro-provincia, #filtro-ciudad").on("change", function () {
  cargarOfertasFiltradas();
});
});//final del ready

// Crear estrellas dinámicamente
function renderizarEstrellas(valorActual = 0) {
  const contenedor = $("#estrellas");
  contenedor.empty();
  for (let i = 1; i <= 5; i++) {
    const estrella = $("<i>")
      .addClass("bi bi-star-fill mx-1")
      .css("cursor", "pointer")
      .toggleClass("text-warning", i <= valorActual)
      .attr("data-valor", i);
    contenedor.append(estrella);
  }
  $("#resenaValor").val(valorActual);
  $("#btnConfirmarResena").prop("disabled", valorActual === 0);
}

// Click en botón finalizado
$(document).on("click", ".btn-finalizado", function () {
  const reseñadoId = $(this).closest(".card").attr("data-id");
  $("#resenaDestino").val(reseñadoId);
  renderizarEstrellas(0); // Reset
  $("#modalResena").modal("show");
});

// Click en estrella
$(document).on("click", "#estrellas i", function () {
  const valor = $(this).data("valor");
  renderizarEstrellas(valor);
});

// Enviar reseña
$("#btnConfirmarResena").on("click", function () {
  const valoracion = $("#resenaValor").val();
  const reseñado_id = $("#resenaDestino").val();

  $.post("php/guardar_resena.php", {
    valoracion,
    reseñado_id
  }, function (res) {
    if (res.success) {
      alert("¡Reseña enviada correctamente!");
      $("#modalResena").modal("hide");
    } else {
      alert("Error al guardar la reseña: " + res.message);
    }
  }, "json").fail(function (xhr) {
    console.error("Error en el servidor:", xhr.responseText);
    alert("Fallo al enviar reseña.");
  });
});
