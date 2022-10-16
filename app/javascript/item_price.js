window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxPrice = document.getElementById("add-tax-price");
    addTaxPrice.innerHTML = Math.floor(inputValue * 1.1 - inputValue);
    const addTaxDom = document.getElementById("profit");
    addTaxDom.innerHTML = Math.floor(inputValue - addTaxPrice.innerHTML);

});
});