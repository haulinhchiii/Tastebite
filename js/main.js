const router = VueRouter.createRouter({
  history: VueRouter.createWebHashHistory(),
  routes: [
    { path: '/', component: Home },
    { path: '/login', component: Login },
    { path: '/signup', component: Signup },
    { path: '/home', component: Home },
    { path: '/categories', component: Categories },
    { path: '/recipes', component: Recipes },
    { path: '/profile', component: Profile },
    { path: '/about', component: About },

    {
      path: '/categories/:categoryId/:categoryName',
      component: CategoryRecipes,
      props: true
    },

    {
      path: '/recipes/:recipeId/:recipeName',
      component: RecipeDetails,
      props: true
    }
  ]
});

const app = Vue.createApp();

// custom directive: find all h1 and h2 elements and add these classes
app.directive('boldheading', {
  mounted(element) {
    const headings = element.querySelectorAll('h1, h2');
    headings.forEach(heading => {
      heading.classList.add('fw-bolder', 'titlefont');
    });
  }
});

app.component('app-nav', NavBar);
app.component('app-recipe', Recipe);
app.component('app-recipefilter', RecipeFilter);
app.component('app-carousel', Carousel);
app.component('app-randomrecipes', RandomRecipes);
app.component('app-category', Category);
app.component('app-topcategories', TopCategories);
app.component('app-newsletter', Newsletter);
app.component('app-footer', Footer);

app.component('page-login', Login);
app.component('page-signup', Signup);
app.component('page-home', Home);
app.component('page-about', About);
app.component('page-profile', Profile);
app.component('page-categories', Categories);
app.component('page-category-recipes', CategoryRecipes);
app.component('page-recipes', Recipes);
app.component('page-recipedetails', RecipeDetails);

const vuetify = Vuetify.createVuetify()
app.use(vuetify)
app.use(router)
app.mount('#app')