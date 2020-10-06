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
