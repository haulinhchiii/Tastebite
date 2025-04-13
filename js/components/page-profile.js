const Profile = {
    data() {
        return {
            user: {
                userId: '',
                name: '',
                username: '',
                email: '',
                userImg: '',
                password: ''
            },

            errors: { name: '', username: '', email: '', password: '', srName: '', srCategory: '', srPreptime: '', srServings: '' },
            
            votedRecipes: [],
            
            srRecipes: [],
            srName: '',
            srCategory: '',
            srPreptime: '',
            srServings: '',
            
            msgGetVote: '',
            msgGetAdd: '',
            msgUpdate: '',
            msgAdd: '',
        };
    },

    mounted() {
        this.populateUserData(); // populate user data when the component is created
    },

    methods: {
        logout() {
            localStorage.removeItem('user'); // remove user data from localStorage
            this.$router.push('/login');
        },

        // populate user data from localStorage
        populateUserData() {
            const user = JSON.parse(localStorage.getItem('user'));
            if (user) {
                this.user = {
                    userId: user.userId || '',
                    name: user.name || '',
                    username: user.username || '',
                    email: user.email || '',
                    userImg: user.userImg || '',
                    password: user.password || ''
                };
                this.fetchVotedRecipes(); // fetch voted recipes when user data is populated
                this.fetchSuggestedRecipes(); // fetch suggested recipes when the component is created
            }
        },

        // check user existence (username, email) before updating profile of this user
        async checkUserExists() {
            try {
                const response = await fetch(`resources/api_users.php?username=${this.user.username}&email=${this.user.email}`);
                const data = await response.json();
                if (response.ok) {
                    return data.exists;
                } else {
                    this.msgUpdate = data.error || "Failed to check user existence.";
                    return false;
                }
            } catch (error) {
                this.msgUpdate = "Error: " + error.message;
                return false;
            }
        },

        // update profile of this user
        async updateProfile() {
            this.errors.name = '';
            this.errors.username = '';
            this.errors.email = '';
            this.errors.password = '';

            if (!this.validateName()) this.errors.name = "Name is required and must be at least 3 characters long.";
            if (!this.validateUsername()) this.errors.username = "Username is required and must be at least 3 characters long.";
            if (!this.validateEmail()) this.errors.email = "Email is required and must be a valid email.";
            if (!this.validatePassword()) this.errors.password = "Password is required and must be at least 10 characters long.";

            if (!this.errors.name && !this.errors.username && !this.errors.email && !this.errors.password) {
                const userExists = await this.checkUserExists();
                if (userExists) {
                    this.msgUpdate = "Username or email already exists.";
                    return;
                }

                try {
                    const updateUser = { ...this.user }; // create a copy of user object to send in the request

                    const response = await fetch("resources/api_users.php/", {
                        method: 'PUT',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify(updateUser)
                    });

                    const result = await response.json();

                    if (response.ok) {
                        alert("Profile updated successfully!");
                        localStorage.setItem('user', JSON.stringify(this.user));
                    } else {
                        this.msgUpdate = result.error || "Failed to update profile.";
                    }
                } catch (error) {
                    this.msgUpdate = "Error: " + error.message;
                }
            }
        },
        validateName() {
            return this.user.name.length >= 3;
        },
        validateUsername() {
            return this.user.username.length >= 3;
        },
        validateEmail() {
            return /^[A-Za-z0-9._!#$%&'*+-/=?^_`{|]+@[A-Za-z0-9.-]+\.[a-z]{2,}$/.test(this.user.email);
        },
        validatePassword() {
            return this.user.password.length >= 10;
        },

        // fetch voted recipes from this user
        async fetchVotedRecipes() {
            try {
                const response = await fetch(`resources/api_votes.php?userId=${this.user.userId}`);
                const data = await response.json();
                if (response.ok) {
                    this.votedRecipes = data;
                    console.log(this.votedRecipes);
                } else {
                    this.msgGetVote = data.error || "Failed to fetch voted recipes.";
                }
            }
            catch (error) {
                this.msgGetVote = "Error: " + error.message;
            }
        },

        // add suggested recipes
        async addSuggestedRecipes() {
            this.errors.srName = '';
            this.errors.srCategory = '';
            this.errors.srPreptime = '';
            this.errors.srServings = '';

            if (!this.validateSRName()) this.errors.srName = "Suggested recipe name is required.";
            if (!this.validateSRCategory()) this.errors.srCategory = "Category name is required.";
            if (!this.validateSRPreptime()) this.errors.srPreptime = "Prep time is required and must be a positive number.";
            if (!this.validateSRServings()) this.errors.srServings = "Servings is required and must be a positive number.";

            if (!this.errors.srName && !this.errors.srCategory && !this.errors.srPreptime && !this.errors.srServings) {
                try {
                    const suggestedRecipe = {
                        userId: this.user.userId,
                        srName: this.srName,
                        srCategory: this.srCategory,
                        srPreptime: parseInt(this.srPreptime),
                        srServings: parseInt(this.srServings)
                    };

                    const response = await fetch("resources/api_suggestedrecipes.php", {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify(suggestedRecipe)
                    });

                    if (!response.ok) {
                        const errorData = await response.json();
                        throw new Error(errorData.error || 'Failed to add suggested recipe');
                    }

                    const data = await response.json();

                    this.srName = '';
                    this.srCategory = '';
                    this.srPreptime = '';
                    this.srServings = '';
                    this.fetchSuggestedRecipes();
                    alert("Suggested recipe added successfully!");
                } catch (error) {
                    console.error('Error adding suggested recipe:', error);
                    this.msgAdd = "Error: " + error.message;
                }
            }
        },
        validateSRName() {
            return this.srName && this.srName.trim() !== '';
        },
        validateSRCategory() {
            return this.srCategory && this.srCategory.trim() !== '';
        },
        validateSRPreptime() {
            return this.srPreptime && !isNaN(this.srPreptime) && this.srPreptime > 0;
        },
        validateSRServings() {
            return this.srServings && !isNaN(this.srServings) && this.srServings > 0;
        },

        // fetch suggested recipes
        async fetchSuggestedRecipes() {
            try {
                const response = await fetch(`resources/api_suggestedrecipes.php?userId=${this.user.userId}`);
                const data = await response.json();
                if (response.ok) {
                    this.srRecipes = data;
                } else {
                    this.msgGetAdd = data.error || "Failed to fetch suggested recipes.";
                }
            } catch (error) {
                this.msgGetAdd = "Error: " + error.message;
            }
        },

        // delete suggested recipes
        async deleteSuggestedRecipes(srId) {
            try {
                const response = await fetch(`resources/api_suggestedrecipes.php/srId/${srId}`, {
                    method: 'DELETE',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                });

                if (response.ok) {
                    alert("You deleted your suggested recipe.");
                    this.fetchSuggestedRecipes();
                } else {
                    const errorData = await response.json();
                    this.msgGetAdd = errorData.error || "Failed to delete suggested recipe.";
                }
            } catch (error) {
                this.msgGetAdd = "Error: " + error.message;
            }
        }
    },

    template: `
    <div>
        <app-nav></app-nav>
        <div class="container mt-10 mb-10" v-boldheading style="margin-top: 120px !important">

            <!-- Profile header and logout button -->
            <div class="row mt-10 align-items-center justify-content-between">
                <div class="col">
                    <h1 class="text-start">Profile</h1>
                </div>
                <div class="col text-end">
                    <button @click="logout" class="btn btn-link ms-3 pr-1">
                        Log out <v-icon>mdi-chevron-right</v-icon>
                    </button>
                </div>
            </div>
            <div class="row mb-4">
                <div class="col">
                    <hr>
                </div>
            </div>

            <!-- Profile picture -->
            <div class="mb-10">
                <div class="text-center">
                    <img class="rounded-circle" :src="'img/profile/' + user.userImg" alt="user.img"
                        style="width: 200px; height: 200px; object-fit: cover;">
                    <h1 class="mt-3">{{ user.name }}</h1>
                </div>

                <div class="row mt-10">
                    <h2 class="text-start">Update profile information</h2>
                    <hr>
                </div>

                <form novalidate method="post" @submit.prevent="updateProfile()" class="mb-10">
                    <div class="row mb-1">
                        <div class="col-12 col-md-6 mb-2">
                            <label for="fullname" class="form-label fw-bold">Full name: </label>
                            <input type="text" class="form-control" id="fullname" v-model="user.name">
                            <p class="text-danger">{{ errors.name }}</p>
                        </div>
                        <div class="col-12 col-md-6 mb-2">
                            <label for="username" class="form-label fw-bold">Username:</label>
                            <input type="text" class="form-control" id="username" v-model="user.username">
                            <p class="text-danger">{{ errors.username }}</p>
                        </div>
                    </div>
                    <div class="row mb-1">
                        <div class="col-12 col-md-6 mb-2">
                            <label for="email" class="form-label fw-bold">Email:</label>
                            <input type="email" class="form-control" id="email" v-model="user.email">
                            <p class="text-danger">{{ errors.email }}</p>
                        </div>
                        <div class="col-12 col-md-6 mb-2">
                            <label for="password" class="form-label fw-bold">Password:</label>
                            <input type="password" class="form-control" id="password" v-model="user.password">
                            <p class="text-danger">{{ errors.password }}</p>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-warning">Update</button>
                </form>
                <!-- Voted recipes table -->
                <div class="row mt-10">
                    <h2 class="text-start">Voted recipes</h2>
                    <hr>
                </div>

                <div v-if="votedRecipes.length" style="overflow-x: auto">
                    <table class="table table-striped" aria-labelledby="tableTitle">
                        <caption class="sr-only" id="tableTitle">List of Voted Recipes</caption>
                        <thead>
                            <tr>
                                <th id="recipeName" scope="col">Recipe Name</th>
                                <th id="category" scope="col">Category</th>
                                <th id="preptime" scope="col">Prep Time</th>
                                <th id="servings" scope="col">Servings</th>
                                <th id="link" scope="col">Link</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="recipe in votedRecipes" :key="recipe.recipeId">
                                <td headers="recipeName">{{ recipe.recipeName }}</td>
                                <td headers="category">{{ recipe.categoryName }}</td>
                                <td headers="preptime">{{ recipe.recipePrepTime }} min</td>
                                <td headers="servings">{{ recipe.recipeServings }}</td>
                                <td headers="link">
                                    <router-link
                                        :to="'/recipes/' + recipe.recipeId + '/' + encodeURIComponent(recipe.recipeName)"
                                        style="text-decoration: underline; color: blue"
                                        aria-label="View details for {{ recipe.recipeName }}">View Recipe
                                    </router-link>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div v-else>
                    <p style="color: lightgray">No voted recipes found. Browse and vote for your favourite ones.</p>
                </div>
                <div v-if="msgGetVote" class="text-danger mb-5">{{ msgGetVote }}</div>
                
                <!-- Add suggested recipes form -->
                <div class="row mt-10">
                    <h2 class="text-start">Add suggested recipes</h2>
                    <p class="fst-italic">Do you have any recipe you would like to suggest us? Add it here!</p>
                    <hr>
                </div>
                <form novalidate @submit.prevent="addSuggestedRecipes()" method="post" class="mb-10">
                    <div class="row mb-1">
                        <div class="col-12 col-md-6 mb-2">
                            <label for="srName" class="form-label fw-bold">Suggested recipe name:</label>
                            <input type="text" class="form-control" id="srName" v-model="srName">
                            <p class="text-danger">{{ errors.srName }}</p>
                        </div>
                        <div class="col-12 col-md-6 mb-2">
                            <label for="srCategory" class="form-label fw-bold">Category name:</label>
                            <input type="text" class="form-control" id="srCategory" v-model="srCategory">
                            <p class="text-danger">{{ errors.srCategory }}</p>
                        </div>
                    </div>
                    <div class="row mb-1">
                        <div class="col-12 col-md-6 mb-2">
                            <label for="srPreptime" class="form-label fw-bold">Prep time:</label>
                            <input type="number" class="form-control" id="srPreptime" v-model="srPreptime">
                            <p class="text-danger">{{ errors.srPreptime }}</p>
                        </div>
                        <div class="col-12 col-md-6 mb-2">
                            <label for="srServings" class="form-label fw-bold">Servings:</label>
                            <input type="number" class="form-control" id="srServings" v-model="srServings">
                            <p class="text-danger">{{ errors.srServings }}</p>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-warning">Add Recipe</button>
                </form>
                
                <!-- Display suggested recipes -->
                <div class="row mt-10">
                    <h2 class="text-start">Suggested recipes</h2>
                    <hr>
                </div>
                <div v-if="srRecipes.length" style="overflow-x: auto">
                    <table class="table table-striped" aria-labelledby="tableTitle">
                        <caption class="sr-only" id="tableTitle">List of Voted Recipes</caption>
                        <thead>
                            <tr>
                                <th id="srName" scope="col">Recipe Name</th>
                                <th id="srCategory" scope="col">Category</th>
                                <th id="srPreptime" scope="col">Prep Time</th>
                                <th id="srPervings" scope="col">Servings</th>
                                <th id="srDelete" scope="col">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="recipe in srRecipes" :key="recipe.srId">
                                <td headers="srName">{{ recipe.srName }}</td>
                                <td headers="srCategory">{{ recipe.srCategory }}</td>
                                <td headers="srPreptime">{{ recipe.srPreptime }} min</td>
                                <td headers="srServings">{{ recipe.srServings }}</td>
                                <td headers="srDelete">
                                    <a @click="deleteSuggestedRecipes(recipe.srId)" style="text-decoration: underline; color: red">Delete</a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div v-else>
                    <p style="color: lightgray">No suggested recipes found. Add your suggested ones.</p>
                </div>
                <div v-if="msgGetAdd" class="text-danger mb-5">{{ msgGetAdd }}</div>
            </div>
        </div>
        <app-footer></app-footer>
    </div>
  `
};