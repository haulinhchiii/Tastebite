const Categories = {
  components: {
    "app-category": Category,
  },

  data() {
    return {
      categories: [],
      msgGet: "",
    };
  },

  // fetch categories
  async mounted() {
    try {
      const response = await fetch("resources/api_category.php/");
      const data = await response.json();
      this.categories = data;
    } catch (error) {
      this.msgGet = "Error: " + error.message;
    }
  },

  template: `
    <div>
      <app-nav></app-nav>
      <div class="container mb-5" v-boldheading style="margin-top: 120px !important;">
        <div class="row mb-4">
          <div class="col">
            <h1 class="text-start">Categories</h1>
            <hr>
          </div>
        </div> 

        <div class="row row-cols-2 row-cols-md-5 g-4">
          <div v-for="cat in categories" :key="cat.categoryId" class="col">
            <app-category :category="cat"></app-category>
          </div>
        </div>
        <p v-if="msgGet" class="text-danger">{{ msgGet }}</p>
      </div>
      <app-footer></app-footer>
    </div>
  `,
};
