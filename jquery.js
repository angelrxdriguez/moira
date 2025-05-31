$(document).ready(function () {
  $('.crearoferta').on('click', function () {
    const modal = new bootstrap.Modal(document.getElementById('modalCrearOferta'));
    modal.show();
  });
});
