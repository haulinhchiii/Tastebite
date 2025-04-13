const Signup = {
    data() {
        return {
            signupinput: { name: '', username: '', email: '', password: '', userImg: 'user.png' },
            errors: { name: '', username: '', email: '', password: '' },
            msg: '',
        }
    },

    methods: {
        // check if user exists
        async checkUserExists() {
            try {
                const response = await fetch(`resources/api_users.php?username=${this.signupinput.username}&email=${this.signupinput.email}`);
                const data = await response.json();
                if (response.ok) {
                    return data.exists;
                } else {
                    this.msg = data.error || "Failed to check user existence.";
                    return false;
                }
            }
            catch (error) {
                this.msg = "Error: " + error.message;
                return false;
            }
        },

        // handle signup form submit
        async signup() {
            this.errors.name = '';
            this.errors.username = '';
            this.errors.email = '';
            this.errors.password = '';

            if (!this.validateName()) this.errors.name = "Name is required and must be at least 3 characters long.";
            if (!this.validateUsername()) this.errors.username = "Username is required and must be at least 3 characters long.";
            if (!this.validateEmail()) this.errors.email = "Email is required and must be a valid email.";
            if (!this.validatePassword()) this.errors.password = "Password is required and must be at least 10 characters long.";

            // check if user exists and signup
            if (!this.errors.name && !this.errors.username && !this.errors.email && !this.errors.password) {
                const userExists = await this.checkUserExists();
                if (userExists) {
                    this.msg = "Username or email already exists.";
                    return;
                }

                try {
                    const response = await fetch("resources/api_signup.php", {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify(this.signupinput)
                    });
                    const data = await response.json();

                    if (response.ok) {
                        this.signupinput = { name: '', username: '', email: '', password: '', userImg: 'user.png' };
                        this.msg = "Signup successful! Redirecting to login...";
                        setTimeout(() => {
                            this.$router.push('/login');
                        }, 2000);
                    } else {
                        this.msg = data.error || "Failed to insert data.";
                    }
                }
                catch (error) {
                    this.msg = "Error: " + error.message;
                }
            }
        },
        validateName() {
            return this.signupinput.name.length >= 3;
        },
        validateUsername() {
            return this.signupinput.username.length >= 3;
        },
        validateEmail() {
            return /^[A-Za-z0-9._!#$%&'*+-/=?^_`{|]+@[A-Za-z0-9.-]+\.[a-z]{2,}$/.test(this.signupinput.email);
        },
        validatePassword() {
            return this.signupinput.password.length >= 10;
        },

        reset() {
            this.signupinput = { name: '', username: '', email: '', password: '', userImg: 'user.png' };
            this.errors = { name: '', username: '', email: '', password: '' };
            this.msg = '';
        }
    },

    template: `
        <app-nav></app-nav>
        <div class="container mb-10" v-boldheading style="margin-top: 120px !important">
            <form novalidate method="post" @submit.prevent="signup">

                <div class="card p-3 m-3">
                    <h1 class="card-header">Sign up</h1>

                    <div class="card-body row">

                        <div class="mt-3">
                            <div class="form-group">
                                <label class="form-label fw-bold" for="name">Name:</label>
                                <input required v-model="signupinput.name" class="form-control" type="text" id="name" name="name">
                                <p v-if="errors.name" class="text-danger">{{ errors.name }}</p>
                            </div>
                        </div>

                        <div class="mt-3">
                            <div class="form-group">
                                <label class="form-label fw-bold" for="username">Username:</label>
                                <input required v-model="signupinput.username" class="form-control" type="text" id="username" name="username">
                                <p v-if="errors.username" class="text-danger">{{ errors.username }}</p>
                            </div>
                        </div>

                        <div class="mt-3">
                            <div class="form-group">
                                <label class="form-label fw-bold" for="email">Email:</label>
                                <input required v-model="signupinput.email" class="form-control" type="email" id="email" name="email">
                                <p v-if="errors.email" class="text-danger">{{ errors.email }}</p>
                            </div>
                        </div>

                        <div class="mt-3">
                            <div class="form-group">
                                <label class="form-label fw-bold" for="password">Password:</label>
                                <input required v-model="signupinput.password" class="form-control" type="password" id="password" name="password">
                                <p v-if="errors.password" class="text-danger">{{ errors.password }}</p>
                            </div>
                        </div>

                    </div>

                    <div class="d-flex justify-content-center mb-3">
                        <button type="submit" class="btn btn-warning m-1">Create your account</button>
                        <button @click="reset()" type="reset" class="btn btn-light m-1">Reset</button>
                    </div>

                    <div class="d-flex justify-content-center mt-3">
                        <p v-if="msg" class="text-danger">{{ msg }}</p>
                    </div>

                    <div class="d-flex justify-content-center">
                        <p>Already have an account?&nbsp;</p>
                        <router-link class="nav-link text-decoration-underline text-primary" to="/login">Log in</router-link>
                    </div>

                </div>

            </form>
        </div>
        <app-footer></app-footer>
    `
};