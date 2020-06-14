const counter = () => {

  // Sous-fonction pour mise à jour du prix de la ligne - admin
    const updatePrice = (uuid) => {
      let productDropdownEl = document.querySelectorAll('select[data-uuid="' + uuid + '"]')[0];
      // querySelectorAll renvoit toujours un array c'est pour ça qu'on met [Ø] pour qu'il renvoit l'élément sans qu'il soit un array
      let selectedProductId = productDropdownEl.options[productDropdownEl.selectedIndex].value;
      // à partir du Dropdown global de tous les produits, sélection pour le produit cliqué de son option value
      let productPrice = prices[selectedProductId];
      let priceEl = document.querySelectorAll('span[data-uuid="' + uuid + '"]')[0];
      // priceEl correspond à l'attribut HTML span qui contient le prix pour la ligne dans son innerHMTL
      let inputEl = document.querySelectorAll('input[data-uuid="' + uuid + '"]')[0];
      // inputEl correspond à l'attribut HTML input du formulaire qui contient la quantité commandée pour la order_line en cours (valeur stockée dans inputEl.value)
      priceEl.innerHTML = (inputEl.value * productPrice) / 100;
      // Le prix à afficher pour l'order_line est désormais égal à la quantité * prix du produit sélectionné

      let totalPrice = 0;
      let allPricesEl = document.querySelectorAll('.JSpriceperline');
      for (let i = 0; i < allPricesEl.length; i++) {
        // console.log('allPricesEl: ', allPricesEl[i].innerText);
        totalPrice = (parseFloat(totalPrice) + parseFloat(allPricesEl[i].innerText)).toFixed(2)
      }
      let totalpriceEl = document.getElementById("totalprice");
      totalpriceEl.innerHTML = totalPrice;
    };

     // Sous-fonction pour mise à jour du prix de la ligne - client
    const updatePriceProductIndex = (uuid) => {
      let productPrice = prices[uuid];
      let inputEl = document.getElementById(uuid);
      // inputEl correspond à l'attribut HTML input qui contient la quantité commandée pour le produit sélectionné
      inputEl.removeAttribute("hidden");
      if (inputEl.innerText == 0) inputEl.setAttribute("hidden", true);
      // On affiche la quantité sauf si nulle
      let priceEl = document.querySelectorAll('span[data-uuid="' + uuid + '"]')[0];
      priceEl.innerHTML = (inputEl.innerText * productPrice / 100).toFixed(2);
      // priceEl correspond au prix affiché sur la carte produit qui est mis à jour ici
      priceEl.removeAttribute("hidden");
      if (priceEl.innerHTML == 0) priceEl.setAttribute("hidden", true);
      // On affiche le prix sauf si nul

      let totalPrice = 0;
      let allPricesEl = document.querySelectorAll('.JSpriceperlineproductindex');
      for (let i = 0; i < allPricesEl.length; i++) {
        totalPrice = (parseFloat(totalPrice) + parseFloat(allPricesEl[i].innerText)).toFixed(2)
      }
      let totalpriceEl = document.getElementById("totalpriceproductindex");
      totalpriceEl.innerHTML = totalPrice;
      // mise à jour du prix total affiché au dessus du formulaire
    };

  document.body.addEventListener( 'click', function ( event ) {
    // plus - admin
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
    // moins - admin
    if( event.target.matches(".JSminuscounter")) {
      let uuid = event.target.dataset.uuid;
      let inputEl = document.querySelectorAll('input[data-uuid="' + uuid + '"]')[0];
      if (inputEl.value > 0) {
        inputEl.value = parseInt(inputEl.value) - 1;
        updatePrice(uuid);
      };
    };
    // plus - client
    if( event.target.matches(".JSpluscounterproductindex")) {
      let uuid = event.target.dataset.uuid; // uuid = data-uuid de l'élément targeté = product.id
      let ratio = ratiosQuantities[uuid]; // ratio quantity shop vs particulier
      let inputEl = document.getElementById(uuid); // inputEl = champ contenant la quantité commandée sur la carte produit
      let inputFormEl = document.querySelectorAll('input[data-product-id="' + uuid + '"]')[0]; // inputFormEl = champ du formlaire (caché) avec la quantité
      let productRemainingQuantity = remainingQuantities[uuid];
      if (productRemainingQuantity > inputEl.innerText) { // on vérifie que la quantité restante est supérieure à l'input de l'utilisateur
        inputEl.innerText = parseInt(inputEl.innerText) + 1;
        // inputEl.innerText = la quantité sélectionnée jusque là qu'on incrémente de 1
        inputFormEl.value = parseInt(inputFormEl.value) + (1 * ratio);
        // inputFormEl.value = la quantité du formulaire caché qu'on incrémente de 1 * le ratio quantity shop vs particulier
        updatePriceProductIndex(uuid);
        }
    };
    // moins - client
    if( event.target.matches(".JSminuscounterproductindex")) {
      let uuid = event.target.dataset.uuid;
      let ratio = ratiosQuantities[uuid];
      let inputEl = document.getElementById(uuid);
      let inputFormEl = document.querySelectorAll('input[data-product-id="' + uuid + '"]')[0];;
      if (inputEl.innerText > 0) {
        inputEl.innerText = parseInt(inputEl.innerText) - 1;
        inputFormEl.value = parseInt(inputFormEl.value) - (1 * ratio);
        updatePriceProductIndex(uuid);
      };
    };

    // product description - client
    if( event.target.matches(".JSproductname")) {
      let uuid = event.target.dataset.uuid;
      let inputEl = document.getElementById("product_description");
      let productDescription = descriptions[uuid];
      inputEl.innerText = productDescription;
    };

  }); // end of document.body.addEventListenerFunction

  document.body.addEventListener( 'change', function ( event ) {

    if( event.target.matches(".JSproductselect")) {
      let uuid = event.target.dataset.uuid;
      updatePrice(uuid);
    };
  });

};

export { counter } ;
