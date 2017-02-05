import * as fetch from "isomorphic-fetch"
import IngredientClass from "../models/IngredientClass"

async function getClasses (): Promise<IngredientClass[]> {
  const response = await fetch("/api/v1/ingredientclasses")
  if (response.status >= 400) {
    throw new Error("Error fetching ingredient classes")
  }
  const classes: IngredientClass[] = await response.json()
  const rootClasses = classes.filter(c => !c.parent_id)
  classes.filter(c => !!c.parent_id).forEach((c) => {
    c.parent = rootClasses.find((r) => r.id === c.parent_id)
  })
  return classes
}

async function getIngredientsForClass (clsid: number) {
  const response = await fetch(`/api/v1/ingredients?ingredientClass=${clsid}`)
  if (response.status >= 400) {
    throw new Error("Error fetching ingredients")
  }
  const ingredients = await response.json()
  return ingredients
}

export default {
  getClasses,
  getIngredientsForClass
}
