import Vue = require("vue")
import Component from "vue-class-component"

import Ingredient from "../models/Ingredient"
import * as styles from "./Ingredient.css"

@Component({
  name: "Ingredient",
  props: {
    ingredient: Ingredient
  },
  template: `
  <div class="${styles.container}" @click="select">
    <span class="${styles.name}">{{ ingredient.name }}</span>
  </div>
  `
})
export default class IngredientComponent extends Vue {
  ingredient: Ingredient

  select() {
    this.$emit("select", { id: this.ingredient.id })
  }
}
