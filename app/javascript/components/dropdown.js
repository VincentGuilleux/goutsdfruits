// DROPDOWNS PRODUCT INDEX
// Les méthodes ci-dessous écoutent les clicks sur chacun des dropdown menus et renvoient la valeur cliquée
const dropdownFruit = () => {
  const fruit = document.getElementById("DropdownFruit");
  if (!fruit) return

  fruit.addEventListener("click", (event) => {
    const product_fruit_value = (event.target.dataset.name) // récupère le fruit sur lequel l'utilisateur a cliqué
    const product_fruit = document.getElementById("product_fruit"); // on target ici l'id du champ fruit
    product_fruit.innerText = product_fruit_value // on assigne au champ ci-dessus le nom du fruit sur lequel l'utilisateur a cliqué afin de mettre à jour l'HTML
    url_path(); // appel à la fonction plus qui construit l'URL de recherche
  });
};

const dropdownCategory = () => {
  const category = document.getElementById("DropdownCategory");
  if (!category) return

  category.addEventListener("click", (event) => {
    const product_category_value = (event.target.dataset.name)
    const product_category = document.getElementById("product_category");
    product_category.innerText = product_category_value
    url_path();
  });
};

const dropdownType = () => {
  const type = document.getElementById("DropdownType");
  if (!type) return

  type.addEventListener("click", (event) => {
    const product_type_value = (event.target.dataset.name)
    const product_type = document.getElementById("product_type");
    product_type.innerText = product_type_value
    url_path();
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

const url_path = () => {
const url = window.location.origin + window.location.pathname + "?" + fruitRequest() + categoryRequest() + typeRequest() + priceRequest() ;
window.location.href = url;
};

const fruitRequest = () => {
let fruitQuery ="";
const product_fruit = document.getElementById("product_fruit");
    if (product_fruit.innerText !== 'Fruit') {
      fruitQuery = "&fruit=" + product_fruit.innerText
    };
return fruitQuery;
};

const categoryRequest = () => {
let catQuery ="";
const product_category = document.getElementById("product_category");
    if (product_category.innerText !== 'Catégorie') {
      catQuery = "&category=" + product_category.innerText
    };
return catQuery;
};

const typeRequest = () => {
let typeQuery ="";
const product_type = document.getElementById("product_type");
    if (product_type.innerText !== 'Type') {
      typeQuery = "&type=" + product_type.innerText
    };
return typeQuery;
};

const priceRequest = () => {
let priceQuery ="";
const product_price = document.getElementById("product_price");
    if (product_price.innerText !== 'Prix') {
      priceQuery = "&price=" + product_price.innerText
    };
return priceQuery;
};

export { dropdownFruit } ;
export { dropdownCategory } ;
export { dropdownType } ;
export { dropdownPrice } ;

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

const url_order_path = () => {
const url = window.location.origin + window.location.pathname + "?" + orderSegmentRequest() + orderStatusRequest();
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

export { dropdownSegmentOrders } ;
export { dropdownStatusOrders } ;
