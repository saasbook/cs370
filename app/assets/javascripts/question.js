$(document).on('turbolinks:load', function() {

  if ($(".custom-bootstrap-slider").length) {
    var el = $(".custom-bootstrap-slider")
    var ticks = el.attr('ticks').split(' ')

    el.slider({
      formatter: function(value) {
        return 'Current value: ' + value;
      },
      ticks: ticks,
    })
  }
})
