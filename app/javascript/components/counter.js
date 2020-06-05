const counter = () => {

  // Sous-fonction pour mise à jour du prix de la ligne
    const updatePrice = (uuid) => {
      let productDropdownEl = document.querySelectorAll('select[data-uuid="' + uuid + '"]')[0];
      let selectedProductId = productDropdownEl.options[productDropdownEl.selectedIndex].value;
      // à partir du Dropdown global de tous les produits, sélection pour le produit cliqué de son option value
      let productPrice = prices[selectedProductId];
      let priceEl = document.querySelectorAll('span[data-uuid="' + uuid + '"]')[0];
      // console.log(priceEl.innerHTML);
      // priceEl correspond à l'attribut HTML span qui contient le prix pour la ligne
      let inputEl = document.querySelectorAll('input[data-uuid="' + uuid + '"]')[0];
      // console.log(inputEl.value);
      // inputEl correspond à l'attribut HTML input qui contient la quantité commandée pour la order_line en cours
      priceEl.innerHTML = (inputEl.value * productPrice) / 100;
      // console.log(priceEl.innerHTML);
      // Le prix à afficher pour l'order_line est désormais égal à la quantité  * prix du produit sélectionné

      let totalPrice = 0;
      let allPricesEl = document.querySelectorAll('.JSpriceperline');
      for (let i = 0; i < allPricesEl.length; i++) {
        // console.log('allPricesEl: ', allPricesEl[i].innerText);
        totalPrice = (parseFloat(totalPrice) + parseFloat(allPricesEl[i].innerText)).toFixed(2)
      }
      let totalpriceEl = document.getElementById("totalprice");
      totalpriceEl.innerHTML = totalPrice;
    };

  document.body.addEventListener( 'click', function ( event ) {

    if( event.target.matches(".JSpluscounter")) {
      // Si on clique sur plus
      let uuid = event.target.dataset.uuid;
      // On récupère l'uuid de la order_line correspondante
      let inputEl = document.querySelectorAll('input[data-uuid="' + uuid + '"]')[0];
      // On stocke dans inputEl.value la quantité sélectionnée jusque là

      // Bloc ci-dessous pour checker qu'on ne commande pas plus que la remaining quantity
      let productDropdownEl = document.querySelectorAll('select[data-uuid="' + uuid + '"]')[0];
      let selectedProductId = productDropdownEl.options[productDropdownEl.selectedIndex].value;
      let productRemainingQuantity = remainingQuantities[selectedProductId];
      // on stocke dans productRemainingQuantity la quantité restante du produit sélectionné depuis le Dropdown
      if (productRemainingQuantity > inputEl.value) {
        console.log("toto");
        inputEl.value = parseInt(inputEl.value) + 1;
        updatePrice(uuid);
        }
    };

    if( event.target.matches(".JSminuscounter")) {
      let uuid = event.target.dataset.uuid;
      let inputEl = document.querySelectorAll('input[data-uuid="' + uuid + '"]')[0];
      if (inputEl.value > 0) {
        inputEl.value = parseInt(inputEl.value) - 1;
        updatePrice(uuid);
      };

    };
  });

  document.body.addEventListener( 'change', function ( event ) {

    if( event.target.matches(".JSproductselect")) {
      let uuid = event.target.dataset.uuid;
      updatePrice(uuid);
    };
  });
};

export { counter } ;
