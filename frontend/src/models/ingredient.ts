import IngredientClass from "./IngredientClass"

/**
 * Represents a single ingredient.
 */
export default class Ingredient {
  /** Human-readable name of ingredient class */
  name: string
  /** Internal class ID */
  id: number
  /** Nutritional components */
  components: any[]
  /** Manufactoring process */
  process: any
  /** Edible portion as a percentage */
  edible_portion: number
  /** Class of ingredients */
  class: IngredientClass
}
