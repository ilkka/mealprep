import Rx from 'rx';
import Cycle from '@cycle/core';
import {makeDOMDriver, h} from '@cycle/dom';
import {makeHTTPDriver} from '@cycle/http';

const {div} = require('hyperscript-helpers')(h);

import labeledSlider from './components/labeled-slider';
import ingredientDetails from './components/ingredient-details';

//import {ifOk, ifError, returnAsObservable} from './helpers/map-errors';

const INGREDIENT_URL = 'http://localhost:4000/api/v1/ingredients/123';

function view(state$) {
  return state$.map(({ingredient}) => div([
    h('ingredient-details', {ingredient}),
  ]));
}

function model(actions) {
  return Rx.Observable.combineLatest(
    actions.changeIngredient,
    (ingredient) => ({ingredient}));
}

function intent({DOM, HTTP}) {
  return {
    changeIngredient: HTTP.filter((res$) => res$.request === INGREDIENT_URL)
      .mergeAll()
      .map((req) => JSON.parse(req.text))
      .map((ing) => ing.data),
  };
}

function main({DOM, HTTP}) {
  return {
    DOM: view(model(intent({DOM, HTTP}))),
    HTTP: Rx.Observable.just(INGREDIENT_URL),
  };
}

Cycle.run(main, {
  DOM: makeDOMDriver('#app', {
    'labeled-slider': labeledSlider,
    'ingredient-details': ingredientDetails,
  }),
  HTTP: makeHTTPDriver(),
});
