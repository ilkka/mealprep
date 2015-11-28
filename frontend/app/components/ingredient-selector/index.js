import {h} from '@cycle/dom';
const {input, label, div} = require('hyperscript-helpers')(h);

function intent(DOM) {
  return {
    searchIngredientId$: DOM.select('#ingredientId')
      .events('keydown')
      .debounce(500)
      .map((ev) => ev.target.value),
  };
}

function model(actions) {
  return actions.searchIngredientId$
    .startWith('')
    .map((ingredientId) => ({ingredientId}));
}

function view(state$) {
  return state$.map(({id}) => div('.ingredient-selector', [
    label('Ingredient ID'),
    input('#ingredientId', {value: id}),
  ]));
}

export default function ingredientSelector(responses) {
  return {
    DOM: view(model(intent(responses.DOM))),
    events: {},
  };
}
