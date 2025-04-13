const Newsletter = {
  data() {
    return {
      email: '',
      msg: '',
      error: ''
    };
  },

  // check if email exists
  methods: {
    async checkEmailExists() {
      try {
        const response = await fetch(`resources/api_newsletter.php?email=${this.email}`);
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
      }
    },

    // handle submit form
    async submit() {
      this.error = '';
      if (!this.validateEmail()) this.error = "Email is required and must be a valid email.";

      // check if email exists and subscribe
      if (!this.error) {
        const emailExists = await this.checkEmailExists();
        if (emailExists) {
          this.error = "Email already subscribed.";
          return;
        }        

        try {
          const response = await fetch("resources/api_newsletter.php", {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({ email: this.email })
          });
          const result = await response.json();

          if (response.ok) {
            alert("Subscribed successfully! Stay tuned for updates.");
            this.email = '';
          } else if (result.error === 'Email already subscribed.') {
            alert("You have already subscribed.");
            this.email = '';
          } else {
            this.msg = result.error || "Subscription failed.";
          }
        }
        catch (error) {
          this.msg = "Error: " + error.msg;
        }
      }
    },

    // validate email
    validateEmail() {
      return /^[A-Za-z0-9._!#$%&'*+-/=?^_`{|]+@[A-Za-z0-9.-]+\.[a-z]{2,}$/.test(this.email);
    },
  },

  template: `
    <div class="card text-center text-bg-warning mt-10 mb-10" style="border: none; padding: 2rem;">
      <h2 class="card-title">Subscribe to our newsletter</h2>
      <form novalidate method="post" @submit.prevent="submit()">
        <div class="form-group mb-3">
          <label class="form-label fw-bold" for="email"></label>
          <input v-model="email" required class="form-control" type="email" id="email" name="email" placeholder="Enter your email">
        </div>
        <p v-if="error" class="text-danger">{{ error }}</p>
        <p v-if="msg" class="text-danger">{{ msg }}</p>
        <button type="submit" class="btn btn-light" style="width: 100%;">Join</button>
      </form>
    </div>
  `
};