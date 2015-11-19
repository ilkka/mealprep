import Rx from 'rx';
import Cycle from '@cycle/core';
import {makeDOMDriver, h} from '@cycle/dom';
import {makeHTTPDriver} from '@cycle/http';

const {div} = require('hyperscript-helpers')(h);

import labeledSlider from './components/labeled-slider';
import ingredientDetails from './components/ingredient-details';
import ingredientSelector from './components/ingredient-selector';

const INGREDIENT_URL = 'http://localhost:4000/api/v1/ingredients/';

function view(state$) {
  return state$.map(({ingredients}) => {
    return div([
      h('ingredient-selector#selector'),
    ].concat(
      ingredients.map((i) => h('ingredient-details', {ingredient: i}))
    ));
  });
}

function model(actions) {
  let ingredients$ = actions.setIngredients.startWith([]);
  return Rx.Observable.combineLatest(
    ingredients$,
    (ingredients) => ({ingredients}));
}

function intent({HTTP}) {
  return {
    setIngredients: HTTP.filter((res$) => res$.request.startsWith(INGREDIENT_URL))
      .mergeAll()
      .map((req) => JSON.parse(req.text))
      .map((ing) => [ing.data])
      .scan((acc, cur) => acc.concat(cur)),
  };
}

function main({DOM, HTTP}) {
  return {
    DOM: view(model(intent({DOM, HTTP}))),
    HTTP: Rx.Observable.from([123, 321, 456].map((id) => INGREDIENT_URL + id)),
  };
}

Cycle.run(main, {
  DOM: makeDOMDriver('#app', {
    'labeled-slider': labeledSlider,
    'ingredient-details': ingredientDetails,
    'ingredient-selector': ingredientSelector,
  }),
  HTTP: makeHTTPDriver(),
});
