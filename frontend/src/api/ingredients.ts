// import * as fetch from "isomorphic-fetch"
/// <reference path="./lokka.d.ts" />

import IngredientClass from "../models/IngredientClass"
import Ingredient from "../models/Ingredient"
import Lokka from "lokka"
import Transport from "lokka-transport-http"

type ClassesQueryResult = {
  allIngredientclasses: {
    edges: Array<{ node: IngredientClass}>
  }
}

type ClassIngredientsQueryResult = {
  class: {
    id: number
    name: string
    ingredients: {
      edges: Array<{
        node: {
          id: number
          name: string
          process: {
            id: number
            name: string
          }
          ediblePortion: number
          components: {
            edges: Array<{
              node: {
                component: {
                  id: number
                  name: string
                  visible: boolean
                  unit: {
                    thscode: string
                  }
                }
                value: number
              }
            }>
          }
        }
      }>
    }
  }
}

async function getClasses (): Promise<IngredientClass[]> {
  const client = new Lokka({
    transport: new Transport("/graphql")
  })
  const response = await client.query<ClassesQueryResult>(`{
    allIngredientclasses {
      edges {
        node {
          id
          name
          parentId
        }
      }
    }
  }`)
  const classes = response.allIngredientclasses.edges.map(edge => edge.node)
  const rootClasses = classes.filter(c => !c.parent_id)
  classes.filter(c => !!c.parent_id).forEach((c) => {
    c.parent = rootClasses.find((r) => r.id === c.parent_id)
  })
  return classes
}

async function getIngredientsForClass (clsid: number): Promise<Ingredient[]> {
  const client = new Lokka({
    transport: new Transport("/graphql")
  })
  const response = await client.query<ClassIngredientsQueryResult>(
    `query ($id: Int!) {
      class: ingredientclassById(id: $id) {
        id
        name
        ingredients: ingredientsByIngredientclassId {
          edges {
            node {
              id
              name
              process: processByProcessId {
                id
                name
              }
              ediblePortion
              components: componentvaluesByIngredientId {
                edges {
                  node {
                    component: componentByComponentId {
                      id
                      name
                      visible
                      unit: unitByUnitId {
                        thscode
                      }
                    }
                    value
                  }
                }
              }
            }
          }
        }
      }
    }`,
    { id: clsid }
  )
  const ingredients = response.class.ingredients
  return ingredients.edges.map((iEdge) => ({
    ...iEdge.node,
    class: {
      id: response.class.id,
      name: response.class.name
    },
    process: iEdge.node.process.name,
    components: iEdge.node.components.edges.map((cEdge) => ({
      value: cEdge.node.value,
      component: {
        ...cEdge.node.component,
        unit: cEdge.node.component.unit.thscode
      }
    }))
  }))
}

export default {
  getClasses,
  getIngredientsForClass
}
