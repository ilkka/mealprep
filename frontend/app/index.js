import Rx from 'rx';
import Cycle from '@cycle/core';
import {makeDOMDriver, h} from '@cycle/dom';
import {makeHTTPDriver} from '@cycle/http';

const {div} = require('hyperscript-helpers')(h);

import labeledSlider from './components/labeled-slider';
import ingredientDetails from './components/ingredient-details';
import ingredientSelector from './components/ingredient-selector';

const INGREDIENT_URL = 'http://localhost:4000/api/v1/ingredients/123';

function view(state$) {
  return state$.map(({ingredient}) => div([
    h('ingredient-selector#selector'),
  ].concat(
    h('ingredient-details', {ingredient})
  )));
}

function model(actions) {
  return Rx.Observable.combineLatest(
    actions.changeIngredient,
    (ingredient) => ({ingredient}));
}

function intent({HTTP}) {
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
    'ingredient-selector': ingredientSelector,
  }),
  HTTP: makeHTTPDriver(),
});
