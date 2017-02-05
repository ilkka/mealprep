import Vue = require("vue")
import Component from "vue-class-component"

import IngredientClass from "../models/IngredientClass"
import * as styles from "./IngredientClass.css"

@Component({
  name: "IngredientClass",
  props: {
    ingredientClass: IngredientClass
  },
  template: `
    <div class="${styles.container}" @click="select">
      <span class="${styles.name}">{{ ingredientClass.name }}</span>
    </div>
  `
})
export default class IngredientClassComponent extends Vue {
  ingredientClass: IngredientClass

  select () {
    this.$emit("select", { clsid: this.ingredientClass.id })
  }
}
