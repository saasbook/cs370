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
//= require jquery
//= require jquery_ujs
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require bootstrap-datepicker
//= require jquery.dataTables.js
//= require jquery.dataTables.min.js
//= require dataTables.bootstrap4.js
//= require_tree .



$( document ).on('turbolinks:load', function() {
    $('#dataTable').DataTable();
    $('.datepicker').datepicker({format: 'yyyy-mm-dd', endDate: '+1d',
        datesDisabled: '+1d'});


    $('#radioButton2').click(function () {
        window.localStorage.clear();
    });

    $('#radioButton').click(function () {
        window.localStorage['radio1'] = this.checked;
    });
    $('#radioButton').prop('checked', window.localStorage['radio1']);

    if($('#radioButton').is(':checked')) {
        $("#radioButton").trigger('click');
    } else {
        $('#radioButton2').trigger('click');
    }
});
