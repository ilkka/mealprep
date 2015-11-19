import Rx from 'rx';
import Cycle from '@cycle/core';
import {makeDOMDriver, h} from '@cycle/dom';
//import {makeHTTPDriver} from '@cycle/http';
import labeledSlider from './components/labeled-slider/index.js';
//import {ifOk, ifError, returnAsObservable} from './helpers/map-errors';

const INGREDIENT_URL = 'http://localhost:4000/api/v1/ingredients/123';

function view(state) {
  return state.map(({amount}) => h('div', [
    h('labeled-slider#amount', {
      key: 1, label: 'Amount', unit: 'g', min: 0, initial: amount, max: 100,
    }),
  ]));
}

function model(actions) {
  return Rx.Observable.combineLatest(
    actions.changeAmount.startWith(50),
    (amount) => ({amount}));
}

function intent(DOM) {
  return {
    changeAmount: DOM.select('#amount').events('newValue').map((ev) => ev.detail),
  };
}

function main({DOM/*, HTTP*/}) {
  // let request$ = Rx.Observable.just(INGREDIENT_URL);
  //
  // let vtree$ = HTTP.filter((res$) => res$.request === INGREDIENT_URL)
  //       .mergeAll()
  //       .map((req) => JSON.parse(req.text))
  //       .map((ing) => ing.data.name)
  //       .startWith('Loading...')
  //       .map((ing) => h('div', [
  //         h('p', ing),
  //         h('labeled-slider#amount', {
  //           key: 1,
  //           label: 'Amount',
  //           unit: 'g',
  //           min: 0,
  //           initial: 10,
  //           max: 100,
  //         }),
  //       ]));
  //
  // return {
  //   DOM: vtree$,
  //   //HTTP: request$,
  // };
  return {
    DOM: view(model(intent(DOM))),
  };
}

Cycle.run(main, {
  DOM: makeDOMDriver('#app', {
    'labeled-slider': labeledSlider,
  }),
  //HTTP: makeHTTPDriver(),
});
