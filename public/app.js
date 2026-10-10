// The site is static: search, filters, sorting and comparison run here.
// Without JavaScript the category pages and package pages still work.
document.querySelectorAll('[data-js]').forEach(element => { element.hidden = false; });

document.addEventListener('keydown', event => {
  if (event.key === '/' && !event.ctrlKey && !event.metaKey && !['INPUT', 'TEXTAREA', 'SELECT'].includes(document.activeElement.tagName)) {
    const search = document.querySelector('#search');
    if (search) { event.preventDefault(); search.focus(); }
  }
});

const filters = document.querySelector('#filters');
const grid = document.querySelector('#package-grid');
if (filters && grid) {
  const cards = [...grid.querySelectorAll('.package')];
  const title = document.querySelector('#results-title');
  const params = new URLSearchParams(location.search);
  for (const name of ['q', 'category', 'sort']) {
    if (params.has(name)) filters.elements[name].value = params.get(name);
  }
  // The cards come sorted by name; the other orders put the highest first,
  // and a standard module, which has no GitHub numbers, last.
  const number = value => (value === '' ? -1 : Number.parseInt(value, 10));
  const orders = {
    name: () => cards,
    reverse: () => [...cards].reverse(),
    stars: () => [...cards].sort((a, b) => number(b.dataset.stars) - number(a.dataset.stars)),
    used: () => [...cards].sort((a, b) => number(b.dataset.used) - number(a.dataset.used)),
    updated: () => [...cards].sort((a, b) => b.dataset.updated.localeCompare(a.dataset.updated)),
  };
  const apply = () => {
    const query = filters.elements.q.value.trim().toLowerCase();
    const category = filters.elements.category.value;
    let shown = 0;
    for (const card of cards) {
      const match = (!query || card.dataset.search.includes(query)) &&
        (!category || card.dataset.category === category);
      card.hidden = !match;
      if (match) shown += 1;
    }
    (orders[filters.elements.sort.value] || orders.name)().forEach(card => grid.append(card));
    document.querySelector('#results-count').textContent = `${shown} packages`;
    document.querySelector('#empty').hidden = shown > 0;
    const select = filters.elements.category;
    title.textContent = category ? select.options[select.selectedIndex].text : 'Discover packages';
  };
  filters.addEventListener('input', apply);
  filters.addEventListener('submit', event => {
    event.preventDefault();
    apply();
    const state = new URLSearchParams();
    for (const name of ['q', 'category', 'sort']) {
      const value = filters.elements[name].value.trim();
      if (value && !(name === 'sort' && value === 'name')) state.set(name, value);
    }
    history.replaceState(null, '', `${location.pathname}${state.size ? `?${state}` : ''}#catalog`);
  });
  apply();
}

const compare = document.querySelector('#compare-form');
if (compare) {
  const boxes = [...document.querySelectorAll('input[form="compare-form"]')];
  const note = compare.querySelector('span');
  const button = compare.querySelector('button');
  const refresh = () => {
    const count = boxes.filter(box => box.checked).length;
    note.textContent = count ? `${count} of 3 packages selected.` : 'Select up to 3 packages to compare.';
    button.disabled = count === 0;
    boxes.forEach(box => { box.disabled = count >= 3 && !box.checked; });
  };
  boxes.forEach(box => box.addEventListener('change', refresh));
  refresh();
}

const result = document.querySelector('#compare-result');
if (result) {
  const cells = [...result.querySelectorAll('[data-slug]')];
  const known = new Set(cells.map(cell => cell.dataset.slug));
  const chosen = new Set(new URLSearchParams(location.search).getAll('p').filter(slug => known.has(slug)));
  if (chosen.size >= 1 && chosen.size <= 3) {
    cells.forEach(cell => { cell.hidden = !chosen.has(cell.dataset.slug); });
    result.hidden = false;
    document.querySelector('#compare-empty').hidden = true;
  }
}
