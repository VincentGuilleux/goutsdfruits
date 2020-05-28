// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
import flatpickr from "flatpickr";

// Internal imports, e.g:
import { initSelect2 } from '../components/init_select2';
import { flatpickrInit } from '../components/flatpickr';
import { dropdownFruit, dropdownCategory, dropdownType, dropdownPrice, dropdownSegment } from '../components/dropdown';
import { InitChart } from '../components/initchart';

document.addEventListener('turbolinks:load', () => {
  $("[data-form-prepend]").click(function(e) {
    var obj = $($(this).attr("data-form-prepend"));
    var time = new Date().getTime();
    obj.find("input, select, textarea").each(function() {
      $(this).attr("name", function() {
        return $(this)
          .attr("name")
          .replace("new_record", time);
      });
    });
    obj.insertBefore(this);
    return false;
  });

  $(document).ready(function(){
    $(".payment-choice").click(function(){
      $(this).toggleClass("active");
    });
  });

  flatpickrInit();
  dropdownFruit();
  dropdownCategory();
  dropdownType();
  dropdownPrice();
  dropdownSegment();
  InitChart();
  initSelect2();
});
