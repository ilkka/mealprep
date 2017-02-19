import IngredientClass from "./IngredientClass"
import { ComponentValue } from "./Component"

/**
 * Represents a single ingredient.
 */
export default class Ingredient {
  /** Human-readable name of ingredient class */
  name: string
  /** Internal class ID */
  id: number
  /** Nutritional components */
  components: ComponentValue[]
  /** Manufactoring process */
  process: any
  /** Edible portion as a percentage */
  ediblePortion: number
  /** Class of ingredients */
  class: IngredientClass
}
