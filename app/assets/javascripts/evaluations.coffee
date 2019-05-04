# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@disableFunction =() ->
  return document.getElementById("disabled").value

# $('#sPriceRewards').on('input', function() {
#    $(this).next().prop('disabled', this.value.length);
#  });

# disable = ->
#   document.getElementById('name').disabled = true

# $ ->
#   $("input[data-radio='radio-foo']").live "click", ->
#     type = $(this).data('type')
#     $(".num-content").css "display", "none"
#     $("#hidden-"+type+"-content").css "display", "inline"
