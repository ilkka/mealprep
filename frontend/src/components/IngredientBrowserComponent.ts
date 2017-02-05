import Vue = require("vue")
import Component from "vue-class-component"

import { IB_POPULATE_BROWSER, IB_UPDATE_SELECTIONS } from "../store/actions"
import IngredientClassComponent from "./IngredientClassComponent"
import IngredientComponent from "./IngredientComponent"
import Ingredient from "../models/Ingredient"
import IngredientClass from "../models/IngredientClass"

import * as styles from "./IngredientBrowser.css"

@Component({
  name: "IngredientBrowser",
  template: `
    <div class="${styles.browser}">
      <div class="${styles.classes}">
        <IngredientClass v-if="selectedIngredientClass" :ingredient-class="selectedIngredientClass" @select="selectParentClass" />
        <IngredientClass v-for="ingredientClass in ingredientClasses" :ingredient-class="ingredientClass" @select="selectClass" />
      </div>
      <div class="${styles.ingredients}">
        <Ingredient v-for="ingredient in ingredients" :ingredient="ingredient" @select="selectIngredient" />
      </div>
      <div class="${styles.details}">
        <template v-if="selectedIngredient">
          <h2>{{ selectedIngredient.name }}</h2>
          <h3>{{ selectedIngredient.process.name }}</h3>
        </template>
      </div>
    </div>
  `,
  components: {
    IngredientClass: IngredientClassComponent,
    Ingredient: IngredientComponent
  },
  watch: {
    "$route": "updateSelections"
  }
})
export default class IngredientBrowserComponent extends Vue {
  get ingredientClasses (): IngredientClass[] {
    return this.$store.getters.currentIngredientClasses
  }

  get ingredients (): Ingredient[] {
    return this.$store.getters.currentClassIngredients
  }

  get selectedIngredientClass (): IngredientClass {
    return this.$store.getters.selectedIngredientClass
  }

  get selectedIngredient (): Ingredient {
    return this.$store.getters.selectedIngredient
  }

  created () {
    this.fetchData()
  }

  private getClassAndIngredientIds () {
    return {
      clsid: this.$route.params["clsid"] ?
      parseInt(this.$route.params["clsid"], 10) :
      null,
      id: this.$route.params["id"] ?
      parseInt(this.$route.params["id"], 10) :
      null
    }
  }

  fetchData () {
    this.$store.dispatch(IB_POPULATE_BROWSER, this.getClassAndIngredientIds())
  }

  updateSelections () {
    this.$store.dispatch(IB_UPDATE_SELECTIONS, this.getClassAndIngredientIds())
  }

  selectClass ({ clsid }: { clsid: number }) {
    console.log(`navigating to class ${clsid}`)
    this.$router.push({
      name: "ingredientsByClass",
      params: { clsid: `${clsid}` }
    })
  }

  selectParentClass () {
    console.log("navigating to parent")
    if (this.$store.getters.parentIngredientClass) {
      this.$router.push({
        name: "ingredientsByClass",
        params: { clsid: `${this.$store.getters.parentIngredientClass.id}`}
      })
    } else {
      this.$router.push({
        name: "ingredients"
      })
    }
  }

  selectIngredient ({ id }: { id: number }) {
    this.$router.push({
      name: "ingredientInClass",
      params: {
        clsid: `${this.selectedIngredientClass.id}`,
        id: `${id}`
      }
    })
  }
}
