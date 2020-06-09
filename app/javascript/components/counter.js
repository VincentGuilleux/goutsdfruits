const counter = () => {

  // Sous-fonction pour mise à jour du prix de la ligne (commande admin)
    const updatePrice = (uuid) => {
      let productDropdownEl = document.querySelectorAll('select[data-uuid="' + uuid + '"]')[0];
      let selectedProductId = productDropdownEl.options[productDropdownEl.selectedIndex].value;
      // à partir du Dropdown global de tous les produits, sélection pour le produit cliqué de son option value
      let productPrice = prices[selectedProductId];
      let priceEl = document.querySelectorAll('span[data-uuid="' + uuid + '"]')[0];
      // priceEl correspond à l'attribut HTML span qui contient le prix pour la ligne dans son innerHMTL
      let inputEl = document.querySelectorAll('input[data-uuid="' + uuid + '"]')[0];
      // inputEl correspond à l'attribut HTML input qui contient la quantité commandée pour la order_line en cours dans inputEl.value
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

     // Sous-fonction pour mise à jour du prix de la ligne (commande client)
    const updatePriceProductIndex = (uuid) => {
      let productPrice = prices[uuid];
      // console.log(productPrice);
      let inputEl = document.getElementById(uuid);
      inputEl.removeAttribute("hidden");
      if (inputEl.innerText == 0) inputEl.setAttribute("hidden", true);
      // inputEl correspond à l'attribut HTML input qui contient la quantité commandée pour la order_line en cours
      let priceEl = document.querySelectorAll('span[data-uuid="' + uuid + '"]')[0];
      priceEl.innerHTML = (inputEl.innerText * productPrice) / 100;
      priceEl.removeAttribute("hidden");
      if (priceEl.innerHTML == 0) priceEl.setAttribute("hidden", true);
      // console.log(priceEl.innerHTML);
      // Le prix à afficher pour l'order_line est désormais égal à la quantité  * prix du produit sélectionné

      let totalPrice = 0;
      let allPricesEl = document.querySelectorAll('.JSpriceperlineproductindex');
      for (let i = 0; i < allPricesEl.length; i++) {
        totalPrice = (parseFloat(totalPrice) + parseFloat(allPricesEl[i].innerText)).toFixed(2)
      }
      let totalpriceEl = document.getElementById("totalpriceproductindex");
      totalpriceEl.innerHTML = totalPrice;
    };

  document.body.addEventListener( 'click', function ( event ) {
    // commande admin
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
        inputEl.value = parseInt(inputEl.value) + 1;
        updatePrice(uuid);
        }
    };
    // commande admin
    if( event.target.matches(".JSminuscounter")) {
      let uuid = event.target.dataset.uuid;
      let inputEl = document.querySelectorAll('input[data-uuid="' + uuid + '"]')[0];
      if (inputEl.value > 0) {
        inputEl.value = parseInt(inputEl.value) - 1;
        updatePrice(uuid);
      };
    };
    // commande client
    if( event.target.matches(".JSpluscounterproductindex")) {
      let uuid = event.target.dataset.uuid;
      let inputEl = document.getElementById(uuid);
      let inputFormEl = document.querySelectorAll('input[data-product-id="' + uuid + '"]')[0];
      // querySelectorAll renvoit toujours un array c'est pour ça qu'on met [Ø] pour qu'il renvoit l'élément sans qu'il soit un array
      // On stocke dans inputEl.innerText la quantité sélectionnée jusque là
      let productRemainingQuantity = remainingQuantities[uuid];
      if (productRemainingQuantity > inputEl.innerText) {
        inputEl.innerText = parseInt(inputEl.innerText) + 1;
        inputFormEl.value = parseInt(inputFormEl.value) + 1;
        updatePriceProductIndex(uuid);
        }
    };
    // commande client
    if( event.target.matches(".JSminuscounterproductindex")) {
      let uuid = event.target.dataset.uuid;
      let inputEl = document.getElementById(uuid);
      // On stocke dans inputEl.innerText la quantité sélectionnée jusque là
      if (inputEl.innerText > 0) {
        inputEl.innerText = parseInt(inputEl.innerText) - 1;
        updatePriceProductIndex(uuid);
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
