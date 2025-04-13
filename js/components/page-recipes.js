const Recipes = {
  components: {
    "app-recipe": Recipe,
    "app-recipefilter": RecipeFilter,
  },

  data() {
    return {
      recipes: [],
      filteredRecipes: [],
      msg: "",
    };
  },

  // fetch all recipes
  async mounted() {
    try {
      const response = await fetch("resources/api_recipe.php/");
      const data = await response.json();
      this.recipes = data;
      this.filteredRecipes = data;
    } catch (error) {
      this.msg = "Error: " + error.message;
    }
  },

  methods: {
    // update filteredRecipes when filter changes
    handleFilterChange(filteredRecipes) {
      this.filteredRecipes = filteredRecipes;
    },

    scrollToTop() {
      window.scrollTo({ top: 0, behavior: "smooth" });
    },
  },

  template: `
    <div>
      <app-nav></app-nav>
      <div class="container mt-10 mb-10" v-boldheading style="margin-top: 120px !important;">
        <div class="row mb-4">
          <div class="col">
            <h1 class="text-start">All recipes</h1>
            <hr>
          </div>
        </div>

        <app-recipefilter :recipes="recipes" @filter-change="handleFilterChange"></app-recipefilter>
        
        <div class="container text-center mt-5" style="--bs-gutter-x: 0;">
          <div class="row g-3">
            <div class="col-12 col-md-4" v-for="recipe in filteredRecipes" :key="recipe.recipeId">
              <app-recipe :recipe="recipe"></app-recipe>
            </div>
          </div>
        </div>
        <p v-if="msg" class="text-danger">{{ msg }}</p>
        
        <button class="rounded-circle btn btn-dark btn-floating btn-lg" @click="scrollToTop" 
          style="position: fixed; bottom: 20px; right: 20px; width: 50px; height: 50px; display: flex; align-items: center; justify-content: center;">
          <v-icon>mdi-chevron-up</v-icon>
        </button>
      </div>
      <app-footer></app-footer>
    </div>
  `,
};
