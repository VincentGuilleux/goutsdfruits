const Pluscounter = () => {
//   const pluscounters = document.getElementsByClassName("pluscounter");
//   for (var i = 0; i < pluscounters.length; i++) {
//     pluscounters[i].addEventListener('click', (event) => {
//       console.log("test");
//       const counter_value = (event.target.dataset.name)
//     });
//   };
// };

document.body.addEventListener( 'click', function ( event ) {
  if( event.target.matches(".pluscounter")) {
    let uuid = event.target.dataset.uuid;
    let inputEl = document.querySelectorAll('input[data-uuid="' + uuid + '"]')[0];
    inputEl.value = parseInt(inputEl.value) + 1;
  };
});
};


export { Pluscounter } ;
