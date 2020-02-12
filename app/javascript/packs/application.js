require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import 'bootstrap'

import "../src/style.scss";

document.addEventListener("turbolinks:load", () => {
  $('[data-toggle="popover"]').popover()
})
