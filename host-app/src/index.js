import React from 'react';
import ReactDOM from 'react-dom';
import * as serviceWorker from './serviceWorker';
import { Provider } from 'react-redux'
import App from './App';
import './index.css';
import store from './redux/store'

// // Log the initial state
// console.log(store.getState())
  
// // Every time the state changes, log it
// // Note that subscribe() returns a function for unregistering the listener
// const unsubscribe = store.subscribe(() => console.log(store.getState()))

// // Dispatch some actions
// store.dispatch(addDesign({
//     id: 'xxx-xxxx-xxx',
//     productLine: 'countertops',
//     total: 10000
// }))

ReactDOM.render(
    <Provider store={store}>
        <App />
    </Provider>, 
    document.getElementById('root'));


// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
