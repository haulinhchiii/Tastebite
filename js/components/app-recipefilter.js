const RecipeFilter = {
  props: ['recipes'],

  // filter recipes based on the user input
  data() {
    return {
      filter: {
        recipeName: '',
        minServings: '',
        maxServings: '',
        minPrepTime: '',
        maxPrepTime: ''
      }
    };
  },

  // emit the filtered recipes to the parent component
  methods: {
    emitFilterChange() {
      const filteredRecipes = this.recipes.filter(recipe => {
        const nameFilter = recipe.recipeName.toLowerCase().includes(this.filter.recipeName.toLowerCase());

        const servingsFilter =
          (this.filter.minServings === '' || recipe.recipeServings >= parseFloat(this.filter.minServings)) &&
          (this.filter.maxServings === '' || recipe.recipeServings <= parseFloat(this.filter.maxServings));

        const prepTimeFilter =
          (this.filter.minPrepTime === '' || recipe.recipePrepTime >= parseFloat(this.filter.minPrepTime)) &&
          (this.filter.maxPrepTime === '' || recipe.recipePrepTime <= parseFloat(this.filter.maxPrepTime));

        return nameFilter && servingsFilter && prepTimeFilter;
      });
      this.$emit('filter-change', filteredRecipes);
    }
  },

  template: `
    <div>
      <div class="row">
        <!-- Recipe name -->
        <label class="form-label"><b>Search your favourite recipe:</b></label>
        <div class="col-12 mb-3">
          <input type="text" class="form-control" placeholder="Recipe name" v-model="filter.recipeName" @input="emitFilterChange">
        </div> 

        <div class="row pr-0">
          <!-- Prep time -->
          <div class="col-12 col-md-6 pr-0">
            <label class="form-label"><b>Prep time (min):</b></label>
            <div class="col-12 input-group mb-3">
              <span class="input-group-text">From</span>
              <input type="number" class="form-control" v-model.number="filter.minPrepTime" @input="emitFilterChange">
              <span class="input-group-text">To</span>
              <input type="number" class="form-control" v-model.number="filter.maxPrepTime" @input="emitFilterChange">
            </div>
          </div>

          <!-- Servings -->
          <div class="col-12 col-md-6 pr-0">
            <label class="form-label"><b>Servings:</b></label>
            <div class="col-12 input-group mb-3">
              <span class="input-group-text">From</span>
              <input type="number" class="form-control" v-model.number="filter.minServings" @input="emitFilterChange">
              <span class="input-group-text">To</span>
              <input type="number" class="form-control" v-model.number="filter.maxServings" @input="emitFilterChange">
            </div>
          </div>
        </div>
      </div>
    </div>
  `
};