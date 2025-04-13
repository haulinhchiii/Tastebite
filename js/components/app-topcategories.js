const TopCategories = {
  components: {
    'app-category': Category
  },

  data() {
    return {
      topCategories: [],
      msg: ''
    };
  },

  // fetch top categories
  async mounted() {
    try {
      const response = await fetch('resources/api_topcategories.php');
      const data = await response.json();
      this.topCategories = data.sort((a, b) => b.recipeCount - a.recipeCount).slice(0, 6); // sort categories by recipe count in descending order and take the top 6
    } 
    catch (error) {
      this.msg = "Error: " + error.message;
    }
  },

  template: `
    <div class="row mt-10 align-items-center">
        <div class="col-md-8">
            <h1 class="text-start">Popular Categories</h1>
        </div>
        <div class="col-md-4 d-flex justify-content-center">
            <router-link to="/categories" class="btn btn-light pr-1 w-100 text-center">View all categories <v-icon>mdi-chevron-right</v-icon></router-link>
        </div>
    </div>
    <hr>
    <div class="container text-center mt-5" style="--bs-gutter-x: 0">
      <div class="row row-cols-2 row-cols-md-3 row-cols-lg-6 g-4">
        <div class="col" v-for="cat in topCategories" :key="cat.categoryId">
          <app-category :category="cat"></app-category>
        </div>
      </div>
      <p v-if="msg" class="text-danger">{{ msg }}</p>
    </div>
  `
};