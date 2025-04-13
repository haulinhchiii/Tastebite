const NavBar = {
  data() {
    return {
      user: '',
      loginForm: { username: '', password: '' },
      loginError: ''
    };
  },

  computed: {
    isLoggedIn() {
      return this.user !== '';
    }
  },

  methods: {
    handleProfileClick() {
      if (this.isLoggedIn) {
        this.$router.push('/profile');
      } else {
        this.$router.push('/login');
      }
    },
  },

  mounted() {
    const storedUser = localStorage.getItem('user'); // Fetch user data from local storage
    if (storedUser) {
      this.user = JSON.parse(storedUser);
    }
  },
  template: `
    <nav class="navbar navbar-expand-lg fixed-top bg-body-tertiary">
      <div class="container-fluid">

        <a class="navbar-brand" href="#">
          <img height="60px" src="img/logo.png" alt="Tastebite Logo">
        </a>

        <button class="navbar-toggler ml-3" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse justify-content-end mr-4" id="navbarNav">
          <ul class="navbar-nav align-items-center">
            <li class="nav-item">
              <router-link to="/" class="nav-link" aria-current="page">Home</router-link>
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

            <li class="nav-item">
              <div @click="handleProfileClick()" class="nav-link d-flex align-items-center" style="cursor: pointer;">
                <img class="rounded-circle" height="30rem" width="30rem" :src="user?.userImg ? 'img/profile/' + user.userImg : 'img/profile/user.png'" alt="User Image">
                <span v-if="isLoggedIn" class="ml-2">{{ user.username }}</span>
              </div>
            </li>
          </ul>
        </div>
      </div>
    </nav>  
  `
};