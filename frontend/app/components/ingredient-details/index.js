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
      (ingredient, amount) => ({ingredient, amount}));
  }

  function view(state$) {
    return state$
      .filter(({ingredient}) => ingredient.components)
      .map(({ingredient, amount}) => div(`.${styles.ingredientContainer}`, [
        h2(`.${styles.ingredientTitle}`, `${ingredient.name}`),
        h('labeled-slider#amount', {
          key: 1, label: 'Määrä', unit: 'g', min: 0, initial: amount, max: 100,
        }),
        h3('Ravintotekijät:'),
        dl(ingredient.components.reduce((l, c) => l.concat(
          dt(`${c.name}`),
          dd(`${numeral(c.value * (amount / 100.0)).format('0.00')} ${c.unit}`)
        ), [])),
      ]));
  }

  let actions = intent(responses.DOM);

  return {
    DOM: view(model(responses, actions)),
    events: {},
  };
}
