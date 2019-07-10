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

let ajaxTimer = null;
let dateEl = null;
let bodyEl = null;

const postDiary = () => {
  const xhr = new XMLHttpRequest();
  xhr.open("POST", "/diaries/auto_save", true);
  xhr.setRequestHeader("Content-Type", "application/json");

  const token = document.querySelector('meta[name="csrf-token"]')
                        .getAttribute('content');
  xhr.setRequestHeader('X-CSRF-TOKEN', token);

  const json = JSON.stringify({
    "diary": {
      "date": dateEl.value,
      "body": bodyEl.value
    }
  })
  xhr.send(json);
}

const autoSaveDiary = () => {
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
