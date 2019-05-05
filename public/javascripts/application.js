var orderDoneBtn = document.querySelector('#orderDoneBtn');

var handleDone = function () {
  alert("Thank you for your order!");
}

if (orderDoneBtn) {
  orderDoneBtn.addEventListener('click', handleDone);
}
