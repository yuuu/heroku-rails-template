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
//= require turbolinks
//= require_tree .

document.addEventListener('turbolinks:load', function() {
  var elems = document.querySelectorAll('select');
  var instances = M.FormSelect.init(elems, {});
});

document.addEventListener('turbolinks:load', function() {
  var elems = document.querySelectorAll('.datepicker');
  var instances = M.Datepicker.init(elems, {});
});

document.addEventListener('turbolinks:load', function() {
  if (!window.appName) window.appName = {};
  window.appName.formDirty = false;
  window.appName.formSubmit = false;
  window.appName.dirtyMessage = '保存していない内容が失われますが、よろしいですか';

  document.querySelectorAll('input, select, textarea').forEach(function(el) {
    el.addEventListener('change', function () {
      if (!window.appName.formDirty) window.appName.formDirty = true;
    });
  });

  document.querySelectorAll('form').forEach(function(el) {
    el.addEventListener('submit', function () {
      window.appName.formSubmit = true;
    });
  });
});

document.addEventListener("turbolinks:before-visit", function () {
  if (window.appName.formDirty) {
    return window.confirm(window.appName.dirtyMessage);
  }
})

document.addEventListener("beforeunload", function (event) {
  console.log('aaaa');
  if (!window.appName.formSubmit && window.appName.formDirty) {
    event.returnValue = window.appName.dirtyMessage;
    return event.returnValue;
  }
});

