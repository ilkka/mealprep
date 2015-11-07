import Rx from 'rx';
import Cycle from '@cycle/core';
import {makeDOMDriver, h} from '@cycle/dom';
import {ifOk, ifError, returnAsObservable} from './helpers/map-errors';

function main({DOM}) {
    return {
        DOM: Rx.Observable.just(true)
            .map(() => h('p', 'MOROOOOO'))
    };
}

Cycle.run(main, {
    DOM: makeDOMDriver('#app', {
        'labeled-slider': require('./components/labeled-slider'),
    }),
});
