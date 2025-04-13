const RandomRecipes = {
    components: {
        'app-recipe': Recipe
    },

    data() {
        return {
            randomRecipes: [],
            msg: ''
        }
    },

    // fetch random recipes
    async mounted() {
        try {
            const response = await fetch('resources/api_recipe.php/');
            const data = await response.json();
            this.randomRecipes = this.shuffleArray(data).slice(0, 8); // shuffle the array and get the first 8 items
        }
        catch (error) {
            this.msg = "Error: " + error.message;
        }
    },

    // randomise array
    methods: {
        shuffleArray(array) {
            for (let i = array.length - 1; i > 0; i--) {
                const j = Math.floor(Math.random() * i);
                [array[i], array[j]] = [array[j], array[i]];
            }
            return array;
        }
    },

    template: `
      <div class="container text-center mt-5" style="--bs-gutter-x: 0">
        <div class="row g-3">
          <div class="col-12 col-md-6 col-lg-3" v-for="recipe in randomRecipes" :key="randomRecipes.recipeId">
            <app-recipe :recipe="recipe"></app-recipe>
          </div>
        </div>
        <p v-if="msg" class="text-danger">{{ msg }}</p>
      </div>
    `
}