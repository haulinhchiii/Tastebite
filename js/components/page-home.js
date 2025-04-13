const Home = {
  template: `
    <app-nav></app-nav>

    <div class="container" v-boldheading style="margin-top: 85px !important">
      <app-carousel></app-carousel>
      <app-topcategories></app-topcategories>

      <div class="row mt-10 align-items-center">
          <div class="col-md-8">
              <h1 class="text-start">Super Delicious</h1>
          </div>
          <div class="col-md-4 d-flex justify-content-center">
              <router-link to="/recipes" class="btn btn-light pr-1 w-100 text-center">View all recipes <v-icon>mdi-chevron-right</v-icon></router-link>
          </div>
      </div>
      <hr>
      <app-randomrecipes></app-randomrecipes>

      <app-newsletter></app-newsletter>
    </div>
    
    <app-footer></app-footer>
    `
};