import Rx from 'rx';
import Cycle from '@cycle/core';
import {makeDOMDriver, h} from '@cycle/dom';
import {makeHTTPDriver} from '@cycle/http';
import labeledSlider from './components/labeled-slider/index.js';
//import {ifOk, ifError, returnAsObservable} from './helpers/map-errors';

const INGREDIENT_URL = 'http://localhost:4000/api/v1/ingredients/123';

function view(state) {
  return state.map(({amount, ingredient}) => h('div', [
    h('labeled-slider#amount', {
      key: 1, label: ingredient, unit: 'g', min: 0, initial: amount, max: 100,
    }),
  ]));
}

function model(actions) {
  return Rx.Observable.combineLatest(
    actions.changeAmount.startWith(50),
    actions.changeIngredient.startWith('Loading...'),
    (amount, ingredient) => ({amount, ingredient}));
}

function intent({DOM, HTTP}) {
  return {
    changeIngredient: HTTP.filter((res$) => res$.request === INGREDIENT_URL)
      .mergeAll()
      .map((req) => {
        console.log(req);
        return JSON.parse(req.text);
      })
      .map((ing) => ing.data.name),
    changeAmount: DOM.select('#amount').events('newValue').map((ev) => ev.detail),
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
  }),
  HTTP: makeHTTPDriver(),
});
