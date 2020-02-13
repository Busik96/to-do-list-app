require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import 'bootstrap'
import 'flatpickr'

import "../src/style.scss";

document.addEventListener("turbolinks:load", () => {
  $('[data-toggle="popover"]').popover({
    html : true,
    placement: 'bottom'
  })

  $('.datepicker').flatpickr({
    altInput: true,
    altFormat: "d F Y",
    minDate: "today"
  })


  $('.timepicker').flatpickr({
    enableTime: true,
    noCalendar: true,
    dateFormat: "H:i",
    time_24hr: true
  })
})
