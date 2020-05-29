const counter = () => {
  const counter = document.getElementById("counter");

  counter.addEventListener("click", (event) => {
    console.log("test");
    const counter_value = (event.target.dataset.name)
  });
};

export { counter } ;
