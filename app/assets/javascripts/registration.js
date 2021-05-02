$(document).on('turbolinks:load', function() {
  //performs regex looking for inputs of type /.*password.*/
  if ($("input[type*='password']").length == 2){
    $("input[type*='password']").on('keyup', function() {
      if ($("input[type*='password']").eq(0).val() == $("input[type*='password']").eq(1).val()){
        $("input[type*='password']")[0].setCustomValidity('')
        $("input[type*='password']")[1].setCustomValidity('')
      } else {
        $("input[type*='password']")[0].setCustomValidity('Passwords must match and be at least 6 characters long')
        $("input[type*='password']")[1].setCustomValidity('Passwords must match and be at least 6 characters long')
      }
    })
  }
});
