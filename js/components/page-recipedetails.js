const RecipeDetails = {
    data() {
        return {
            recipe: '',
            ingredients: [],
            instructions: [],
            msgGet: '',
            msgVote: '',
            userId: null,
            userVotes: []
        };
    },

    // fetch recipe data
    async mounted() {
        await this.fetchRecipeData(); // initial fetch when the component is mounted
    },

    // watch for changes in recipeId
    watch: {
        '$route.params.recipeId': 'fetchRecipeData' 
    },

    methods: {
        // check if user has voted for this recipe
        async checkVoteExists() {
            try {
                const response = await fetch(`resources/api_votes.php?userId=${this.userId}`);
                const data = await response.json();
                if (response.ok) {
                    const votesResponse = await fetch(`resources/api_votes.php?userId=${this.userId}`);
                    const votesData = await votesResponse.json();
                    this.userVotes = votesData.map(vote => vote.recipeId);
                } else {
                    this.msg = data.error || "Failed to check vote existence.";
                    return false;
                }
            }
            catch (error) {
                this.msg = "Error: " + error.message;
            }
        },

        // fetch recipe data
        async fetchRecipeData() {
            window.scrollTo(0, 0);

            const recipeId = this.$route.params.recipeId;
            this.userId = JSON.parse(localStorage.getItem('user'))?.userId || null;

            try {
                const recipeResponse = await fetch(`resources/api_recipe.php/recipe/${recipeId}`);
                const recipeData = await recipeResponse.json();
                this.recipe = recipeData[0];

                const ingredientsResponse = await fetch(`resources/api_recipe.php/ingredients/${recipeId}`);
                this.ingredients = await ingredientsResponse.json();

                const instructionsResponse = await fetch(`resources/api_recipe.php/instructions/${recipeId}`);
                this.instructions = await instructionsResponse.json();
            
                await this.checkVoteExists(); // check if user has voted for this recipe
            }
            catch (error) {
                this.msgGet = "Error: " + error.message;
            }
        },

        // vote and unvote for recipe
        async voteRecipe() {
            if (!this.userId) {
                this.$router.push('/login');
                return;
            }

            if (this.userVotes.includes(this.recipe.recipeId)) {
                // unvote
                try {
                    const response = await fetch('resources/api_votes.php', {
                        method: 'DELETE',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({ userId: this.userId, recipeId: this.recipe.recipeId })
                    });
                    const data = await response.json();

                    if (data.success) {
                        alert("You removed your vote from this recipe.");
                        this.recipe.recipeVote = Number(this.recipe.recipeVote) - 1;
                        this.userVotes = this.userVotes.filter(id => id !== this.recipe.recipeId);
                    } else {
                        this.msgVote = data.message;
                    }
                } catch (error) {
                    this.msgVote = "Error: " + error.message;
                }
            } else {
                // vote
                try {
                    const response = await fetch('resources/api_votes.php', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({ userId: this.userId, recipeId: this.recipe.recipeId })
                    });
                    const data = await response.json();

                    if (data.success) {
                        alert("You voted for this recipe!");
                        this.recipe.recipeVote = Number(this.recipe.recipeVote) + 1;
                        this.userVotes.push(this.recipe.recipeId);
                    } else {
                        this.msgVote = data.message;
                    }
                } catch (error) {
                    this.msgVote = "Error: " + error.message;
                }
            }
        }
    },

    template: `
        <div>
            <app-nav></app-nav>
            <div class="container px-3" v-boldheading style="margin-top: 120px !important" v-if="recipe">
                <div class="row mt-10">
                    <h1 class="text-start mb-3">{{ recipe.recipeName }}</h1>
                </div>
                <div class="row mb-3 align-items-center">
                    <h6 class="col-6 mb-0">Vote count: {{ recipe.recipeVote }}</h6>
                    <div class="col-6 d-flex justify-content-end">
                        <button type="button" class="btn btn-warning mr-3" @click="voteRecipe">
                            <v-icon>mdi-thumb-up-outline</v-icon> 
                            {{ userVotes.includes(recipe.recipeId) ? 'Unvote' : 'Vote' }}
                        </button>
                    </div>
                </div>
                <div v-if="msgVote">{{ msgVote }}</div>
                <hr>
                <div v-if="msgGet">{{ msgGet }}</div>
                <div class="row mb-10">
                    <img :src="'img/recipe/' + recipe.recipeImg" :alt="recipe.recipeName" class="img-fluid">
                </div>
                <div class="row row-cols-auto mb-10">
                    <div class="col">
                        <h5 class="fw-bold">Prep time: </h5>
                        <p>{{ recipe.recipePrepTime }} min</p>
                    </div>
                    <div class="col border-start">
                        <h5 class="fw-bold">Servings: </h5>
                        <p>{{ recipe.recipeServings }}</p>
                    </div>
                </div>
                <div class="row mb-10">
                    <div class="col-12 col-md-4 mb-10">
                        <h2>Ingredients</h2>
                        <hr>
                        <ul>
                            <li v-for="ingredient in ingredients" :key="ingredient.ingredient">{{ ingredient.ingredient }}</li>
                        </ul>
                    </div>
                    <div class="col-12 col-md-8">
                        <h2>Instructions</h2>
                        <hr>
                        <ul>
                            <li v-for="instruction in instructions" :key="instruction.instruction">{{ instruction.instruction }}</li>
                        </ul>
                    </div>
                </div>
                <div class="row mb-10">
                    <h2>You may also like</h2>
                    <hr>
                    <div>
                        <app-randomrecipes></app-randomrecipes>
                    </div>
                </div>
            </div>
            <app-footer></app-footer>
        </div>
    `
};