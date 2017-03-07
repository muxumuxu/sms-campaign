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

function openModal() {
  $('.overlay-modal').addClass('visible');
}

function closeModal() {
  $('.overlay-modal').addClass('invisible');
}

function updateMessageTextAreaInfos() {
  updateTextBubble();
  updateCount();
}

// When updating a campaign message, show the character count
function updateCount() {
  var max = 1300;
  var textArea = $("#campaign_textarea");
  var cs = textArea.val().length;
  $('.characters').text(cs + "/" + max);
    if (cs > max) {
    $('.main').addClass('background-red');
  } else {
    $('.main').removeClass('background-red');
  }
}

// When modifying a campaign message, insert text in the green bubble
function updateTextBubble() {
  var textArea = $("#campaign_textarea");
  var text = textArea.val();
  var bubbleMessage = $("#message-bubble");
  var shouldHideBubble = (text == "" || text == null);
  bubbleMessage.css("display", shouldHideBubble ? "none" : "block");
  bubbleMessage.html(text);
}

// When modifying a campaign message, insert the provided name placeholder to the cursor position in the text area
function addVariable(name) {
  var textArea = $("#campaign_textarea");
  var text = textArea.val();
  var starting = textArea.prop("selectionStart");
  var textToAdd = "{" + name + "}";
  var output = [text.slice(0, starting), textToAdd, text.slice(starting)].join("");
  textArea.val(output);
  updateMessageTextAreaInfos();
}


$(document).on('turbolinks:load', function() {

  /// The code is executed when the document is ready

  $('#cbox1').change(function() {
    if($(this).is(":checked")) {
      $('.add-contact').attr({
        "disabled": null
      });
      $('.add-contact').removeClass('inactive');
    } else {
      $('.add-contact').attr({
        "disabled": "disabled"
      });
      $('.add-contact').addClass('inactive');
    }
  });

  var str = $('p.message').text();
  if (str.length > 85) {
    $('p.message').text(str.substring(0,85)).append('...');
  };

  $("#campaign_textarea").keyup(updateMessageTextAreaInfos);
  $("#campaign_textarea").on('change', updateMessageTextAreaInfos);

  updateMessageTextAreaInfos();

});

/// Display name of the csv file
$('#mailing_list[file]').on('change',function(){
  var file = document.getElementById('mailing_list[file]').files[0];
  console.log(file);
});
