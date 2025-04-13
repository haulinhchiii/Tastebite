const Login = {
  data() {
    return {
      msgLogin: '',
      logininput: { username: '', password: '' },
      errors: { username: '', password: '' }
    };
  },

  methods: {
    // handle login form submit
    async login() {
      this.errors.username = '';
      this.errors.password = '';

      if (!this.validateUsername()) this.errors.username = 'Username is required and must be between 3 and 10 characters long.';
      if (!this.validatePassword()) this.errors.password = 'Password is required and must be at least 3 characters long.';

      if (!this.errors.username && !this.errors.password) {
        try {
          const response = await fetch("resources/api_users.php/", {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({
              username: this.logininput.username,
              password: this.logininput.password
            })
          });
          const data = await response.json();

          if (!response.ok || !data) {
            this.msgLogin = "Username or password incorrect. Create an account if you don't have one.";
          } else {
            localStorage.setItem('user', JSON.stringify(data)); // store user data in local storage under key 'user' for later use or page refresh
            this.$router.replace('/');
          }
        }
        catch (error) {
          this.msgLogin = "Error: " + error.message;
        }
      }
    },

    reset() {
      this.logininput = { username: '', password: '' };
      this.errors = { username: '', password: '' };
      this.msgLogin = '';
    },

    validateUsername() {
      return !!this.logininput.username && this.logininput.username.length >= 3 && this.logininput.username.length <= 10;
    },

    validatePassword() {
      return !!this.logininput.password && this.logininput.password.length >= 3;
    }
  },

  template: `
    <div>
      <app-nav></app-nav>
      <div class="container mb-15" v-boldheading style="margin-top: 150px !important">
        <form novalidate method="post" @submit.prevent="login()">
          <div class="card p-3 m-3">
            <h1 class="card-header">Login</h1>
            <div class="card-body row">

              <div class="mt-3">
                <div class="form-group">
                  <label class="form-label fw-bold" for="username">Username:</label>
                  <input required v-model="logininput.username" class="form-control" type="text" id="username" name="username">
                  <p v-if="errors.username" class="text-danger">{{ errors.username }}</p>
                </div>
              </div>

              <div class="mt-3">
                <div class="form-group">
                  <label class="form-label fw-bold" for="password">Password:</label>
                  <input required v-model="logininput.password" class="form-control" type="password" id="password" name="password">
                  <p v-if="errors.password" class="text-danger">{{ errors.password }}</p>
                </div>
              </div>

            </div>

            <div class="d-flex justify-content-center mb-3">
              <button type="submit" class="btn btn-warning m-1">Login</button>
              <button @click="reset()" type="reset" class="btn btn-light m-1">Reset</button>
            </div>

            <div class="text-center mt-3">
              <p v-if="msgLogin" class="text-danger">{{ msgLogin }}</p>
            </div>

            <div class="d-flex justify-content-center">
              <p>Don't have an account yet?&nbsp;</p>
              <router-link class="nav-link text-decoration-underline text-primary" to="/signup">Create an account</router-link>
            </div>

          </div>
        </form>
      </div>
      <app-footer></app-footer>
    </div>
  `
};