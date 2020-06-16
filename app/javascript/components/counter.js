const counter = () => {

  // MAJ PRIX - ADMIN
    const updatePrice = (uuid) => {
      // querySelectorAll renvoit toujours un array c'est pour ça qu'on met [Ø] pour qu'il renvoit le 1er élement
      let productDropdownEl = document.querySelectorAll('select[data-uuid="' + uuid + '"]')[0];
      // à partir du Dropdown global de tous les produits, sélection pour le produit cliqué de son option value
      let selectedProductId = productDropdownEl.options[productDropdownEl.selectedIndex].value;
      let productPrice = prices[selectedProductId];
      // priceEl correspond à l'attribut HTML span qui contient le prix pour la ligne dans son innerHMTL
      let priceEl = document.querySelectorAll('span[data-uuid="' + uuid + '"]')[0];
      // inputEl correspond à l'attribut HTML input du formulaire qui contient la quantité commandée pour la order_line en cours (valeur stockée dans inputEl.value)
      let inputEl = document.querySelectorAll('input[data-uuid="' + uuid + '"]')[0];
      // MAJ du prix de l'order_line (est désormais )égal à la quantité * prix du produit sélectionné)
      priceEl.innerText = (inputEl.value * productPrice) / 100;

      // Calcul du prix total de la commande
      let totalPrice = 0;
      let allPricesEl = document.querySelectorAll('.JSpriceperline');
      for (let i = 0; i < allPricesEl.length; i++) {
        totalPrice = (parseFloat(totalPrice) + parseFloat(allPricesEl[i].innerText)).toFixed(2)
      }
      let totalpriceEl = document.getElementById("totalprice");
      totalpriceEl.innerText = totalPrice;
    };

     // MAJ PRIX - CLIENT
    const updatePriceProductIndex = (uuid) => {
      let productPrice = prices[uuid];
      // inputEl correspond à l'attribut HTML input qui contient la quantité commandée pour le produit sélectionné
      let inputEl = document.getElementById(uuid);
      // On affiche la quantité commandée sur la carte sauf si nulle
      inputEl.style.visibility = "visible";
      if (inputEl.innerText == 0) inputEl.style.visibility = "hidden";
      // MAJ du priceEl qui correspond au prix affiché sur la carte produit
      let priceEl = document.querySelectorAll('span[data-uuid="' + uuid + '"]')[0];
      priceEl.innerText = (inputEl.innerText * productPrice / 100).toFixed(2);
      // Calcul du prix total affiché en haut de page
      let totalPrice = 0;
      let allPricesEl = document.querySelectorAll('.JSpriceperlineproductindex');
      for (let i = 0; i < allPricesEl.length; i++) {
        allPricesEl[i].style.visibility = "visible"; // obligé de toggler visible le prix sur la carte sinon calcul ci-dessous ne fonctionne pas
        totalPrice = (parseFloat(totalPrice) + parseFloat(allPricesEl[i].innerText)).toFixed(2)
        if (allPricesEl[i].innerText == 0) allPricesEl[i].style.visibility = "hidden"; //  on retoggle hidden le prix de chacune des cartes produit si nul
      }
      let totalpriceEl = document.getElementById("totalpriceproductindex");
      totalpriceEl.innerText = totalPrice;
      // on affiche le prix sur la carte produit sauf si nul
      priceEl.style.visibility = "visible";
      if (priceEl.innerText == 0) priceEl.style.visibility = "hidden";
    };

  document.body.addEventListener( 'click', function ( event ) {
    // BOUTON PLUS - ADMIN
    if( event.target.matches(".JSpluscounter")) {
      // On récupère l'uuid de la order_line correspondante
      let uuid = event.target.dataset.uuid;
      // inputEl.value stocke la quantité sélectionnée jusque là
      let inputEl = document.querySelectorAll('input[data-uuid="' + uuid + '"]')[0];
      // Bloc ci-dessous pour checker qu'on ne commande pas plus que la remaining quantity
      let productDropdownEl = document.querySelectorAll('select[data-uuid="' + uuid + '"]')[0];
      let selectedProductId = productDropdownEl.options[productDropdownEl.selectedIndex].value;
      let productRemainingQuantity = remainingQuantities[selectedProductId];
      if (productRemainingQuantity > inputEl.value) {
        inputEl.value = parseInt(inputEl.value) + 1;
        updatePrice(uuid);
        }
    };
    // BOUTON MOINS - ADMIN
    if( event.target.matches(".JSminuscounter")) {
      let uuid = event.target.dataset.uuid;
      let inputEl = document.querySelectorAll('input[data-uuid="' + uuid + '"]')[0];
      if (inputEl.value > 0) {
        inputEl.value = parseInt(inputEl.value) - 1;
        updatePrice(uuid);
      };
    };
    // BOUTON PLUS - CLIENT
    if( event.target.matches(".JSpluscounterproductindex")) {
      let uuid = event.target.dataset.uuid; // uuid = data-uuid de l'élément targeté = product.id
      let ratio = ratiosQuantities[uuid]; // ratio quantity shop vs particulier
      let inputEl = document.getElementById(uuid); // inputEl = champ contenant la quantité commandée sur la carte produit
      inputEl.style.visibility = "visible"; // nécessaire car sinon renvoit NaN
      let inputFormEl = document.querySelectorAll('input[data-product-id="' + uuid + '"]')[0]; // inputFormEl = champ du formulaire (caché) avec la quantité
      // MAJ de la quantité commandée sur la carte produit et de la quantité commandée dans le formulaire caché
      let productRemainingQuantity = remainingQuantities[uuid];
      if (productRemainingQuantity > inputEl.innerText) { // si quantité restante > quantité demandée par le client
        inputEl.innerText = parseInt(inputEl.innerText) + 1;
        // inputEl.innerText = quantité sélectionnée jusque là qu'on incrémente de 1
        inputFormEl.value = parseInt(inputFormEl.value) + (1 * ratio);
        // inputFormEl.value = quantité du formulaire caché qu'on incrémente de 1 * le ratio quantity shop vs particulier
        updatePriceProductIndex(uuid);
        }
      // masquage du bouton plus si quantité max dispo atteinte
      if (productRemainingQuantity == inputEl.innerText) event.target.style.visibility = "hidden";
      // affichage du bouton - (à chaque fois qu'on clique sur le bouton +)
      let minusButtonEl = document.querySelectorAll('i[data-uuid="' + uuid + '"]')[1];
      minusButtonEl.style.visibility = "visible";
    };

    // BOUTON MOINS - CLIENT
    if( event.target.matches(".JSminuscounterproductindex")) {
      let uuid = event.target.dataset.uuid;
      let ratio = ratiosQuantities[uuid];
      let inputEl = document.getElementById(uuid);
      let inputFormEl = document.querySelectorAll('input[data-product-id="' + uuid + '"]')[0];
      // décrémentation
      if (inputEl.innerText > 0) {
        inputEl.innerText = parseInt(inputEl.innerText) - 1;
        inputFormEl.value = parseInt(inputFormEl.value) - (1 * ratio);
        updatePriceProductIndex(uuid);
      };
      // masquage du bouton - si quantité 0
      if (inputEl.innerText == 0 ) event.target.style.visibility = "hidden";
      // affichage du bouton + (à chaque fois qu'on clique sur le bouton -)
      let plusButtonEl = document.querySelectorAll('i[data-uuid="' + uuid + '"]')[0];
      plusButtonEl.style.visibility = "visible";

    }

    // product description - client pour chargement de l'info dans la modal
    if( event.target.matches(".JSproductname")) {
      let uuid = event.target.dataset.uuid;
      let inputEl = document.getElementById("product_description");
      let productDescription = descriptions[uuid];
      inputEl.innerText = productDescription;
    };

  }); // end of document.body.addEventListenerFunction

  // CMD ADMIN - EVENT LISTENER DE RECALCUL DU PRIX SUR N'IMPORTE QUEL CLIC DANS LE FORMULAIRE
  document.body.addEventListener( 'change', function ( event ) {

    if( event.target.matches(".JSproductselect")) {
      let uuid = event.target.dataset.uuid;
      updatePrice(uuid);
    };
  });

};

export { counter } ;
