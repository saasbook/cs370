
function showEmailForm(meta) {
  const tutee_email = meta[0];
  const request_id = meta[1];
  $("#tutee-email").val(tutee_email);
  $("#request-id").val(request_id);
  $("#to-email").html("To - you & " + tutee_email);
  $("#tutoring-statistics").toggle(false);
  $("#email-form").toggle(true);
}

function hideEmailForm() {
  $("#email-form").toggle(false);
  $("#tutoring-statistics").toggle(true);
}
