const About = {
    data() {
        return {
            teams: [],
            msg: ''
        }
    },

    // fetch team members
    async mounted() {
        try {
            const response = await fetch('resources/api_tastebiteteam.php/');
            const data = await response.json();
            this.teams = data;
        }
        catch (error) {
            this.msg = "Error: " + error.message;
        }
    },

    template: `
        <app-nav></app-nav>
        <div class="container mt-10 mb-5" v-boldheading style="margin-top: 120px !important">
            <div class="row mb-4">
                <div class="col">
                    <h1 class="text-start">About</h1>
                    <hr>
                </div>
            </div>
            <div>
                <div class="mb-10">
                    <h2 class="mb-10">We're a group of foodies who love cooking and the Internet.</h2>
                    <img class="img-fluid mb-10" src="img/about/about2.png" alt="about2.png">
                    <p>
                        Our journey began with a shared passion for food and a love for the digital world. As a team of enthusiastic home cooks and professional chefs, we combined our skills to create a space where we could share our culinary adventures. We believe in the joy of cooking and the magic it brings to our lives. Our mission is to inspire others to explore their kitchens and discover the endless possibilities that food can offer. Whether it's experimenting with exotic ingredients or perfecting classic dishes, we're here to share our love for cooking with you.
                    </p>
                    <p>
                        Join us on this delicious journey as we explore the world of food together. Let's celebrate the art of cooking, the joy of sharing meals, and the endless creativity that comes with combining flavors and ingredients.
                    </p>
                </div>

                <div class="row mb-10">
                    <div class="col-12 col-md-6">
                        <h2 class="mb-10 fs-1">Simple, Easy Recipes for all.</h2>
                        <p>
                            We understand that not everyone has hours to spend in the kitchen, which is why we focus on creating recipes that are both simple and delicious. Whether you're a beginner looking to learn the basics or a seasoned cook seeking quick meal ideas, our collection has something for everyone. Our step-by-step guides, easy-to-find ingredients, and practical tips make cooking accessible and enjoyable. We aim to take the stress out of meal planning and bring the fun back into home cooking, making it easy for anyone to whip up a tasty dish any day of the week.
                        </p>
                    </div>
                    <div class="col-12 col-md-6">
                        <img class="img-fluid mb-10" src="img/about/about1.png" alt="about1.png">
                    </div>
                </div>

                <div class="row mb-10">
                    <h2 class="mb-10 fs-1">An incredible team of talented chefs and foodies</h2>
                    <div v-for="member in teams" :key="member.memberId" class="col-6 col-md-3 col-lg-2">
                        <div class="card h-100 mb-6" style="border: none; text-decoration: none">
                            <div style="position: relative; padding-top: 100%">
                                <img :src="'img/tastebiteteam/' + member.memberImg" class="card-img-top rounded-circle"
                                    :alt="member.memberName"
                                    style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover;">
                            </div>
                            <div class="card-body">
                                <p class="card-text fw-bold text-center m-0">{{ member.memberName }}</p>
                                <p class="card-text text-center">{{ member.memberJob }}</p>
                            </div>
                        </div>
                    </div>
                    <p v-if="msg" class="text-danger">{{ msg }}</p>
                </div>
            </div>
        </div>
        <app-footer></app-footer>
    `
}