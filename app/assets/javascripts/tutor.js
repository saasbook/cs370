
$(document).on('turbolinks:load', function() {
  if ($("#tutor_password").length){
    $('#tutor_password, #tutor_password_confirmation').on('keyup', function () {
      if ($('#tutor_password').val() == $('#tutor_password_confirmation').val()) {
        $('#tutor_password_confirmation').get(0).setCustomValidity('');
      } else
      $('#tutor_password_confirmation').get(0).setCustomValidity('Passwords Must Match');
    });
  }
});
