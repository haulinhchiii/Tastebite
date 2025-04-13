const Recipe = {
  props: ["recipe"],
  template: `
    <div class="card">
      <router-link :to="'/recipes/' + recipe.recipeId + '/' + encodeURIComponent(recipe.recipeName)">
        <img :src="'img/recipe/' + recipe.recipeImg" class="card-img-top" :alt="recipe.recipeImg">
      </router-link>
      <div class="card-body d-flex flex-column">
        <router-link :to="'/recipes/' + recipe.recipeId + '/' + encodeURIComponent(recipe.recipeName)">
          <h5 class="card-title text-start mb-3" style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
            {{ recipe.recipeName }}
          </h5>
        </router-link>
        <p class="card-text text-start">Vote count: {{ recipe.recipeVote }}</p>
        <p class="card-text text-start">Prep time: {{ recipe.recipePrepTime }}</p>
        <p class="card-text text-start">Servings: {{ recipe.recipeServings }}</p>
        <router-link :to="'/recipes/' + recipe.recipeId + '/' + encodeURIComponent(recipe.recipeName)" class="btn btn-warning mt-2">
          View recipe
        </router-link>
      </div>
    </div>
  `,
};