$(document).on('turbolinks:load', function() {

  if ($(".custom-bootstrap-slider").length) {
    var el = $(".custom-bootstrap-slider")
    var ticks = el.attr('ticks').split(' ')

    el.slider({
      formatter: function(value) {
        return 'Current value: ' + value;
      },
      ticks: ticks
    })
  }

  if ($(".custom-bootstrap-slider-hours").length) {
    var el = $(".custom-bootstrap-slider-hours")
    var ticks = el.attr('ticks').split(' ')

    el.slider({
      formatter: function(value) {
        return value == 0 ? "We did not meet" : Math.floor(value) + (Math.floor(value) == 1 ? " hour" : " hours")+ " and " + 60*(value%1) + " minutes";
      },
      ticks: ticks,
      ticks_labels: ['N/A','','0:30','','1:00','','1:30','','2:00','','2:30','','3:00','','3:30','','4:00'],
      step: 0.25,
      value: 1.0
    })
  }
})
