// DROPDOWNS PRODUCT INDEX

const getdropdownids = () => {
  const product_fruit = document.getElementById("product_fruit"); // target l'id du champ fruit (le "titre" du Dropdown Menu)
  const product_type = document.getElementById("product_type");
  const product_price = document.getElementById("product_price");
};

const dropdownFruit = () => {
  const fruit = document.getElementById("DropdownFruit");
  if (!fruit) return // met fin à la fonction si fruit est null

  fruit.addEventListener("click", (event) => {
    const product_fruit_value = (event.target.dataset.name) // stocke le fruit sur lequel l'utilisateur a cliqué
    product_fruit.innerText = product_fruit_value // on remplace dans l'HTML le titre du Dropdown menu par la valeur cliquée
    getdropdownids
    toggling(); // fonction qui itère sur chaque carte produit pour l'afficher ou non
    event.preventDefault(); // vient prévenir le rechargement de la page par le navigateur (du au fait que le dropdown menu a une balise a avec href)
  });
};

const dropdownType = () => {
  const type = document.getElementById("DropdownType");
  if (!type) return

  type.addEventListener("click", (event) => {
    const product_type_value = (event.target.dataset.name)
    product_type.innerText = product_type_value
    getdropdownids
    toggling();
    event.preventDefault();
  });
};

const dropdownPrice = () => {
  const price = document.getElementById("DropdownPrice");
  if (!price) return

  price.addEventListener("click", (event) => {
    const product_price_value = (event.target.dataset.name)
    product_price.innerText = product_price_value
    getdropdownids
    const displayPricesEl = document.querySelectorAll('[data-priceshop]'); // node list de tous les data-price-shop
    displayPricesEl.forEach((displayPrice) => {
      if (product_price.innerText === "magasin") {
        displayPrice.innerText = displayPrice.dataset.priceshop;
      }
      else {displayPrice.innerText = displayPrice.dataset.pricenonshop;
      };

    });
    event.preventDefault();
  });
};

const toggling = () => {
  let productCardsHiddenCounter = 0;
  $(".card-product").each(function() {
    if (
      ($(this).data("fruit") === product_fruit.innerText || product_fruit.innerText === 'Fruit') &&
      ($(this).data("type")  === product_type.innerText  || product_type.innerText === 'Type')
      )  {
      this.style.display = "";
    }
    else { this.style.display = "none";
    productCardsHiddenCounter++; // compteur incrémenté pour chaque produit caché
    };
  });
  const warningEmptyFilter = document.getElementById("JSwarningemptyfilter");
  if ($(".card-product").length === productCardsHiddenCounter) {
    warningEmptyFilter.style.display = ""
    warningEmptyFilter.innerText = "Il n'y a pas de produits disponibles à la vente correspondant à votre sélection."}
  else { warningEmptyFilter.style.display = "none"
  };
};

export { dropdownFruit } ;
export { dropdownType } ;
export { dropdownPrice } ;

// ANCIEN CODE AVEC BOUTON EFFACER LES FILTRES (PLUS NECESSAIRE)
// const clearFilters = () => {
//   const clearFilters = document.getElementById("clear_filters");
//   if (!clearFilters) return

//   clearFilters.addEventListener("click", (event) => {
//     $(".card-product").each(function() {
//       this.style.display = "";
//     });
//     product_fruit.innerText = 'Fruit';
//     product_category.innerText = 'Catégorie';
//     product_type.innerText = 'Type';
//     product_price.innerText = 'Prix';
//     // on affiche les prix non-magasin (pourrait être mutualisé avec fonction dropdownPrice ci-dessus)
//     const displayPricesEl = document.querySelectorAll('[data-priceshop]');
//     displayPricesEl.forEach((displayPrice) => {
//       displayPrice.innerText = displayPrice.dataset.pricenonshop;
//     });
//     event.preventDefault();
//   });
// };

// DROPDOWNS CLIENT INDEX

const dropdownSegment = () => {
  const segment = document.getElementById("DropdownSegment");
  if (!segment) return

  segment.addEventListener("click", (event) => {
    const segment_value = (event.target.dataset.name)
    const segment = document.getElementById("client_segment");
    segment.innerText = segment_value
    url_client_path();
  });
};

const dropdownAmap = () => {
  const amap = document.getElementById("DropdownAmap");
  if (!amap) return

  amap.addEventListener("click", (event) => {
    const amap_value = (event.target.dataset.name)
    const amap = document.getElementById("client_amap");
    amap.innerText = amap_value
    url_client_path();
  });
};

const segmentRequest = () => {
let segmentQuery ="";
const segment = document.getElementById("client_segment");
    if (segment.innerText !== 'Segment') {
      segmentQuery = "&segment=" + segment.innerText
    };
return segmentQuery;
};

const amapRequest = () => {
let amapQuery ="";
const amap = document.getElementById("client_amap");
    if (amap.innerText !== 'Amap') {
      amapQuery = "&amap=" + amap.innerText
    };
return amapQuery;
};

const url_client_path = () => {
const url = window.location.origin + window.location.pathname + "?" + segmentRequest() + amapRequest();
window.location.href = url;
};

export { dropdownSegment } ;
export { dropdownAmap } ;

// DROPDOWNS ORDER INDEX

const dropdownSegmentOrders = () => {
  const segmentOrders = document.getElementById("dropdownSegmentOrders");
  if (!segmentOrders) return

  segmentOrders.addEventListener("click", (event) => {
    const segment_orders_value = (event.target.dataset.name)
    const segmentOrders = document.getElementById("order_client_segment");
    segmentOrders.innerText = segment_orders_value
    url_order_path();
  });
};

const dropdownStatusOrders = () => {
  const statusOrders = document.getElementById("dropdownStatusOrders");
  if (!statusOrders) return

  statusOrders.addEventListener("click", (event) => {
    const status_value = (event.target.dataset.name)
    const statusOrders = document.getElementById("order_status");
    statusOrders.innerText = status_value
    url_order_path();
  });
};

const dropdownDeliveryOrders = () => {
  const deliveryOrders = document.getElementById("dropdownDeliveryOrders");
  if (!deliveryOrders) return

  deliveryOrders.addEventListener("click", (event) => {
    const delivery_value = (event.target.dataset.name)
    const deliveryOrders = document.getElementById("order_delivery_place");
    deliveryOrders.innerText = delivery_value
    url_order_path();
  });
};

const orderSegmentRequest = () => {
let orderSegmentQuery ="";
const segmentOrders = document.getElementById("order_client_segment");
    if (segmentOrders.innerText !== 'Segment') {
      orderSegmentQuery = "&segment_order=" + segmentOrders.innerText
    };
return orderSegmentQuery;
};

const orderStatusRequest = () => {
let orderStatusQuery ="";
const statusOrders = document.getElementById("order_status");
    if (statusOrders.innerText !== 'Statut') {
      orderStatusQuery = "&status=" + statusOrders.innerText
    };
return orderStatusQuery;
};

const orderDeliveryRequest = () => {
let orderDeliveryQuery ="";
const deliveryOrders = document.getElementById("order_delivery_place");
    if (deliveryOrders.innerText !== 'Lieu de livraison') {
      orderDeliveryQuery = "&delivery_place=" + deliveryOrders.innerText
    };
return orderDeliveryQuery;
};

const url_order_path = () => {
const url = window.location.origin + window.location.pathname + "?" + orderSegmentRequest() + orderStatusRequest() + orderDeliveryRequest();
window.location.href = url;
};

export { dropdownSegmentOrders } ;
export { dropdownStatusOrders } ;
export { dropdownDeliveryOrders } ;
