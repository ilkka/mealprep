<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
    <h2>Essential Things</h2>
    <ol>
      <IngredientClass v-for="ingredientClass in ingredientClasses" v-bind:ingredient-class="ingredientClass"/>
    </ol>
    <button v-on:click="addThing">Add thing</button>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import IngredientClass from './IngredientClass'
import * as actions from '../store/actions'

export default {
  name: 'hello',
  computed: mapGetters({
    ingredientClasses: 'allIngredientClasses'
  }),
  components: {
    IngredientClass
  },
  created () {
    this.$store.dispatch(actions.GET_INGREDIENT_CLASSES)
  },
  data () {
    return {
      msg: 'Welcome to Your Vue.js App'
    }
  },
  methods: {
    addThing () {
      console.log('addThing')
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h1, h2 {
  font-weight: normal;
}

ol {
  padding: 0;
}

li {
  display: list-item;
  margin: 0 10px;
}

a {
  color: #42b983;
}
</style>
