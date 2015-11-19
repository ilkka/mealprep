import Rx from 'rx';
import {h} from '@cycle/dom';

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
    .map(({ingredient, amount}) => h('div.ingredient', [
      h('h2', `${ingredient.name}, ${amount} g`),
      h('h3', 'Ravintotekijät:'),
      h('dl', ingredient.components.reduce((l, c) => l.concat(
        h('dt', `${c.name}`),
        h('dd', `${c.value * (amount / 100.0)} ${c.unit}`),
      ), [])),
    ]));
  }

  let actions = intent(responses.DOM);

  return {
    DOM: view(model(responses, actions)),
    events: {},
  };
}
