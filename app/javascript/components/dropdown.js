// Les 3 méthodes ci-dessous écoutent les clicks sur chacun des 3 dropdown menus et renvoient la valeur cliquée
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

const url_path = () => {
const url = window.location.origin + window.location.pathname + "?" + fruitRequest() + categoryRequest() + typeRequest() ;
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

export { dropdownFruit } ;
export { dropdownCategory } ;
export { dropdownType } ;

    // PREVIOUS RESEARCHS NOT USED FINALLY
    // console.log(event.toElement.text); ancienne méthode qui permettait de retriever le champ text de l'élement
    // console.log(event.toElement);
    // return the target element: <a href="#"><%= type %></a>
    // console.log(event.currentTarget);
    // returns the element whose event listener triggered the event = the whole div
    // console.log(event.target.nodeName);
    // returns the HTML element (=Node) that triggered the event = A (a href...)
    // console.log(event.currentTarget.nodeName);
    // returns the HTML element (=Node) whose event listener triggered the event = DIV

// dropdown filter client
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
