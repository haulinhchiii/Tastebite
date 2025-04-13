const Footer = {
  template: `
    <footer class="container-fluid mt-5 p-3 text-bg-light" style="padding: 3rem 1rem !important; margin-left: 0 !important; margin-right: 0 !important">
      <div class="row">

        <div class="col-md-3">
          <p>
            <img height="60px" src="img/logo.png" alt="Tastebite Logo">
          </p>          
          <p class="small text-muted">
            At Tastebite, great food brings people together. Discover global recipes from our community of food lovers. From quick dinners to gourmet desserts, find endless inspiration. Let's cook up some joy together!
          </p>
        </div>

        <div class="col-md-3">
        </div>

        <div class="col-4 col-md-2">
          <h5 class="mb-3">Tastebite</h5>
          <ul class="list-unstyled">
            <li class="nav-item">
              <router-link to="/" class="nav-link">Home</router-link>
            </li>            
            <li class="nav-item">
              <router-link to="/about" class="nav-link">About</router-link>
            </li>            
            <li class="nav-item">
              <router-link to="/categories" class="nav-link">Categories</router-link>
            </li>            
            <li class="nav-item">
              <router-link to="/recipes" class="nav-link">Recipes</router-link>
            </li>            
          </ul>
        </div>

        <div class="col-4 col-md-2">
          <h5 class="mb-3">Legal</h5>
          <ul class="list-unstyled">
            <li><a href="#" class="text-muted">Terms</a></li>
            <li><a href="#" class="text-muted">Conditions</a></li>
            <li><a href="#" class="text-muted">Cookies</a></li>
            <li><a href="#" class="text-muted">Copyright</a></li>
          </ul>
        </div>

        <div class="col-4 col-md-2">
          <h5 class="mb-3">Follow</h5>
          <ul class="list-unstyled">
            <li><a href="#" class="text-muted">Facebook</a></li>
            <li><a href="#" class="text-muted">Twitter</a></li>
            <li><a href="#" class="text-muted">Instagram</a></li>
            <li><a href="#" class="text-muted">YouTube</a></li>
          </ul>
        </div>

      </div>
      <hr>
      <div class="row mt-3">
        <div class="col text-center">
          <p class="text-muted small">© 2024 Tastebite - All rights reserved</p>
        </div>
      </div>
    </footer>
  `
}