// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .

jQuery(document).ready(function($) {
  $('#main .content').on('click', 'table.table tbody tr.clickable', function() {
    window.document.location = $(this).data('href');
  });

  $('#main .content').on('click', 'table.table tbody tr.clickable_xhr', function(event) {
    $.get($(this).data('href'));
  });

  $('#main .content').on('click', 'table.table tbody tr.clickable_blank', function() {
    window.open($(this).data('href'), '_blank');
  });

  $('select.selectpicker.clickable').on('change', function() {
    var hrefSelected = $('option:selected', this).data('href');
    if (hrefSelected) {document.location.href = hrefSelected;}
  });
});
