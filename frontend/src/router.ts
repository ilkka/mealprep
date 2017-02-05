import Vue = require("vue")
import VueRouter = require("vue-router")

// import App from './App'
import IngredientBrowserComponent from "./components/IngredientBrowserComponent"

Vue.use(VueRouter)

const routes = [
  // { path: '/', component: App },
  {
    path: "/ingredients",
    name: "ingredients",
    component: IngredientBrowserComponent
  },
  {
    path: "/ingredients/byclass/:clsid",
    name: "ingredientsByClass",
    component: IngredientBrowserComponent
  },
  {
    path: "/ingredients/byclass/:clsid/:id",
    name: "ingredientInClass",
    component: IngredientBrowserComponent
  }
]

export default new VueRouter({
  routes
})
