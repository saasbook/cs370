/*
* meta = [email as string, sid as int, request id as int]
*/
function showEmailForm(meta) {
    const email = meta[0]
    const sid = meta[1]
    const requestid = meta[2]
    /*
    * Add info to hidden fields 
    */
    $("#student-id").val(sid);
    $("#student-email").val(email);
    $("#request-id").val(requestid);
    $("#to-email").html("To: " + email +'<button type="button" class="close" aria-label="Close" onclick="hideEmailForm()"><span aria-hidden="true">&times;</span></button>' );
    $("#email-form").css({'opacity' : 1, 'z-index':1});
}
  
function hideEmailForm() {
    $("#email-form").css({'opacity' : 0, 'z-index':0});
}