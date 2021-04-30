$(document).on('turbolinks:load', function() {
  if ($("#tutee_password").length){
    $('#tutee_password, #tutee_password_confirmation').on('keyup', function () {
      if ($('#tutee_password').val() == $('#tutee_password_confirmation').val()) {
        $('#tutee_password_confirmation').get(0).setCustomValidity('');
      } else
      $('#tutee_password_confirmation').get(0).setCustomValidity('Passwords Must Match');
    });
  }
  if ($("#tutor_password").length){
    $('#tutor_password, #tutor_password_confirmation').on('keyup', function () {
      if ($('#tutor_password').val() == $('#tutor_password_confirmation').val()) {
        $('#tutor_password_confirmation').get(0).setCustomValidity('');
      } else
      $('#tutor_password_confirmation').get(0).setCustomValidity('Passwords Must Match');
    });
  }
});
