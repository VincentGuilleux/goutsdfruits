const dropdownFruit = () => {
  const fruit = document.getElementById("DropdownFruit");

  fruit.addEventListener("click", (event) => {

    const product_fruit_value = (event.target.dataset.name)
    const product_fruit = document.getElementById("product_fruit");
    product_fruit.innerText = product_fruit_value
    url_path();
    // const url = window.location.origin + window.location.pathname + "?fruit=" + product_fruit
    // window.location.href = url;
    // +  "?category=" + product_category.innerText
  });
};

const dropdownCategory = () => {
  const category = document.getElementById("DropdownCategory");

  category.addEventListener("click", (event) => {
    const product_category_value = (event.target.dataset.name)
    const product_category = document.getElementById("product_category");
    product_category.innerText = product_category_value
    url_path();
  });
};

const dropdownType = () => {
  const type = document.getElementById("DropdownType");

  type.addEventListener("click", (event) => {
    const product_type_value = (event.target.dataset.name)
    const product_type = document.getElementById("product_type");
    product_type.innerText = product_type_value
    url_path();
  // type.addEventListener("click", (event) => {
  //   const targetType = (event.target.dataset.name)
  //   const url = window.location.origin + window.location.pathname + "?type=" + targetType
  //   window.location.href = url;
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
