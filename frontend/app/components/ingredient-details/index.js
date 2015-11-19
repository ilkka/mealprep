import Rx from 'rx';
import {h} from '@cycle/dom';
import numeral from 'numeral';

const {div, h2, h3, dl, dt, dd} = require('hyperscript-helpers')(h);

export default function ingredientDetails(responses) {
  function intent(/*DOM*/) {
    return {};
  }

  function model(context, actions) {
    let ingredient$ = context.props.get('ingredient').startWith('Loading...');
    let amount$ = context.props.get('amount').startWith(0);
    return Rx.Observable.combineLatest(
      ingredient$,
      amount$,
      (ingredient, amount) => ({ingredient, amount}));
  }

  function view(state$) {
    return state$
      .filter(({ingredient, amount}) => ingredient.components)
      .map(({ingredient, amount}) => div('.ingredient', [
        h2(`${ingredient.name}, ${amount} g`),
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
