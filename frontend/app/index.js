import Rx from 'rx';
import Cycle from '@cycle/core';
import {makeDOMDriver, h} from '@cycle/dom';
import {makeHTTPDriver} from '@cycle/http';

import {ifOk, ifError, returnAsObservable} from './helpers/map-errors';

const INGREDIENT_URL = 'http://localhost:4000/api/v1/ingredients/123';

function main({DOM, HTTP}) {
  let request$ = Rx.Observable.just(INGREDIENT_URL);
  let vtree$ = HTTP.filter((res$) => res$.request === INGREDIENT_URL)
      .mergeAll()
      .map((req) => JSON.parse(req.text))
      .map((ing) => ing.data.name)
      .startWith('Loading...')
      .map((ing) => h('div', [
          h('p', ing),
          h('input', {type: 'range', min: 0, max: 100, step: 1})
      ]));
  return {
    DOM: vtree$,
    HTTP: request$,
  };
}

Cycle.run(main, {
  DOM: makeDOMDriver('#app', {
    'labeled-slider': require('./components/labeled-slider'),
  }),
  HTTP: makeHTTPDriver(),
});
