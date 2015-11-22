import Rx from 'rx';
import {h} from '@cycle/dom';
import numeral from 'numeral';
const {div, h2, h3, dl, dt, dd} = require('hyperscript-helpers')(h);

import styles from './style.css';

export default function ingredientDetails(responses) {
  function intent(DOM) {
    return {
      changeAmount: DOM.select('#amount').events('newValue').map((ev) => ev.detail),
    };
  }

  function model(context, actions) {
    let ingredient$ = context.props.get('ingredient');
    let amount$ = actions.changeAmount.startWith(50);
    return Rx.Observable.combineLatest(
      ingredient$,
      amount$,
      (ingredient, amount) => ({
        ingredient,
        amount,
        contributions: ingredient.components.map((c) => Object.assign({}, c, {
          value: c.value * (amount / 100.0) * (ingredient.edible_portion / 100.0),
        })),
      }));
  }

  function view(state$) {
    return state$
      .filter(({ingredient}) => ingredient.components)
      .map(({ingredient, amount, contributions}) => div(`.${styles.ingredientContainer}`, [
        h2(`.${styles.ingredientTitle}`, `${ingredient.name}`),
        h('labeled-slider#amount', {
          key: 1, label: 'Määrä', unit: 'g', min: 0, initial: amount, max: 100,
        }),
        h3('Ravintotekijät:'),
        dl(contributions.reduce((l, c) => l.concat(
          dt(`${c.name}`),
          dd(`${numeral(c.value * (amount / 100.0)).format('0.00')} ${c.unit}`)
        ), [])),
      ]));
  }

  let actions = intent(responses.DOM);
  let state$ = model(responses, actions);

  return {
    DOM: view(state$),
    events: {
      newValue: state$,
    },
  };
}
