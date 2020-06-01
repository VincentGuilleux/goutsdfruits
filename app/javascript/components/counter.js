const counter = () => {

  // Sous-fonction pour mise à jour du prix de la ligne
    const updatePrice = (uuid) => {
      let productDropdownEl = document.querySelectorAll('select[data-uuid="' + uuid + '"]')[0];
      let selectedProductId = productDropdownEl.options[productDropdownEl.selectedIndex].value;
      // à partir du Dropdown global de tous les produits, sélection pour le produit cliqué de son option value
      let productPrice = prices[selectedProductId];
      let priceEl = document.querySelectorAll('span[data-uuid="' + uuid + '"]')[0];
      let inputEl = document.querySelectorAll('input[data-uuid="' + uuid + '"]')[0];
      priceEl.innerHTML = (inputEl.value * productPrice) / 100;
    };

  document.body.addEventListener( 'click', function ( event ) {
    if( event.target.matches(".JSpluscounter")) {
      // Si on clique sur plus
      let uuid = event.target.dataset.uuid;
      // On récupère l'uuid de la order_line correspondante
      let inputEl = document.querySelectorAll('input[data-uuid="' + uuid + '"]')[0];
      inputEl.value = parseInt(inputEl.value) + 1;
      updatePrice(uuid);
    };
    if( event.target.matches(".JSminuscounter")) {
      // Décrémentation de la quantité
      let uuid = event.target.dataset.uuid;
      let inputEl = document.querySelectorAll('input[data-uuid="' + uuid + '"]')[0];
      console.log(inputEl);
      if (inputEl.value > 0) {
        inputEl.value = parseInt(inputEl.value) - 1;
        updatePrice(uuid);
      };
    };
  });
    // rajouter if( event.target.matches(".JSminuscounter")) bla bla + logique si = 0 pour éviter négatif

  document.body.addEventListener( 'change', function ( event ) {

    if( event.target.matches(".JSproductselect")) {
      let uuid = event.target.dataset.uuid;
      // console.log(event.target.selectedIndex);
      updatePrice(uuid);
    };
  });
};

export { counter } ;
