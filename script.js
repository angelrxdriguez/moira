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

  // Botones de acción
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
  $.when(
    $.get("php/ofertas_demanda.php"),
    $.get("php/obtener_favoritos.php")
  ).done(function (ofertasRes, favoritosRes) {
    const data = ofertasRes[0];
    const favoritos = favoritosRes[0].favoritos ?? [];
    const contenedor = $(".demandas");

    if (data.success && data.ofertas.length > 0) {
      contenedor.empty();

      $.each(data.ofertas, function (i, oferta) {
        const card = $("<div>").addClass("card mb-3 demanda position-relative");

        const esFavorita = favoritos.includes(parseInt(oferta.id));

        const btnLike = $("<button>")
          .addClass("btn btn-sm position-absolute top-0 end-0 m-4 btn-like")
          .html("❤️")
          .attr("title", "Me gusta")
          .attr("data-id", oferta.id);

        if (esFavorita) {
          btnLike.addClass("btn-danger text-white active");
        } else {
          btnLike.addClass("btn-outline-danger");
        }

        card.append(btnLike);

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

        card.append(body);

        const btnOfrecer = $("<button>")
          .addClass("btn btn-primary w-100")
          .text("Ofrecer servicio")
          .attr("data-id", oferta.id);

        card.append(btnOfrecer);
        contenedor.append(card);
      });
    } else {
      contenedor.html("<p class='text-center text-muted'>No hay ofertas disponibles.</p>");
    }
  });
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



});//final del ready

