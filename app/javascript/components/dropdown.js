// DROPDOWNS PRODUCT INDEX
// Les méthodes ci-dessous écoutent les clicks sur chacun des dropdown menus et renvoient la valeur cliquée

const getdropdownids = () => {
  const product_fruit = document.getElementById("product_fruit"); // target l'id du champ fruit (le "titre" du Dropdown Menu)
  const product_category = document.getElementById("product_category");
  const product_type = document.getElementById("product_type");
};

const dropdownFruit = () => {
  const fruit = document.getElementById("DropdownFruit");
  if (!fruit) return

  fruit.addEventListener("click", (event) => {
    const product_fruit_value = (event.target.dataset.name) // stocke le fruit sur lequel l'utilisateur a cliqué
    getdropdownids
    product_fruit.innerText = product_fruit_value // on remplace dans l'HTML le titre du Dropdown menu par la valeur cliquée
    toggling(); // fonction qui itère sur chaque carte produit pour l'afficher ou non
    event.preventDefault(); // vient prévenir le rechargement de la page par le navigateur (du au fait que le dropdown menu a une balise a avec href)
   //  url_path(); // appel à la fonction plus qui construit l'URL de recherche
  });
};

const dropdownCategory = () => {
  const category = document.getElementById("DropdownCategory");
  if (!category) return

  category.addEventListener("click", (event) => {
    const product_category_value = (event.target.dataset.name)
    getdropdownids
    product_category.innerText = product_category_value
    toggling();
    event.preventDefault();
    // url_path();
  });
};

const dropdownType = () => {
  const type = document.getElementById("DropdownType");
  if (!type) return

  type.addEventListener("click", (event) => {
    const product_type_value = (event.target.dataset.name)
    getdropdownids
    product_type.innerText = product_type_value
    toggling();
    event.preventDefault();
    // url_path();
  });
};

const dropdownPrice = () => {
  const price = document.getElementById("DropdownPrice");
  if (!price) return

  price.addEventListener("click", (event) => {
    const product_price_value = (event.target.dataset.name)
    const product_price = document.getElementById("product_price");
    product_price.innerText = product_price_value
    url_path();
  });
};

const clearFilters = () => {
  const clearFilters = document.getElementById("clear_filters");
  clearFilters.addEventListener("click", (event) => {
    $(".card-product").each(function() {
      this.style.display = "";
    });
    product_fruit.innerText = 'Fruit';
    product_category.innerText = 'Catégorie';
    product_type.innerText = 'Type';
    event.preventDefault();
  });
};

const toggling = () => {
  $(".card-product").each(function() {
    if (
      ($(this).data("fruit")    === product_fruit.innerText    || product_fruit.innerText === 'Fruit') &&
      ($(this).data("category") === product_category.innerText || product_category.innerText === 'Catégorie') &&
      ($(this).data("type")     === product_type.innerText     || product_type.innerText === 'Type')
      )  {
      this.style.display = "";
    }
    else { this.style.display = "none";
    };
  });
};

export { dropdownFruit } ;
export { dropdownCategory } ;
export { dropdownType } ;
export { dropdownPrice } ;
export { clearFilters } ;

// CODE SUPPRIME : CODE V1 QUI RECHARGAIT LA PAGE, CHAQUE FONCTION DROPDOWN LANCAIT A LA FIN L'URL LA FONTION URL_PATH CI CI-DESSOUS QUI VENAIT CONSTRUIRE L'URL DE RECHERCHE ET RECHARGER LA PAGE EN FONCTION
// const url_path = () => {
// const url = window.location.origin + window.location.pathname + "?" + fruitRequest() + categoryRequest() + typeRequest() + priceRequest() ;
// window.location.href = url;
// https://stackoverflow.com/questions/47583856/window-location-href-vs-history-pushstate-which-to-use#:~:text=location.,the%20other%20hand%2C%20what%20history.&text=pushState()%20changes%20the%20referrer,after%20you%20change%20the%20state.
// };

// const fruitRequest = () => {
// let fruitQuery ="";
// const product_fruit = document.getElementById("product_fruit");
//     if (product_fruit.innerText !== 'Fruit') {
//       fruitQuery = "&fruit=" + product_fruit.innerText
//     };
// return fruitQuery;
// };

// const categoryRequest = () => {
// let catQuery ="";
// const product_category = document.getElementById("product_category");
//     if (product_category.innerText !== 'Catégorie') {
//       catQuery = "&category=" + product_category.innerText
//     };
// return catQuery;
// };

// const typeRequest = () => {
// let typeQuery ="";
// const product_type = document.getElementById("product_type");
//     if (product_type.innerText !== 'Type') {
//       typeQuery = "&type=" + product_type.innerText
//     };
// return typeQuery;
// };

// const priceRequest = () => {
// let priceQuery ="";
// const product_price = document.getElementById("product_price");
//   if (product_price !== null) { // condition nécessaire car pour les non-admin le priceRequest n'apparait pas
//     if (product_price.innerText !== 'Prix') {
//       priceQuery = "&price=" + product_price.innerText
//     };
//   };
// return priceQuery;
// };

// --------------------------------------------------------------------------------

// DROPDOWNS CLIENT INDEX
const dropdownSegment = () => {
  const segment = document.getElementById("DropdownSegment");
  if (!segment) return

  segment.addEventListener("click", (event) => {
    console.log(event);
    const segment_value = (event.target.dataset.name)
    const segment = document.getElementById("client_segment");
    segment.innerText = segment_value
    url_client_path();
  });
};

const url_client_path = () => {
const url = window.location.origin + window.location.pathname + "?" + segmentRequest();
window.location.href = url;
};

const segmentRequest = () => {
let segmentQuery ="";
const segment = document.getElementById("client_segment");
    if (segment.innerText !== 'Segment') {
      segmentQuery = "&segment=" + segment.innerText
    };
return segmentQuery;
};

export { dropdownSegment } ;


// --------------------------------------------------------------------------------

// DROPDOWNS ORDER INDEX

// filtre segment

const dropdownSegmentOrders = () => {
  const segmentOrders = document.getElementById("dropdownSegmentOrders");
  if (!segmentOrders) return

  segmentOrders.addEventListener("click", (event) => {
    console.log(event);
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
    console.log(event);
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
    console.log(event);
    const delivery_value = (event.target.dataset.name)
    const deliveryOrders = document.getElementById("order_delivery_place");
    deliveryOrders.innerText = delivery_value
    url_order_path();
  });
};

const url_order_path = () => {
const url = window.location.origin + window.location.pathname + "?" + orderSegmentRequest() + orderStatusRequest() + orderDeliveryRequest();
window.location.href = url;
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

export { dropdownSegmentOrders } ;
export { dropdownStatusOrders } ;
export { dropdownDeliveryOrders } ;
