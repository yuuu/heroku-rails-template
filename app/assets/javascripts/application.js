// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require materialize
//= require_tree .

var ajaxTimer = null;
var dateEl = null;
var bodyEl = null;

function postDiary() {
  var xhr = new XMLHttpRequest();
  xhr.open("POST", "/diaries/auto_save", true);
  xhr.setRequestHeader("Content-Type", "application/json");

  var token = document.querySelector('meta[name="csrf-token"]')
                        .getAttribute('content');
  xhr.setRequestHeader('X-CSRF-TOKEN', token);

  var json = JSON.stringify({
    "diary": {
      "date": dateEl.value,
      "body": bodyEl.value
    }
  })
  xhr.send(json);
}

function autoSaveDiary() {
  clearTimeout(ajaxTimer);
  ajaxTimer = setTimeout(postDiary, 500);
}

document.addEventListener('DOMContentLoaded', function() {
  M.AutoInit();

  dateEl = document.getElementById('diary_date')
  bodyEl = document.getElementById('diary_body')
  if ((dateEl != null) && (bodyEl != null)) {
    bodyEl.addEventListener('keyup', autoSaveDiary)
  }
});
