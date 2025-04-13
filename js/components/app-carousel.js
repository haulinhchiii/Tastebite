const Carousel = {
  data() {
    return {
      randomRecipes: [],
      msgGet: ''
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

  // fetch random recipes
  async mounted() {
    try {
      const response = await fetch('resources/api_recipe.php/');
      const data = await response.json();
      this.randomRecipes = this.shuffleArray(data).slice(0, 5); // shuffle the array and get the first 5 items
    } 
    catch (error) {
      this.msgGet = "Error: " + error.message;
    }
  },

  template: `
      <p v-if="msgGet" class="text-danger">{{ msgGet }}</p>
      <div id="carouselExampleCaptions" class="carousel slide">
        <div class="carousel-indicators">
          <button v-for="(recipe, index) in randomRecipes" 
                  :key="recipe.recipeId"
                  type="button" 
                  data-bs-target="#carouselExampleCaptions" 
                  :data-bs-slide-to="index" 
                  :class="{ active: index === 0 }" 
                  :aria-current="index === 0" 
                  :aria-label="'Slide ' + (index + 1)"></button>
        </div>
          <div class="carousel-inner">
            <div v-for="(recipe, index) in randomRecipes" 
                :key="recipe.recipeId" 
                class="carousel-item" 
                :class="{ active: index === 0 }">
              <router-link :to="'/recipes/' + recipe.recipeId + '/' + encodeURIComponent(recipe.recipeName)">
                <img :src="'img/recipe/' + recipe.recipeImg" class="d-block w-100" :alt="recipe.recipeName">
                <div v-boldheading class="carousel-caption mb-10 pb-6" style="background-color: rgba(0, 0, 0, 0.25)">
                  <h2>{{ recipe.recipeName }}</h2>
                  <div class="btn btn-warning mt-3 pr-1 d-none d-sm-inline-block">View recipe <v-icon>mdi-chevron-right</v-icon></div>
                </div>
              </router-link>
            </div>
          </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Next</span>
        </button>
      </div>
    `
};