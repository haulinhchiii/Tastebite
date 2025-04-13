const Category = {
  props: ["category"],
  template: `
      <div class="col">
        <router-link :to="'/categories/' + category.categoryId + '/' + encodeURIComponent(category.categoryName)" class="card h-100 catcard">
          <div style="position: relative; padding-top: 100%">
            <img :src="'img/category/' + category.categoryImg" class="card-img-top rounded-circle" :alt="category.categoryImg" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover;">
          </div>
          <div class="card-body">
            <p class="card-text fw-bold text-center">{{ category.categoryName }}</p>
          </div>
        </router-link>
      </div>
    `,
};
