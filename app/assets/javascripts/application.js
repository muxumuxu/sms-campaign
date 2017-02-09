// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function updateCount(max) {
  var cs = $(this).val().length;
  $('.characters').text(cs + "/" + max);
    if (cs > 1300) {
    $('.main').addClass('background-red');
  } else {
    $('.main').removeClass('background-red');
  }
}

function openModal() {
  $('.overlay-modal').addClass('visible');
}

function closeModal() {
  $('.overlay-modal').addClass('invisible');
}

$(document).on('turbolinks:load', function() {
  $('#cbox1').change(function() {
    if($(this).is(":checked")) {
      $('.add-contact').addClass('active');
    } else {
      $('.add-contact').removeClass('active');
    }
  });
});

$(document).ready(function() {
  var str = $('p.message').text();
  if (str.length > 85) {
    $('p.message').text(str.substring(0,85)).append('...');
  };
});

$(document).ready(function() {
  $('textarea').focus(function() {
      var theVal = $(this).val();
      $(this).val("").val(theVal);
  });
});
