import Vuex = require("vuex")
import * as _ from "lodash"
import ingredientsApi from "../../api/ingredients"
import * as mutations from "../mutations"
import * as actions from "../actions"
import Ingredient from "../../models/Ingredient"
import IngredientClass from "../../models/IngredientClass"

type State = {
  /** All ingredient classes */
  classes: IngredientClass[],
  /** Currently selected class */
  currentClass: IngredientClass
  /** Parent of currently selected class */
  parentClass: IngredientClass
  /** Ingredients in current class */
  ingredients: Ingredient[]
  /** Currently selected ingredient */
  currentIngredient: Ingredient
}

type SetIngredientsMutation = {
  ingredients: Ingredient[]
}

type SetClassesMutation = {
  classes: IngredientClass[]
}

type SetCurrentClassMutation = {
  cls: IngredientClass
}

export default {
  state: <State> {
    classes: [],
    ingredients: [],
    currentClass: null,
    parentClass: null,
    currentIngredient: null
  },
  getters: {
    rootIngredientClasses: (state: State): IngredientClass[] =>
      _.sortBy(state.classes.filter(c => !c.parent), ["name"]),
    currentIngredientClasses: (state: State, getters: any) => {
      if (!state.currentClass) {
        return getters.rootIngredientClasses
      }
      return _.sortBy(state.classes.filter(c => c.parent === state.currentClass), ["name"])
    },
    selectedIngredientClass: (state: State) =>
      state.currentClass,
    selectedIngredient: (state: State) =>
      state.currentIngredient,
    parentIngredientClass: (state: State) =>
      state.currentClass ? state.currentClass.parent : null,
    currentClassIngredients: (state: State) =>
      state.ingredients
  },
  actions: {
    [actions.IB_POPULATE_BROWSER]: async function ({ commit, state }: Vuex.ActionContext<State, any>, payload: { clsid: number, id: number }) {
      const classes = await ingredientsApi.getClasses()
      commit(mutations.SET_INGREDIENT_CLASSES, { classes })
      if (payload.clsid) {
        commit(
          mutations.SET_CURRENT_CLASS,
          { cls: state.classes.find((c) => c.id === payload.clsid) }
        )
        const ingredients = await ingredientsApi.getIngredientsForClass(payload.clsid)
        commit(mutations.SET_INGREDIENTS, { ingredients })
        if (payload.id) {
          commit(
            mutations.SET_CURRENT_INGREDIENT,
            { ingredient: state.ingredients.find((i) => i.id === payload.id) }
          )
        }
      } else {
        commit(mutations.UNSET_CURRENT_CLASS)
      }
    },
    [actions.IB_UPDATE_SELECTIONS]: async function ({ commit, state }: Vuex.ActionContext<State, any>, payload: { clsid: number, id: number }) {
      if (payload.clsid) {
        if (!state.currentClass || payload.clsid !== state.currentClass.id) {
          const ingredients = await ingredientsApi.getIngredientsForClass(payload.clsid)
          commit(mutations.SET_INGREDIENTS, { ingredients })
        }
        commit(
          mutations.SET_CURRENT_CLASS,
          { cls: state.classes.find((c) => c.id === payload.clsid) }
        )
        if (payload.id) {
          commit(
            mutations.SET_CURRENT_INGREDIENT,
            { ingredient: state.ingredients.find((i) => i.id === payload.id) }
          )
        }
      } else {
        commit(mutations.UNSET_CURRENT_CLASS)
        commit(mutations.SET_INGREDIENTS, { ingredients: [] })
      }
    }
  },
  mutations: {
    [mutations.SET_INGREDIENT_CLASSES] (state: State, { classes }: SetClassesMutation) {
      state.classes = classes
    },
    [mutations.SET_INGREDIENTS] (state: State, { ingredients }: SetIngredientsMutation) {
      state.ingredients = ingredients
    },
    [mutations.SET_CURRENT_CLASS] (state: State, { cls }: SetCurrentClassMutation) {
      state.currentClass = cls
    },
    [mutations.UNSET_CURRENT_CLASS] (state: State) {
      state.currentClass = null
    },
    [mutations.SET_CURRENT_INGREDIENT] (state: State, { ingredient }: { ingredient: Ingredient }) {
      state.currentIngredient = ingredient
    }
  }
}

