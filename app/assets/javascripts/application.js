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
//= require datepicker

function openModal() {
  $('.overlay-modal').addClass('visible');
}

function closeModal() {
  $('.overlay-modal').addClass('invisible');
}

function updateMessageTextAreaInfos() {
  updateTextBubble();
  updateCount();
  checkCampaignMessage();
}

// When updating a campaign message, show the character count
var CHARACTER_PER_SMS = 140;
function updateCount() {
  var textArea = $("#campaign_textarea");
  var characterCount = textArea.val().length;

  var numberOfSms = Math.ceil(characterCount / CHARACTER_PER_SMS);
  $('#sms_count').text(numberOfSms + " SMS par destinataire");

  var charMax = numberOfSms * CHARACTER_PER_SMS;
  $('#characters').text(characterCount + "/" + charMax + ", ");
}

function updateUserTimeZone() {
  var paren = new Date().toString().match(/\(.+\)/);
  var tz = paren ? paren[0].match(/([A-Z])/g).join("") : "";
  var tzSpan = $('#user_timezone');
  if (tzSpan.length > 0) {
    tzSpan.text(tz);
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
  textArea.focus();
}

// Check if campaign name input is empty on new campaign
function checkName() {
  var shouldActivate = $('#campaign_name').val().length > 0;
  activateCampaignSubmitButton(shouldActivate);
};

function checkCampaignMessage() {
  var shouldActivate = $("#campaign_textarea").val().length > 0;
  activateCampaignSubmitButton(shouldActivate);
}

function activateCampaignSubmitButton(value) {
  var submitButton = $('#submit-campaign');
  if (value) {
    submitButton.attr({ "disabled": null });
    submitButton.removeClass('inactive');
  } else {
    submitButton.attr({ "disabled": "disabled" });
    submitButton.addClass('inactive');
  }
}

$(document).on('turbolinks:load', function() {

  /// The code is executed when the document is ready

  $('#cbox1').change(function() {
    if($(this).is(":checked")) {
      $('.add-contact').attr({ "disabled": null });
      $('.add-contact').removeClass('inactive');
    } else {
      $('.add-contact').attr({ "disabled": "disabled" });
      $('.add-contact').addClass('inactive');
    }
  });

  var str = $('p.message').text();
  if (str.length > 80) {
    $('p.message').text(str.substring(0,80)).append('...');
  };

  var textArea = $("#campaign_textarea");
  if (textArea.length > 0) {
    textArea.keyup(updateMessageTextAreaInfos);
    textArea.on('change', updateMessageTextAreaInfos);
    updateMessageTextAreaInfos();
  }

  var mailingListInput = $("#mailing_list\\[file\\]");
  if (mailingListInput.length > 0) {
    mailingListInput.on("change", function(){
      var path = mailingListInput.val();
      var lastPath = path.substr(path.lastIndexOf('\\') + 1);
      $("#filename").html(lastPath);
    });
  }

  var hiddenTz = $("#campaign\\[tz\\]");
  if (hiddenTz.length > 0) {
    var paren = new Date().toString().match(/\(.+\)/);
    var tz = paren ? paren[0].match(/([A-Z])/g).join("") : "";
    // var dateOffset = new Date().getTimezoneOffset();
    hiddenTz.val(tz);
  }

  var campaignNameInput = $("#campaign_name");
  if (campaignNameInput.length > 0) {
    campaignNameInput.on('input', checkName);
    checkName();
  }

  $('[data-toggle="datepicker"]').datepicker({
    startDate: Date.now(),
    format: 'dd/mm/yyyy'
  });

  updateUserTimeZone();
});
