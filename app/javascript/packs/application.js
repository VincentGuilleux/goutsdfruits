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
import { initMapbox } from '../plugins/init_mapbox';

// Internal imports, e.g:
import { initSelect2 } from '../components/init_select2';
import { flatpickrInit } from '../components/flatpickr';
import { dropdownFruit, dropdownType, dropdownPrice, dropdownSegment, dropdownAmap, dropdownSegmentOrders, dropdownStatusOrders, dropdownDeliveryOrders} from '../components/dropdown';
import { search } from '../components/search';
import { InitChart } from '../components/initchart';
import { counter } from '../components/counter';

// event listener sur toutes les classes more-info qui déclenchent sur un click l'affichagae du contenu de la balise title
// utile pour mobiles => cf. https://stackoverflow.com/questions/12539006/tooltips-for-mobile-browsers
$(".more-info").click(function () {
    var $title = $(this).find(".title");
    if (!$title.length) {
        $(this).append('<span class="title">' + $(this).attr("title") + '</span>');
    } else {
        $title.remove();
    }
});

// en lien avec application_helper lignes 29 et suivantes (création d'order_lines_id temporaires)
document.addEventListener('turbolinks:load', () => {
  initMapbox();
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
    obj.find("[data-uuid]").each(function() {
      $(this).attr("data-uuid", time);
    });
    // obj = formulaire car lié à data-form-prepend (cf. lignes 38 & 39)
    // Les 3 lignes ci-dessus permettent de substituer au data-uuid la
    obj.insertBefore(this);
    return false;
  });

  $(document).ready(function(){ // quand page chargée, le navigateur exécute les lignes ci-dessous
    $(".payment-choice").click(function(){
      $(this).toggleClass("active");
    });
    // pour remplacer
    $("#product-search").on("ajax:success", function(event) {
      console.log(event.detail[0]);
      $(".container-index-products").html('toto');
    });
  });



  initSelect2();
  flatpickrInit();
  dropdownFruit();
  dropdownType();
  dropdownPrice();
  dropdownSegment();
  dropdownAmap();
  dropdownSegmentOrders();
  dropdownStatusOrders();
  dropdownDeliveryOrders();
  InitChart();
  counter();
});
