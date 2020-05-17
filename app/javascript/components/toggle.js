const togglePrice = () => {
  const togglePrice = document.getElementById("price_toggle");

  togglePrice.addEventListener("click", (event) => {
    const togglePriceValue = event.currentTarget.innerText
    togglePriceValue == "Prix particulier"? togglePrice.innerText = "Prix magasin" : togglePrice.innerText = "Prix particulier"
  });
};

export { togglePrice } ;
