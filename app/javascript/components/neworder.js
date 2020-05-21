const updateCounter = (counter, count) => {
  counter.dataset.count = count;
  counter.innerText = count;
};

const updateInput = (priceCents) => {
  const input = document.getElementById('price-input');
  input.value = priceCents;
};

const updateCTA = (priceCents) => {
  const button = document.getElementById('submit');
  button.value = `Pay ${priceCents / 100}€`;
};

const updateForm = (event) => {
  console.log("toto");
  const offset = Number.parseInt(event.currentTarget.dataset.offset, 10);
  const counter = document.getElementById('counter');
  const count = Number.parseInt(counter.dataset.count, 10) + offset;
  const unitPriceCents = document.getElementById('price').dataset.amountCents;
  const priceCents = unitPriceCents * count;
  if (count >= 1) { {}
    updateCounter(counter, count);
    updateInput(priceCents);
    updateCTA(priceCents);
  } else {
    event.preventDefault();
  }
};

const updateFormOnButtonClick = (button) => {
  button.addEventListener('click', updateForm);
};

const buttons = document.querySelectorAll('.incrementer');
buttons.forEach(updateFormOnButtonClick);

export { updateForm } ;
