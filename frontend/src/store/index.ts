/**
 * The store for the app.
 */

import Vue = require("vue")
import Vuex = require("vuex")

import ingredientBrowser from "./modules/ingredientBrowser"

Vue.use(Vuex)

const debug = process.env.NODE_ENV !== "production"

export default new Vuex.Store({
  modules: {
    ingredientBrowser
  },
  strict: debug
})
