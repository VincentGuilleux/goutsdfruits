const dropdownFruit = () => {
  const test = document.getElementById("DropdownFruit");
  test.addEventListener("click", (event) => {
    console.log('fruit');
    console.log(event);
    console.log(event.currentTarget);
  });
};

const dropdownCategory = () => {
  const test = document.getElementById("DropdownCategory");
  test.addEventListener("click", (event) => {
    console.log('cat');
    console.log(event);
    console.log(event.currentTarget);
  });
};

const dropdownType = () => {
  const test = document.getElementById("DropdownType");
  test.addEventListener("click", (event) => {
    console.log('type');
    console.log(event);
    console.log(event.currentTarget);
  });
};

export { dropdownFruit } ;
export { dropdownCategory } ;
export { dropdownType } ;
