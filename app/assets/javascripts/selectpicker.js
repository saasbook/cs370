$(document).on('turbolinks:load', function() {
  //Select picker is bootstrap-select, it lets you use fancier select menus.
  if ($(".selectpicker").length){

    //this is needed to reload the selectpicker, because of how it interacts with turbolinks and the load event.
    $(".selectpicker").selectpicker();

    //this is a class used only for this hook in for the major selection field.
    if ($(".custom-major-multiselect-config").length){
      //each opt group has at most one item to select from.
      $(".custom-major-multiselect-config > optgroup").each(function(){
        $(this).attr('data-max-options', 1);
      });
      //get the length of the text box to see if user has filled out the select box completely
      $(".custom-major-multiselect-config").change(function(){
        var o = $(".custom-major-multiselect-config").find($("li.selected"));
        if (o.length < 2){
          $(".selectpicker.custom-major-multiselect-config").get(0).setCustomValidity('Please select an item from both groups.');
        } else {
          $(".selectpicker.custom-major-multiselect-config").get(0).setCustomValidity('');
        }
      });
    }
    //when a select form is required, it auto-generates an empty option that looks ugly
    //I spent at least two to three hours figuring out how to pull that HTMLElement
    //and set its display to none. I hope it was worth it. It had to do with the order of load events
    //and when selectpicker() was being run.
    if ($(".custom-hide-empty-option").length){
      $(".custom-hide-empty-option").one("click", function(){
        $("li:first-of-type", this).css('display','none');
      })
    }
  }
});
