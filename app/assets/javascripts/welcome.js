
$(document).on('turbolinks:load', function() {
  updateUserType();
});

function updateUserType(){
  var type = $("#user_type")[0].value;
  var form_element = $("#form_information")
  $.get({
    url: "get_login_form",
    data: {},
    success: function(){
      console.log("success");
    }
  })
}
