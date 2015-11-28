import Rx from 'rx';
import {h} from '@cycle/dom';
const {div, p} = require('hyperscript-helpers')(h);

function model(props) {
  return props.get('ingredients');
}

function view(state$) {
  return state$.map((ingredients) => div([
    ingredients.map((i) => {
      console.log(i);
      return p(i.name);
    }),
  ]));
}

export default function MealView(sources) {
  let state$ = model(sources.props);
  let vtree$ = view(state$);

  return {
    DOM: vtree$,
    events: {},
  };
}
