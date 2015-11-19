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
    return state$.map(({ingredient, amount}) => h('div.ingredient', [
      h('p', `${ingredient.name}, ${amount} g`),
    ]));
  }

  let actions = intent(responses.DOM);

  return {
    DOM: view(model(responses, actions)),
    events: {},
  };
}
