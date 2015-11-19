import Rx from 'rx';
import {h} from '@cycle/dom';

export default function labeledSlider(responses) {
  function intent(DOM) {
    return {
      changeValue$: DOM.select('.slider').events('input')
        .map((ev) => ev.target.value),
    };
  }

  function model(context, actions) {
    let initialValue$ = context.props.get('initial').first();
    let value$ = initialValue$.concat(actions.changeValue$);
    let props$ = context.props.getAll();
    return Rx.Observable.combineLatest(props$, value$,
      (props, value) => { return {props, value}; }
    );
  }

  function view(state$) {
    return state$.map((state) => {
      let {label, unit, min, max} = state.props;
      let value = state.value;
      return h('div.labeled-slider', [
        h('span.label', [label + ' ' + value + unit]),
        h('input.slider', {type: 'range', min, max, value}),
      ]);
    });
  }

  let actions = intent(responses.DOM);
  let vtree$ = view(model(responses, actions));

  return {
    DOM: vtree$,
    events: {
      newValue: actions.changeValue$,
    },
  };
}
