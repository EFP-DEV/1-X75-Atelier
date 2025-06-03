let add_buttons = document.querySelectorAll('section article button');
add_buttons.forEach((btn) => {
  btn.addEventListener('click', (e) => {
    let item_id = e.target
      .closest('[data-item-id]')
      .getAttribute('data-item-id');

    add(item_id);
  });
});
function sub(item_id) {
  let basket = load('mon_item');

  store(basket);
}

function add(item_id) {
  console.debug('adding item ', item_id);
  let basket = load('mon_item');
  let new_item = { id: item_id, q: 1 };
  let update = basket_has_item(basket, new_item);

  if (update !== false) {
    let old_item = basket[update];
    old_item.q += new_item.q;
    basket[update] = old_item;
  } else {
    basket.push(new_item);
  }

  store(basket);
}
function store(basket) {
  basket = JSON.stringify(basket);
  localStorage.setItem('mon_item', basket);
}

function load(key) {
  let basket = localStorage.getItem(key) ?? '[]';
  basket = JSON.parse(basket);
  return basket;
}

function basket_has_item(basket, new_item) {
  let update = false;
  basket.forEach((line, index) => {
    if (line.id === new_item.id) {
      update = index;
    }
  });
  return update;
}
