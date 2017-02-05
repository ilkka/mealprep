/**
 * Represents a class of ingredients. May have a parent class.
 */
export default class IngredientClass {
  /** Human-readable name of ingredient class */
  name: string
  /** Internal class ID */
  id: number
  /** Parent class ID */
  parent_id?: number
  /** Parent class */
  parent?: IngredientClass
}
