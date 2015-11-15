import {Rx} from '@cycle/core';
import {h} from '@cycle/dom';

export default function labeledSlider(responses) {
    const initialValue$ = responses.props.get('initial').first();
    const newValue$ = responses.DOM.get('.slider', 'input')
          .map((ev) => parseInt(ev.target.value), 10);

    const value$ = initialValue$.concat(newValue$);
    const props$ = responses.props.get('*');

    const vtree$ = Rx.Observable
          .combineLatest(props$, value$, (props, value) =>
                         h('div.labeled-slider', [
                             h('div.label', [props.children.concat(value + props.unit)]),
                             h('input.slider', {type: 'range',
                                                min: props.min,
                                                max: props.max,
                                                value: value})
                         ])
                        );

    return {
        DOM: vtree$,
        events: {
            newValue: newValue$,
        },
    };
}
