--
-- Database: `cos30043`
--

CREATE DATABASE IF NOT EXISTS cos30043;

-- --------------------------------------------------------

USE `cos30043`;

-- --------------------------------------------------------

--
-- Table `users`
--

CREATE TABLE `users` (
    userId INT AUTO_INCREMENT PRIMARY KEY,
    userImg VARCHAR(255),
    name VARCHAR(255),
    username VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255)
);

-- Insert data into users table
INSERT INTO users (userImg, name, username, email, password)
VALUES  ('user1.png', 'Hau Linh Chi', 'chi', 'hlc1881@gmail.com', '1231231231'),
        ('user2.png', 'Test User', 'test', 'testuser@gmail.com', '1231231231');

-- --------------------------------------------------------

--
-- Table `newsletter`
--

CREATE TABLE `newsletter` (
    newsletterUserId INT AUTO_INCREMENT PRIMARY KEY,
    newsletterEmail VARCHAR(255) NOT NULL
);

-- --------------------------------------------------------

--
-- Table `tastebiteteam`
--

-- Create the table with memberImg column
CREATE TABLE `tastebiteteam` (
    memberId INT AUTO_INCREMENT PRIMARY KEY,
    memberName VARCHAR(255),
    memberJob VARCHAR(255),
    memberImg VARCHAR(255)
);

-- Insert data into tastebiteteam table
INSERT INTO tastebiteteam (memberName, memberJob, memberImg)
VALUES
    ('Sarah Wilson', 'Chef Extraordinaire', 'member1.png'),
    ('John Doe', 'Head Chef', 'member2.png'),
    ('Jane Smith', 'Sous Chef', 'member3.png'),
    ('Michael Johnson', 'Pastry Chef', 'member4.png'),
    ('Emily Davis', 'Food Blogger', 'member5.png'),
    ('David Brown', 'Recipe Developer', 'member6.png'),
    ('Chris Lee', 'Photographer', 'member7.png'),
    ('Laura Thompson', 'Content Creator', 'member8.png'),
    ('Alex Martin', 'Food Stylist', 'member9.png'),
    ('Jessica White', 'Nutritionist', 'member10.png'),
    ('Kevin Clark', 'Video Producer', 'member11.png'),
    ('Michelle Green', 'Community Manager', 'member12.png');

-- --------------------------------------------------------

--
-- Table `category`
--

-- Create category table
CREATE TABLE `category` (
    categoryId INT AUTO_INCREMENT PRIMARY KEY,
    categoryImg VARCHAR(255),
    categoryName VARCHAR(255)
);

-- Insert data into category table
INSERT INTO `category` (categoryImg, categoryName) VALUES
('seafood.png', 'Seafood'),
('soup.png', 'Soup'),
('pancakes.png', 'Pancakes'),
('meat.png', 'Meat'),
('chicken.png', 'Chicken'),
('pizza.png', 'Pizza'),
('cake.png', 'Cake'),
('pastries.png', 'Pastries'),
('burger.png', 'Burger'),
('vegan.png', 'Vegan'),
('desserts.png', 'Desserts'),
('smoothies.png', 'Smoothies'),
('breakfast.png', 'Breakfast'),
('salad.png', 'Salad'),
('sandwiches.png', 'Sandwiches'),
('waffles.png', 'Waffles'),
('ramen.png', 'Ramen'),
('dips.png', 'Dips'),
('less_than_30min.png', 'Less than 30 min');

-- --------------------------------------------------------

--
-- Table `suggestedrecipes`
--

CREATE TABLE suggestedrecipes (
    srId INT AUTO_INCREMENT PRIMARY KEY,
    userId INT NOT NULL,
    srName VARCHAR(255) NOT NULL,
    srCategory VARCHAR(100) NOT NULL,
    srPreptime INT NOT NULL,
    srServings INT NOT NULL,
    FOREIGN KEY (userId) REFERENCES `users`(userId),
    UNIQUE(userId, srId)
);

-- --------------------------------------------------------

--
-- Table `recipe`
--

CREATE TABLE `recipe` (
    recipeId INT AUTO_INCREMENT PRIMARY KEY,
    categoryId INT,
    recipeName VARCHAR(255),
    recipeImg VARCHAR(255),
    recipePrepTime INT,
    recipeServings INT,
    recipeVote INT DEFAULT 0,
    FOREIGN KEY (categoryId) REFERENCES `category`(categoryId)
);

-- Insert data into recipe table
INSERT INTO `recipe` (categoryId, recipeName, recipeImg, recipePrepTime, recipeServings, recipeVote) VALUES
(1, 'Best Cajun Shrimp', 'shrimp.png', 15, 2, 0),
(1, 'Garlic Caper Baked Salmon', 'salmon.png', 30, 3, 0),
(1, 'Lobster Thermidor', 'lobster.png', 20, 4, 0),
(1, 'Pan Fried Cod in Cream Kale Sauce', 'cod.png', 45, 3, 0),
(2, 'Creamy Roasted Tomato Soup', 'tomato.png', 25, 4, 0),
(2, 'Homemade Chicken Soup', 'chicken.png', 35, 3, 0),
(2, 'Classic Minestrone Soup', 'minestrone.png', 30, 5, 0),
(3, 'Pikelets - Fluffy Mini Australian Pancakes', 'pikelets.png', 20, 2, 0),
(3, 'French Crepe', 'crepe.png', 40, 2, 0),
(3, 'Cachapas - Traditional Venezuelan Corn Pancakes', 'cachapas.png', 30, 4, 0),
(3, 'Four Ingredient Oatmeal Pancakes', 'pancake.png', 25, 3, 0),
(4, 'Grilled Sliced Brisket', 'brisket.png', 40, 4, 0),
(4, 'Garlic-Butter Rib Roast', 'ribs.png', 50, 3, 0),
(4, 'Perfectly Grilled T-Bone Steak', 'steak.png', 35, 2, 0),
(5, 'Juicy Grilled Chicken Breasts', 'grilled.png', 30, 3, 0),
(5, 'Crispy Fried Chicken', 'fried.png', 25, 2, 0),
(5, 'Baked Chicken Nuggets', 'nuggets.png', 20, 4, 0),
(6, 'Classic Margherita Pizza with Fresh Basil', 'margherita.png', 35, 3, 0),
(6, 'Spicy Pepperoni Pizza', 'pepperoni.png', 30, 4, 0),
(6, 'Loaded Vegetarian Pizza with Fresh Veggies', 'vegetarian.png', 40, 4, 0),
(7, 'Ultimate Chocolate Cake with Ganache Frosting', 'chocolate.png', 45, 6, 0),
(7, 'Classic Vanilla Cake with Buttercream Icing', 'vanilla.png', 50, 8, 0),
(7, 'Red Velvet Cake with Cream Cheese Frosting', 'redvelvet.png', 55, 10, 0),
(7, 'Pumkin Marshmallow Pie and Nuts', 'pumpkinpie.png', 60, 6, 0),
(8, 'Flaky Butter Croissants', 'croissant.png', 30, 4, 0),
(8, 'Raspberry Cheese Danish', 'danish.png', 35, 3, 0),
(8, 'Blueberry Muffins with Streusel Topping', 'muffin.png', 25, 5, 0),
(9, 'Juicy Cheeseburger with Special Sauce', 'cheeseburger.png', 25, 3, 0),
(9, 'Ultimate Veggie Burger with Avocado', 'veggie.png', 30, 2, 0),
(9, 'Bacon Cheeseburger with Caramelized Onions', 'bacon.png', 35, 4, 0),
(9, 'Mighty Chessy Breakfast Burger', 'burger.png', 40, 3, 0),
(10, 'Crispy Baked Tofu with Peanut Sauce', 'tofu.png', 35, 3, 0),
(10, 'Mediterranean Quinoa Salad', 'quinoa.png', 30, 4, 0),
(10, 'Homemade Falafel with Tahini Sauce', 'falafel.png', 40, 4, 0),
(11, 'Homemade Vanilla Ice Cream', 'icecream.png', 60, 6, 0),
(11, 'Classic Chocolate Pudding', 'pudding.png', 45, 4, 0),
(11, 'New York Style Cheesecake', 'cheesecake.png', 50, 8, 0),
(11, 'Delicious Fancy Glazed Blueberry Donuts', 'donut.png', 30, 12, 0),
(11, 'Berry Maddness Biscuits', 'biscuit.png', 35, 10, 0),
(12, 'Mixed Berry Smoothie', 'berry.png', 10, 2, 0),
(12, 'Green Detox Smoothie', 'green.png', 15, 2, 0),
(12, 'Tropical Mango Smoothie', 'mango.png', 12, 3, 0),
(13, 'Fluffy Cheese Omelette', 'omelette.png', 20, 2, 0),
(13, 'Egg Bhurji (Spiced Indian Scrambled Eggs)', 'bhurji.png', 25, 3, 0),
(13, 'Avocado Toast with Poached Egg', 'toast.png', 15, 2, 0),
(14, 'Classic Caesar Salad with Homemade Dressing', 'caesar.png', 20, 2, 0),
(14, 'Authentic Greek Salad', 'greek.png', 25, 3, 0),
(14, 'Chicken Cobb Salad with Blue Cheese', 'cobb.png', 30, 4, 0),
(15, 'Turkey Club Sandwich', 'club.png', 15, 2, 0),
(15, 'Italian Panini with Mozzarella', 'panini.png', 20, 2, 0),
(15, 'Classic Submarine Sandwich', 'submarine.png', 25, 3, 0),
(16, 'Crispy Belgian Waffles', 'belgian.png', 30, 3, 0),
(16, 'Chocolate Waffles with Whipped Cream', 'chocolatewaffles.png', 25, 2, 0),
(16, 'Blueberry Waffles with Maple Syrup', 'blueberry.png', 35, 4, 0),
(17, 'Tonkotsu Ramen with Pork Belly', 'tonkotsu.png', 40, 2, 0),
(17, 'Miso Ramen with Soft-Boiled Egg', 'miso.png', 35, 3, 0),
(17, 'Shoyu Ramen with Chicken', 'shoyu.png', 30, 3, 0),
(18, 'Classic Guacamole', 'guacamole.png', 20, 2, 0),
(18, 'Creamy Hummus with Garlic', 'hummus.png', 15, 4, 0),
(18, 'Fresh Tomato Salsa', 'salsa.png', 10, 3, 0),
(19, 'Chicken and Veggie Stir-fry', 'stirfry.png', 20, 3, 0),
(19, 'Spicy Chicken Wrap', 'wrap.png', 25, 2, 0),
(19, 'Cheese Quesadilla with Salsa', 'quesadilla.png', 15, 2, 0);

-- --------------------------------------------------------

--
-- Table `votes`
--

CREATE TABLE `votes` (
    voteId INT AUTO_INCREMENT PRIMARY KEY,
    userId INT NOT NULL,
    recipeId INT NOT NULL,
    FOREIGN KEY (userId) REFERENCES `users`(userId),
    FOREIGN KEY (recipeId) REFERENCES `recipe`(recipeId),
    UNIQUE(userId, recipeId)
);

-- --------------------------------------------------------

--
-- Table `ingredients`, `instructions`
--

CREATE TABLE `ingredients` (
    recipeId INT,
    ingredient VARCHAR(255),
    FOREIGN KEY (recipeId) REFERENCES `recipe`(recipeId)
);

CREATE TABLE `instructions` (
    recipeId INT,
    instruction TEXT,
    FOREIGN KEY (recipeId) REFERENCES `recipe`(recipeId)
);

-- --------------------------------------------------------

-- Insert ingredients for recipeId = 1
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(1, '1 lb shrimp, peeled and deveined'),
(1, '2 tablespoons Cajun seasoning'),
(1, '2 tablespoons olive oil'),
(1, '2 cloves garlic, minced'),
(1, '1/4 cup chopped fresh parsley'),
(1, 'Salt and pepper to taste'),
(1, 'Lemon wedges for serving');

-- Insert instructions for recipeId = 1
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(1, 'Step 1: Heat olive oil in a large skillet over medium-high heat.'),
(1, 'Step 2: Add minced garlic and sauté until fragrant.'),
(1, 'Step 3: Add shrimp to the skillet and sprinkle Cajun seasoning evenly over them.'),
(1, 'Step 4: Cook shrimp for 2-3 minutes per side or until they turn pink and opaque.'),
(1, 'Step 5: Remove skillet from heat and stir in chopped parsley.'),
(1, 'Step 6: Season with salt and pepper to taste.'),
(1, 'Step 7: Serve hot with lemon wedges on the side.');

-- Insert ingredients for recipeId = 2
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(2, '4 salmon fillets (about 6 oz each)'),
(2, '4 tablespoons unsalted butter, melted'),
(2, '4 cloves garlic, minced'),
(2, '2 tablespoons capers, drained and chopped'),
(2, '1 tablespoon fresh lemon juice'),
(2, 'Salt and pepper to taste'),
(2, 'Fresh parsley, chopped (optional, for garnish)');

-- Insert instructions for recipeId = 2
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(2, 'Step 1: Preheat oven to 375°F (190°C). Line a baking sheet with parchment paper.'),
(2, 'Step 2: Place salmon fillets on the prepared baking sheet.'),
(2, 'Step 3: In a small bowl, mix melted butter, minced garlic, chopped capers, and lemon juice.'),
(2, 'Step 4: Spoon the butter mixture evenly over each salmon fillet.'),
(2, 'Step 5: Season with salt and pepper.'),
(2, 'Step 6: Bake salmon for 12-15 minutes, or until fish flakes easily with a fork.'),
(2, 'Step 7: Remove from oven and garnish with chopped parsley if desired.'),
(2, 'Step 8: Serve immediately.');

-- Insert ingredients for recipeId = 3
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(3, '2 lobster tails'),
(3, '1/4 cup unsalted butter'),
(3, '1/4 cup all-purpose flour'),
(3, '1 cup milk'),
(3, '1/2 cup grated Gruyère cheese'),
(3, '1/4 cup grated Parmesan cheese'),
(3, '2 tablespoons brandy or dry white wine'),
(3, '1/4 teaspoon paprika'),
(3, 'Salt and pepper to taste'),
(3, 'Fresh parsley, chopped (for garnish)');

-- Insert instructions for recipeId = 3
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(3, 'Step 1: Preheat oven to 400°F (200°C). Grease a baking dish.'),
(3, 'Step 2: Boil lobster tails until cooked, about 8-10 minutes. Remove meat from shells and chop into bite-sized pieces.'),
(3, 'Step 3: In a saucepan, melt butter over medium heat. Stir in flour until smooth and cook for 1 minute.'),
(3, 'Step 4: Gradually whisk in milk until smooth and thickened, about 5 minutes.'),
(3, 'Step 5: Stir in Gruyère cheese, Parmesan cheese, brandy or wine, paprika, salt, and pepper until cheeses are melted and sauce is creamy.'),
(3, 'Step 6: Add chopped lobster meat to the sauce and stir gently to combine.'),
(3, 'Step 7: Spoon lobster mixture into the prepared baking dish.'),
(3, 'Step 8: Bake for 10-12 minutes or until heated through and bubbly.'),
(3, 'Step 9: Remove from oven, garnish with chopped parsley, and serve hot.');

-- Insert ingredients for recipeId = 5
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(5, '2 lbs fresh tomatoes, halved'),
(5, '1 onion, chopped'),
(5, '4 cloves garlic, minced'),
(5, '2 tablespoons olive oil'),
(5, '1 teaspoon dried basil'),
(5, '1 teaspoon dried oregano'),
(5, 'Salt and pepper to taste'),
(5, '4 cups vegetable broth'),
(5, '1/2 cup heavy cream'),
(5, 'Fresh basil leaves, chopped (for garnish)');

-- Insert instructions for recipeId = 5
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(5, 'Step 1: Preheat oven to 400°F (200°C). Place tomatoes on a baking sheet, cut side up. Drizzle with olive oil, sprinkle with salt, pepper, dried basil, and dried oregano.'),
(5, 'Step 2: Roast tomatoes in the oven for 25-30 minutes until caramelized.'),
(5, 'Step 3: In a large pot, heat olive oil over medium heat. Add chopped onion and sauté until translucent.'),
(5, 'Step 4: Add minced garlic and cook for another minute until fragrant.'),
(5, 'Step 5: Add roasted tomatoes (including any juices) to the pot. Stir in vegetable broth and bring to a boil. Reduce heat and simmer for 15-20 minutes.'),
(5, 'Step 6: Use an immersion blender to puree the soup until smooth.'),
(5, 'Step 7: Stir in heavy cream and heat through.'),
(5, 'Step 8: Season with additional salt and pepper if needed.'),
(5, 'Step 9: Serve hot, garnished with chopped fresh basil.');

-- Insert ingredients for recipeId = 6
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(6, '1 whole chicken, about 4 lbs'),
(6, '10 cups water'),
(6, '2 carrots, sliced'),
(6, '2 celery stalks, sliced'),
(6, '1 onion, diced'),
(6, '2 cloves garlic, minced'),
(6, '1 bay leaf'),
(6, 'Salt and pepper to taste'),
(6, 'Fresh parsley, chopped (for garnish)'),
(6, 'Cooked egg noodles (optional, for serving)');

-- Insert instructions for recipeId = 6
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(6, 'Step 1: Place whole chicken in a large pot and cover with water.'),
(6, 'Step 2: Bring water to a boil over high heat, then reduce to a simmer. Skim off any foam that rises to the surface.'),
(6, 'Step 3: Add carrots, celery, onion, garlic, bay leaf, salt, and pepper to the pot.'),
(6, 'Step 4: Simmer uncovered for 1.5 to 2 hours, until chicken is tender and cooked through.'),
(6, 'Step 5: Remove chicken from the pot and let cool slightly. Shred chicken meat and discard bones and skin.'),
(6, 'Step 6: Return shredded chicken meat to the pot. Adjust seasoning if needed.'),
(6, 'Step 7: Serve hot, garnished with chopped parsley. Optionally, serve over cooked egg noodles.');

-- Insert ingredients for recipeId = 7
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(7, '2 tablespoons olive oil'),
(7, '1 onion, diced'),
(7, '2 carrots, diced'),
(7, '2 celery stalks, diced'),
(7, '2 cloves garlic, minced'),
(7, '1 zucchini, diced'),
(7, '1 cup diced tomatoes (canned or fresh)'),
(7, '4 cups vegetable broth'),
(7, '1 cup small pasta (like ditalini or elbow)'),
(7, '1 can (15 oz) kidney beans, drained and rinsed'),
(7, '1 teaspoon dried basil'),
(7, '1 teaspoon dried oregano'),
(7, 'Salt and pepper to taste'),
(7, 'Fresh parsley, chopped (for garnish)'),
(7, 'Grated Parmesan cheese (for serving, optional)');

-- Insert instructions for recipeId = 7
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(7, 'Step 1: Heat olive oil in a large pot over medium heat. Add diced onion, carrots, and celery. Sauté until vegetables are softened.'),
(7, 'Step 2: Add minced garlic and diced zucchini. Cook for another 2-3 minutes.'),
(7, 'Step 3: Stir in diced tomatoes and cook for 5 minutes, allowing flavors to meld.'),
(7, 'Step 4: Pour in vegetable broth and bring to a boil.'),
(7, 'Step 5: Add small pasta to the pot and cook according to package instructions until al dente.'),
(7, 'Step 6: Stir in kidney beans, dried basil, dried oregano, salt, and pepper. Simmer for another 5-10 minutes.'),
(7, 'Step 7: Remove from heat and adjust seasoning if needed.'),
(7, 'Step 8: Serve hot, garnished with chopped parsley and grated Parmesan cheese if desired.');

-- Insert ingredients for recipeId = 8
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(8, '1 cup all-purpose flour'),
(8, '1 tablespoon sugar'),
(8, '1 teaspoon baking powder'),
(8, '1/2 teaspoon baking soda'),
(8, 'Pinch of salt'),
(8, '3/4 cup buttermilk'),
(8, '1 egg'),
(8, '1 tablespoon melted butter'),
(8, 'Butter or oil for cooking');

-- Insert instructions for recipeId = 8
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(8, 'Step 1: In a mixing bowl, sift together flour, sugar, baking powder, baking soda, and salt.'),
(8, 'Step 2: In another bowl, whisk together buttermilk, egg, and melted butter.'),
(8, 'Step 3: Pour wet ingredients into dry ingredients and stir until just combined (do not overmix, a few lumps are okay).'),
(8, 'Step 4: Heat a non-stick skillet or griddle over medium heat. Brush with butter or oil.'),
(8, 'Step 5: Drop spoonfuls of batter onto the skillet, about 2 tablespoons per pikelet.'),
(8, 'Step 6: Cook until bubbles form on the surface and edges look set, about 2 minutes. Flip and cook for another 1-2 minutes until golden brown.'),
(8, 'Step 7: Remove from skillet and keep warm. Repeat with remaining batter.'),
(8, 'Step 8: Serve warm pikelets with your favorite toppings like jam, syrup, or whipped cream.');

-- Insert ingredients for recipeId = 9
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(9, '1 cup all-purpose flour'),
(9, '2 eggs'),
(9, '1/2 cup milk'),
(9, '1/2 cup water'),
(9, '2 tablespoons melted butter'),
(9, '1/4 teaspoon salt'),
(9, 'Butter or oil for cooking');

-- Insert instructions for recipeId = 9
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(9, 'Step 1: In a mixing bowl, whisk together flour and eggs.'),
(9, 'Step 2: Gradually add milk and water, stirring to combine.'),
(9, 'Step 3: Stir in melted butter and salt until smooth.'),
(9, 'Step 4: Heat a non-stick skillet or crepe pan over medium heat. Brush with butter or oil.'),
(9, 'Step 5: Pour a small amount of batter into the center of the skillet, swirling to spread evenly.'),
(9, 'Step 6: Cook for about 2 minutes until the bottom is light golden brown. Flip and cook the other side for 1 minute.'),
(9, 'Step 7: Remove crepe from skillet and keep warm. Repeat with remaining batter.'),
(9, 'Step 8: Serve warm crepes with your choice of fillings such as Nutella, fruit preserves, or savory fillings like cheese and ham.');

-- Insert ingredients for recipeId = 10
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(10, '2 cups fresh corn kernels (about 4 ears of corn)'),
(10, '1/2 cup cornmeal'),
(10, '1/4 cup milk'),
(10, '1/4 cup sugar'),
(10, 'Salt to taste'),
(10, 'Butter or oil for cooking');

-- Insert instructions for recipeId = 10
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(10, 'Step 1: In a blender or food processor, blend fresh corn kernels until smooth.'),
(10, 'Step 2: Transfer blended corn to a bowl. Add cornmeal, milk, sugar, and salt. Mix until well combined into a batter consistency.'),
(10, 'Step 3: Heat a non-stick skillet or griddle over medium heat. Brush with butter or oil.'),
(10, 'Step 4: Pour a small amount of batter onto the skillet, about 1/4 cup per cachapa.'),
(10, 'Step 5: Cook for 3-4 minutes until bubbles form on the surface and edges look set. Flip and cook for another 2-3 minutes until golden brown.'),
(10, 'Step 6: Remove from skillet and keep warm. Repeat with remaining batter.'),
(10, 'Step 7: Serve warm cachapas with cheese, butter, or your favorite toppings.');

-- Insert ingredients for recipeId = 11
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(11, '1 cup rolled oats'),
(11, '1 ripe banana'),
(11, '1 cup milk (any type)'),
(11, '1 egg');

-- Insert instructions for recipeId = 11
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(11, 'Step 1: In a blender or food processor, blend rolled oats until they become oat flour.'),
(11, 'Step 2: Add ripe banana, milk, and egg to the blender. Blend until smooth batter forms.'),
(11, 'Step 3: Heat a non-stick skillet or griddle over medium heat. Brush with butter or oil.'),
(11, 'Step 4: Pour a small amount of batter onto the skillet, about 1/4 cup per pancake.'),
(11, 'Step 5: Cook for 2-3 minutes until bubbles form on the surface. Flip and cook for another 1-2 minutes until cooked through.'),
(11, 'Step 6: Remove from skillet and keep warm. Repeat with remaining batter.'),
(11, 'Step 7: Serve warm oatmeal pancakes with fresh fruit, syrup, or yogurt.');

-- Insert ingredients for recipeId = 12
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(12, '2 lbs beef brisket, thinly sliced'),
(12, '1/4 cup soy sauce'),
(12, '2 tablespoons Worcestershire sauce'),
(12, '2 tablespoons brown sugar'),
(12, '2 cloves garlic, minced'),
(12, 'Salt and pepper to taste');

-- Insert instructions for recipeId = 12
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(12, 'Step 1: In a bowl, combine soy sauce, Worcestershire sauce, brown sugar, minced garlic, salt, and pepper.'),
(12, 'Step 2: Marinate thinly sliced beef brisket in the sauce mixture for at least 30 minutes (or overnight for best flavor).'),
(12, 'Step 3: Preheat grill or grill pan over medium-high heat.'),
(12, 'Step 4: Grill brisket slices for 3-4 minutes per side until charred and cooked through.'),
(12, 'Step 5: Remove from grill and let rest for a few minutes.'),
(12, 'Step 6: Slice grilled brisket against the grain.'),
(12, 'Step 7: Serve hot grilled brisket slices with your favorite sides like grilled vegetables or mashed potatoes.');

-- Insert ingredients for recipeId = 13
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(13, '1 (4 to 5 pounds) rib roast'),
(13, '6 cloves garlic, minced'),
(13, '2 tablespoons butter, softened'),
(13, '1 tablespoon olive oil'),
(13, 'Salt and pepper to taste');

-- Insert instructions for recipeId = 13
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(13, 'Step 1: Preheat oven to 450°F (230°C).'),
(13, 'Step 2: In a small bowl, mix minced garlic, softened butter, olive oil, salt, and pepper to form a paste.'),
(13, 'Step 3: Rub the garlic-butter paste all over the rib roast, covering it evenly.'),
(13, 'Step 4: Place the rib roast on a roasting pan with the fatty side up.'),
(13, 'Step 5: Roast in the preheated oven for 15 minutes, then reduce the temperature to 325°F (160°C).'),
(13, 'Step 6: Continue roasting for about 2 hours (or until desired doneness), basting occasionally with pan juices.'),
(13, 'Step 7: Remove from oven and let the roast rest for 15-20 minutes before slicing.'),
(13, 'Step 8: Slice and serve the garlic-butter rib roast with your favorite sides.');

-- Insert ingredients for recipeId = 14
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(14, '2 T-bone steaks'),
(14, '2 tablespoons olive oil'),
(14, '2 cloves garlic, minced'),
(14, 'Salt and pepper to taste');

-- Insert instructions for recipeId = 14
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(14, 'Step 1: Preheat grill to high heat.'),
(14, 'Step 2: Rub steaks with olive oil, minced garlic, salt, and pepper on both sides.'),
(14, 'Step 3: Place steaks on the grill and cook for 4-5 minutes per side for medium-rare (adjust time for desired doneness).'),
(14, 'Step 4: Remove steaks from grill and let rest for 5 minutes before serving.'),
(14, 'Step 5: Slice and serve the perfectly grilled T-bone steaks with grilled vegetables or salad.');

-- Insert ingredients for recipeId = 15
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(15, '4 boneless, skinless chicken breasts'),
(15, '1/4 cup olive oil'),
(15, '2 tablespoons lemon juice'),
(15, '2 cloves garlic, minced'),
(15, '1 teaspoon dried herbs (such as thyme, rosemary, or oregano)'),
(15, 'Salt and pepper to taste');

-- Insert instructions for recipeId = 15
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(15, 'Step 1: In a bowl, mix olive oil, lemon juice, minced garlic, dried herbs, salt, and pepper.'),
(15, 'Step 2: Place chicken breasts in a resealable plastic bag or shallow dish. Pour marinade over chicken, ensuring all pieces are coated. Marinate in the refrigerator for at least 30 minutes (or up to 4 hours).'),
(15, 'Step 3: Preheat grill to medium-high heat.'),
(15, 'Step 4: Remove chicken from marinade and discard marinade.'),
(15, 'Step 5: Grill chicken breasts for 6-7 minutes per side, or until internal temperature reaches 165°F (74°C) and juices run clear.'),
(15, 'Step 6: Remove from grill and let rest for 5 minutes before serving.'),
(15, 'Step 7: Slice and serve the juicy grilled chicken breasts with your favorite sides.');

-- Insert ingredients for recipeId = 16
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(16, '4 chicken drumsticks'),
(16, '4 chicken thighs'),
(16, '2 cups buttermilk'),
(16, '2 cups all-purpose flour'),
(16, '1 tablespoon salt'),
(16, '1 tablespoon paprika'),
(16, '1 teaspoon garlic powder'),
(16, '1 teaspoon onion powder'),
(16, 'Vegetable oil for frying');

-- Insert instructions for recipeId = 16
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(16, 'Step 1: In a large bowl, pour buttermilk over chicken pieces. Cover and refrigerate for at least 2 hours (overnight is best).'),
(16, 'Step 2: In a shallow dish, mix flour, salt, paprika, garlic powder, and onion powder.'),
(16, 'Step 3: Heat vegetable oil in a large skillet or deep fryer to 350°F (175°C).'),
(16, 'Step 4: Remove chicken from buttermilk and dredge each piece in the seasoned flour mixture, shaking off excess.'),
(16, 'Step 5: Carefully place chicken in hot oil, frying in batches if necessary to avoid overcrowding.'),
(16, 'Step 6: Fry chicken for about 15-20 minutes, turning occasionally, until golden brown and cooked through (internal temperature of 165°F or 74°C).'),
(16, 'Step 7: Drain fried chicken on paper towels to remove excess oil.'),
(16, 'Step 8: Serve hot and crispy fried chicken with your favorite sides.');

-- Insert ingredients for recipeId = 17
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(17, '1 pound boneless, skinless chicken breasts'),
(17, '1 cup breadcrumbs'),
(17, '1/2 cup grated Parmesan cheese'),
(17, '1 teaspoon garlic powder'),
(17, '1 teaspoon onion powder'),
(17, 'Salt and pepper to taste'),
(17, 'Cooking spray or olive oil');

-- Insert instructions for recipeId = 17
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(17, 'Step 1: Preheat oven to 400°F (200°C). Line a baking sheet with parchment paper and lightly coat with cooking spray or olive oil.'),
(17, 'Step 2: Cut chicken breasts into bite-sized pieces.'),
(17, 'Step 3: In a shallow dish, mix breadcrumbs, Parmesan cheese, garlic powder, onion powder, salt, and pepper.'),
(17, 'Step 4: Dip each chicken piece into the breadcrumb mixture, pressing to coat evenly.'),
(17, 'Step 5: Place coated chicken nuggets on the prepared baking sheet.'),
(17, 'Step 6: Bake for 15-20 minutes, flipping halfway through, until chicken is cooked through and coating is crispy.'),
(17, 'Step 7: Remove from oven and let cool slightly before serving.'),
(17, 'Step 8: Serve baked chicken nuggets with dipping sauce or as desired.');

-- Insert ingredients for recipeId = 18
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(18, '1 pizza dough (store-bought or homemade)'),
(18, '1/2 cup tomato sauce'),
(18, '1 cup fresh mozzarella cheese, sliced'),
(18, '1/4 cup fresh basil leaves, torn'),
(18, '2 tablespoons olive oil'),
(18, 'Salt and pepper to taste');

-- Insert instructions for recipeId = 18
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(18, 'Step 1: Preheat oven to 475°F (245°C). If using a pizza stone, place it in the oven to preheat as well.'),
(18, 'Step 2: Roll out pizza dough on a lightly floured surface to desired thickness.'),
(18, 'Step 3: Transfer dough to a pizza peel or parchment paper-lined baking sheet.'),
(18, 'Step 4: Spread tomato sauce evenly over the dough, leaving a small border around the edges.'),
(18, 'Step 5: Arrange mozzarella slices over the sauce.'),
(18, 'Step 6: Drizzle olive oil over the pizza and season with salt and pepper.'),
(18, 'Step 7: Transfer pizza to the preheated oven (on the pizza stone if using) and bake for 10-12 minutes, or until crust is golden and cheese is bubbly.'),
(18, 'Step 8: Remove from oven and immediately scatter torn basil leaves over the hot pizza.'),
(18, 'Step 9: Slice and serve the classic Margherita pizza with fresh basil.');

-- Insert ingredients for recipeId = 19
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(19, '1 pizza dough (store-bought or homemade)'),
(19, '1/2 cup tomato sauce'),
(19, '1 cup shredded mozzarella cheese'),
(19, '20 slices pepperoni'),
(19, '1/4 cup sliced red onion'),
(19, '1/4 cup sliced black olives'),
(19, '1/4 cup sliced banana peppers (optional)'),
(19, '1 teaspoon dried oregano'),
(19, 'Red pepper flakes to taste'),
(19, 'Olive oil for drizzling');

-- Insert instructions for recipeId = 19
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(19, 'Step 1: Preheat oven to 475°F (245°C). If using a pizza stone, place it in the oven to preheat as well.'),
(19, 'Step 2: Roll out pizza dough on a lightly floured surface to desired thickness.'),
(19, 'Step 3: Transfer dough to a pizza peel or parchment paper-lined baking sheet.'),
(19, 'Step 4: Spread tomato sauce evenly over the dough, leaving a small border around the edges.'),
(19, 'Step 5: Sprinkle shredded mozzarella cheese over the sauce.'),
(19, 'Step 6: Arrange pepperoni slices, red onion, black olives, and banana peppers (if using) evenly over the pizza.'),
(19, 'Step 7: Sprinkle dried oregano and red pepper flakes to taste.'),
(19, 'Step 8: Drizzle olive oil over the pizza.'),
(19, 'Step 9: Transfer pizza to the preheated oven (on the pizza stone if using) and bake for 10-12 minutes, or until crust is golden and cheese is bubbly.'),
(19, 'Step 10: Remove from oven and let cool slightly before slicing and serving.');

-- Insert ingredients for recipeId = 20
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(20, '1 pizza dough (store-bought or homemade)'),
(20, '1/2 cup tomato sauce'),
(20, '1 cup shredded mozzarella cheese'),
(20, '1/2 cup sliced mushrooms'),
(20, '1/2 cup sliced bell peppers (assorted colors)'),
(20, '1/4 cup sliced red onion'),
(20, '1/4 cup sliced black olives'),
(20, '1/4 cup chopped fresh spinach'),
(20, '1 teaspoon dried oregano'),
(20, 'Salt and pepper to taste'),
(20, 'Olive oil for drizzling');

-- Insert instructions for recipeId = 20
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(20, 'Step 1: Preheat oven to 475°F (245°C). If using a pizza stone, place it in the oven to preheat as well.'),
(20, 'Step 2: Roll out pizza dough on a lightly floured surface to desired thickness.'),
(20, 'Step 3: Transfer dough to a pizza peel or parchment paper-lined baking sheet.'),
(20, 'Step 4: Spread tomato sauce evenly over the dough, leaving a small border around the edges.'),
(20, 'Step 5: Sprinkle shredded mozzarella cheese over the sauce.'),
(20, 'Step 6: Arrange mushrooms, bell peppers, red onion, black olives, and chopped spinach evenly over the pizza.'),
(20, 'Step 7: Sprinkle dried oregano, salt, and pepper to taste.'),
(20, 'Step 8: Drizzle olive oil over the pizza.'),
(20, 'Step 9: Transfer pizza to the preheated oven (on the pizza stone if using) and bake for 10-12 minutes, or until crust is golden and cheese is bubbly.'),
(20, 'Step 10: Remove from oven and let cool slightly before slicing and serving.');

-- Insert ingredients for recipeId = 21
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(21, '2 cups all-purpose flour'),
(21, '2 cups granulated sugar'),
(21, '3/4 cup unsweetened cocoa powder'),
(21, '2 teaspoons baking powder'),
(21, '1 1/2 teaspoons baking soda'),
(21, '1 teaspoon salt'),
(21, '2 large eggs'),
(21, '1 cup milk'),
(21, '1/2 cup vegetable oil'),
(21, '2 teaspoons vanilla extract'),
(21, '1 cup boiling water'),
(21, 'For Ganache Frosting:'),
(21, '1 cup heavy cream'),
(21, '8 ounces semi-sweet chocolate, chopped'),
(21, '1 tablespoon unsalted butter'),
(21, '1 teaspoon vanilla extract');

-- Insert instructions for recipeId = 21
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(21, 'Step 1: Preheat oven to 350°F (175°C). Grease and flour two 9-inch round cake pans.'),
(21, 'Step 2: In a large bowl, combine flour, sugar, cocoa powder, baking powder, baking soda, and salt.'),
(21, 'Step 3: Add eggs, milk, oil, and vanilla extract; beat on medium speed for 2 minutes.'),
(21, 'Step 4: Stir in boiling water (batter will be thin).'),
(21, 'Step 5: Pour batter evenly into prepared cake pans.'),
(21, 'Step 6: Bake for 30 to 35 minutes, or until a toothpick inserted into the center comes out clean.'),
(21, 'Step 7: Cool in pans for 10 minutes, then remove from pans and cool completely on wire racks.'),
(21, 'Step 8: For Ganache Frosting: In a small saucepan, heat cream over medium heat until steaming (do not boil).'),
(21, 'Step 9: Remove from heat and stir in chopped chocolate, butter, and vanilla extract until smooth.'),
(21, 'Step 10: Let ganache cool for 10-15 minutes, then spread over cooled cake layers.'),
(21, 'Step 11: Let frosting set before slicing and serving.');

-- Insert ingredients for recipeId = 22
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(22, '1 1/2 cups all-purpose flour'),
(22, '1 1/2 teaspoons baking powder'),
(22, '1/4 teaspoon salt'),
(22, '1/2 cup unsalted butter, room temperature'),
(22, '1 cup granulated sugar'),
(22, '2 large eggs'),
(22, '2 teaspoons vanilla extract'),
(22, '1/2 cup milk');

-- Insert instructions for recipeId = 22
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(22, 'Step 1: Preheat oven to 350°F (175°C). Grease and flour two 8-inch round cake pans.'),
(22, 'Step 2: In a medium bowl, whisk together flour, baking powder, and salt.'),
(22, 'Step 3: In a large bowl, cream together butter and sugar until light and fluffy.'),
(22, 'Step 4: Beat in eggs, one at a time, then stir in vanilla extract.'),
(22, 'Step 5: Gradually add flour mixture alternately with milk, beginning and ending with flour mixture.'),
(22, 'Step 6: Pour batter evenly into prepared pans.'),
(22, 'Step 7: Bake for 25 to 30 minutes, or until a toothpick inserted into the center comes out clean.'),
(22, 'Step 8: Cool in pans for 10 minutes, then remove from pans and cool completely on wire racks.'),
(22, 'Step 9: Frost with your favorite buttercream icing.');

-- Insert ingredients for recipeId = 23
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(23, '2 1/2 cups all-purpose flour'),
(23, '1 1/2 cups granulated sugar'),
(23, '1 teaspoon baking soda'),
(23, '1 teaspoon salt'),
(23, '2 tablespoons unsweetened cocoa powder'),
(23, '1 cup vegetable oil'),
(23, '1 cup buttermilk'),
(23, '2 large eggs'),
(23, '2 tablespoons red food coloring'),
(23, '1 teaspoon vanilla extract'),
(23, '1 teaspoon white vinegar');

-- Insert instructions for recipeId = 23
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(23, 'Step 1: Preheat oven to 350°F (175°C). Grease and flour two 9-inch round cake pans.'),
(23, 'Step 2: In a large bowl, sift together flour, sugar, baking soda, salt, and cocoa powder.'),
(23, 'Step 3: In another large bowl, whisk together oil, buttermilk, eggs, food coloring, vanilla extract, and vinegar.'),
(23, 'Step 4: Gradually add dry ingredients to wet ingredients, mixing until combined and smooth.'),
(23, 'Step 5: Pour batter evenly into prepared pans.'),
(23, 'Step 6: Bake for 30 to 35 minutes, or until a toothpick inserted into the center comes out clean.'),
(23, 'Step 7: Cool in pans for 10 minutes, then remove from pans and cool completely on wire racks.'),
(23, 'Step 8: Frost with cream cheese frosting.');

-- Insert ingredients for recipeId = 24
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(24, '1 (15 oz) can pumpkin puree'),
(24, '1 (14 oz) can sweetened condensed milk'),
(24, '2 large eggs'),
(24, '1 teaspoon ground cinnamon'),
(24, '1/2 teaspoon ground ginger'),
(24, '1/2 teaspoon ground nutmeg'),
(24, '1/2 teaspoon salt'),
(24, '1 unbaked pie crust'),
(24, '1 cup mini marshmallows'),
(24, '1/2 cup chopped nuts (pecans or walnuts)');

-- Insert instructions for recipeId = 24
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(24, 'Step 1: Preheat oven to 425°F (220°C).'),
(24, 'Step 2: In a large bowl, whisk together pumpkin puree, sweetened condensed milk, eggs, cinnamon, ginger, nutmeg, and salt until smooth.'),
(24, 'Step 3: Pour mixture into unbaked pie crust.'),
(24, 'Step 4: Bake for 15 minutes at 425°F (220°C), then reduce heat to 350°F (175°C) and continue baking for 30 minutes.'),
(24, 'Step 5: Remove pie from oven and top with mini marshmallows and chopped nuts.'),
(24, 'Step 6: Return to oven and bake for an additional 5-10 minutes, or until marshmallows are golden brown.'),
(24, 'Step 7: Cool completely on wire rack before serving.');

-- Insert ingredients for recipeId = 25
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(25, '2 1/4 cups all-purpose flour'),
(25, '1/4 cup granulated sugar'),
(25, '1 teaspoon salt'),
(25, '1 1/2 cups unsalted butter, cold'),
(25, '1/2 cup cold water'),
(25, '1/2 cup cold milk'),
(25, '2 1/4 teaspoons active dry yeast'),
(25, '1 egg, beaten (for egg wash)');

-- Insert instructions for recipeId = 25
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(25, 'Step 1: In a large bowl, combine flour, sugar, and salt.'),
(25, 'Step 2: Cut cold butter into small cubes and add to flour mixture. Use a pastry cutter or fork to cut butter into the flour until it resembles coarse crumbs.'),
(25, 'Step 3: In a separate bowl, mix cold water, cold milk, and yeast. Let sit for 5 minutes until yeast activates.'),
(25, 'Step 4: Pour yeast mixture into the flour mixture. Stir until dough comes together.'),
(25, 'Step 5: Turn dough out onto a floured surface and knead gently until smooth.'),
(25, 'Step 6: Roll dough into a rectangle about 1/4 inch thick. Fold dough into thirds like a letter. Wrap in plastic wrap and chill in the refrigerator for 30 minutes.'),
(25, 'Step 7: Remove dough from refrigerator and roll out again into a rectangle. Fold into thirds again. Chill for another 30 minutes.'),
(25, 'Step 8: Repeat rolling and folding process two more times (total of 4 times).'),
(25, 'Step 9: Roll dough into a large rectangle about 1/4 inch thick. Cut triangles from the dough.'),
(25, 'Step 10: Roll each triangle from the base towards the tip to form croissants. Place on a baking sheet lined with parchment paper.'),
(25, 'Step 11: Cover with a clean kitchen towel and let rise in a warm place for 1-2 hours, or until doubled in size.'),
(25, 'Step 12: Preheat oven to 400°F (200°C). Brush croissants with beaten egg wash.'),
(25, 'Step 13: Bake for 15-20 minutes, or until golden brown and flaky.');

-- Insert ingredients for recipeId = 26
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(26, '1 sheet puff pastry, thawed'),
(26, '4 oz cream cheese, softened'),
(26, '2 tablespoons granulated sugar'),
(26, '1/2 teaspoon vanilla extract'),
(26, '1/2 cup raspberry jam'),
(26, '1/4 cup sliced almonds (optional)'),
(26, 'Powdered sugar, for dusting');

-- Insert instructions for recipeId = 26
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(26, 'Step 1: Preheat oven to 400°F (200°C). Line a baking sheet with parchment paper.'),
(26, 'Step 2: Roll out puff pastry into a rectangle. Cut into 4 equal squares.'),
(26, 'Step 3: In a bowl, mix cream cheese, granulated sugar, and vanilla extract until smooth.'),
(26, 'Step 4: Spread cream cheese mixture evenly onto the center of each pastry square.'),
(26, 'Step 5: Spoon raspberry jam over the cream cheese mixture.'),
(26, 'Step 6: Fold opposite corners of each square towards the center, slightly overlapping to create a pinwheel shape.'),
(26, 'Step 7: Sprinkle sliced almonds over the top, if using.'),
(26, 'Step 8: Bake for 15-18 minutes, or until pastry is golden brown and puffed.'),
(26, 'Step 9: Remove from oven and let cool on a wire rack.'),
(26, 'Step 10: Dust with powdered sugar before serving.');

-- Insert ingredients for recipeId = 27
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(27, '1 1/2 cups all-purpose flour'),
(27, '3/4 cup granulated sugar'),
(27, '1/2 teaspoon salt'),
(27, '2 teaspoons baking powder'),
(27, '1/3 cup vegetable oil'),
(27, '1 egg'),
(27, '1/3 cup milk'),
(27, '1 cup fresh or frozen blueberries'),
(27, '1/2 cup all-purpose flour (for streusel topping)'),
(27, '1/4 cup granulated sugar (for streusel topping)'),
(27, '1/4 cup unsalted butter, chilled and cubed (for streusel topping)');

-- Insert instructions for recipeId = 27
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(27, 'Step 1: Preheat oven to 400°F (200°C). Line a muffin tin with paper liners or grease well.'),
(27, 'Step 2: In a large bowl, whisk together flour, sugar, salt, and baking powder.'),
(27, 'Step 3: In another bowl, whisk together oil, egg, and milk until well combined.'),
(27, 'Step 4: Pour wet ingredients into dry ingredients and stir until just combined.'),
(27, 'Step 5: Gently fold in blueberries.'),
(27, 'Step 6: In a small bowl, combine flour, sugar, and chilled butter cubes for streusel topping. Use a pastry cutter or fork to blend until mixture resembles coarse crumbs.'),
(27, 'Step 7: Fill muffin cups about 3/4 full with batter.'),
(27, 'Step 8: Sprinkle streusel topping evenly over each muffin.'),
(27, 'Step 9: Bake for 18-20 minutes, or until tops are golden and a toothpick inserted into the center comes out clean.'),
(27, 'Step 10: Cool muffins in the pan for 5 minutes, then transfer to a wire rack to cool completely.');

-- Insert ingredients for recipeId = 28
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(28, '1 lb ground beef'),
(28, 'Salt and pepper, to taste'),
(28, '4 hamburger buns'),
(28, '4 slices cheddar cheese'),
(28, '4 lettuce leaves'),
(28, '4 tomato slices'),
(28, '4 onion slices'),
(28, 'Special Sauce: 1/4 cup mayonnaise, 2 tablespoons ketchup, 1 tablespoon sweet pickle relish, 1 teaspoon white vinegar, 1/2 teaspoon sugar, 1/4 teaspoon salt, 1/4 teaspoon paprika');

-- Insert instructions for recipeId = 28
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(28, 'Step 1: Preheat grill or skillet over medium-high heat.'),
(28, 'Step 2: Season ground beef with salt and pepper. Form into 4 patties.'),
(28, 'Step 3: Grill or cook patties until desired doneness, about 4-5 minutes per side for medium.'),
(28, 'Step 4: Toast hamburger buns on the grill or in the skillet.'),
(28, 'Step 5: Assemble burgers with lettuce, tomato, onion, cheddar cheese, and Special Sauce on toasted buns.');

-- Insert ingredients for recipeId = 29
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(29, '4 veggie burger patties'),
(29, '4 whole wheat burger buns'),
(29, '1 avocado, sliced'),
(29, '4 lettuce leaves'),
(29, '4 tomato slices'),
(29, '4 onion slices'),
(29, '4 tablespoons hummus'),
(29, 'Salt and pepper, to taste');

-- Insert instructions for recipeId = 29
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(29, 'Step 1: Preheat grill or skillet over medium heat.'),
(29, 'Step 2: Grill veggie burger patties until heated through and grill marks appear, about 4-5 minutes per side.'),
(29, 'Step 3: Toast burger buns on the grill.'),
(29, 'Step 4: Spread hummus on the bottom half of each bun.'),
(29, 'Step 5: Layer lettuce, tomato, onion, veggie burger patty, and avocado slices on each bun.'),
(29, 'Step 6: Season with salt and pepper, if desired. Top with the other half of the bun.');

-- Insert ingredients for recipeId = 30
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(30, '1 lb ground beef'),
(30, 'Salt and pepper, to taste'),
(30, '4 hamburger buns'),
(30, '4 slices cheddar cheese'),
(30, '8 slices bacon, cooked'),
(30, '1 onion, thinly sliced and caramelized'),
(30, 'Lettuce and tomato, for serving');

-- Insert instructions for recipeId = 30
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(30, 'Step 1: Preheat grill or skillet over medium-high heat.'),
(30, 'Step 2: Season ground beef with salt and pepper. Form into 4 patties.'),
(30, 'Step 3: Grill or cook patties until desired doneness, about 4-5 minutes per side for medium.'),
(30, 'Step 4: Toast hamburger buns on the grill or in the skillet.'),
(30, 'Step 5: Assemble burgers with lettuce, tomato, cheddar cheese, bacon, and caramelized onions on toasted buns.');

-- Insert ingredients for recipeId = 31
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(31, '1 lb ground breakfast sausage'),
(31, 'Salt and pepper, to taste'),
(31, '4 hamburger buns'),
(31, '4 slices cheddar cheese'),
(31, '4 fried eggs'),
(31, '4 slices cooked bacon'),
(31, 'Maple syrup (optional)');

-- Insert instructions for recipeId = 31
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(31, 'Step 1: Preheat grill or skillet over medium heat.'),
(31, 'Step 2: Season ground breakfast sausage with salt and pepper. Form into 4 patties.'),
(31, 'Step 3: Grill or cook sausage patties until cooked through, about 4-5 minutes per side.'),
(31, 'Step 4: Toast hamburger buns on the grill or in the skillet.'),
(31, 'Step 5: Assemble burgers with cheddar cheese, sausage patty, fried egg, and bacon on toasted buns.'),
(31, 'Step 6: Drizzle with maple syrup, if desired.');

-- Insert ingredients for recipeId = 32
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(32, '1 block firm tofu, pressed and cut into cubes'),
(32, '2 tablespoons soy sauce'),
(32, '1 tablespoon sesame oil'),
(32, '1 tablespoon cornstarch'),
(32, 'Salt and pepper, to taste'),
(32, '1/2 cup peanut butter'),
(32, '2 tablespoons soy sauce'),
(32, '1 tablespoon honey'),
(32, '1 tablespoon rice vinegar'),
(32, '1 teaspoon sesame oil'),
(32, 'Water, as needed');

-- Insert instructions for recipeId = 32
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(32, 'Step 1: Preheat oven to 400°F (200°C). Line a baking sheet with parchment paper.'),
(32, 'Step 2: In a bowl, toss tofu cubes with soy sauce, sesame oil, cornstarch, salt, and pepper until well coated.'),
(32, 'Step 3: Arrange tofu cubes on the baking sheet in a single layer. Bake for 25-30 minutes, flipping halfway through, until tofu is crispy and golden brown.'),
(32, 'Step 4: In a small saucepan, combine peanut butter, soy sauce, honey, rice vinegar, sesame oil, and water. Heat over medium-low heat, stirring constantly until smooth and heated through.'),
(32, 'Step 5: Serve crispy tofu with peanut sauce for dipping.');

-- Insert ingredients for recipeId = 33
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(33, '1 cup quinoa, rinsed'),
(33, '2 cups water or vegetable broth'),
(33, '1 cucumber, diced'),
(33, '1 bell pepper, diced'),
(33, '1/2 cup cherry tomatoes, halved'),
(33, '1/4 cup red onion, finely chopped'),
(33, '1/4 cup Kalamata olives, sliced'),
(33, '1/4 cup fresh parsley, chopped'),
(33, '1/4 cup feta cheese, crumbled'),
(33, 'Salt and pepper, to taste'),
(33, 'Lemon vinaigrette: 1/4 cup olive oil, 2 tablespoons lemon juice, 1 garlic clove, minced, 1 teaspoon Dijon mustard, Salt and pepper, to taste');

-- Insert instructions for recipeId = 33
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(33, 'Step 1: In a medium saucepan, bring water or vegetable broth to a boil. Add quinoa, reduce heat to low, cover, and simmer for 15 minutes, or until quinoa is cooked and liquid is absorbed. Remove from heat and let cool.'),
(33, 'Step 2: In a large bowl, combine cooked quinoa, cucumber, bell pepper, cherry tomatoes, red onion, Kalamata olives, parsley, and feta cheese.'),
(33, 'Step 3: In a small bowl, whisk together olive oil, lemon juice, minced garlic, Dijon mustard, salt, and pepper to make the lemon vinaigrette.'),
(33, 'Step 4: Pour vinaigrette over the quinoa salad and toss to coat evenly. Season with additional salt and pepper, if needed.'),
(33, 'Step 5: Serve chilled or at room temperature.');

-- Insert ingredients for recipeId = 34
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(34, '1 cup dried chickpeas, soaked overnight'),
(34, '1 small onion, chopped'),
(34, '3 cloves garlic'),
(34, '1/4 cup fresh parsley, chopped'),
(34, '1/4 cup fresh cilantro, chopped'),
(34, '1 tsp ground cumin'),
(34, '1 tsp ground coriander'),
(34, '1/2 tsp baking soda'),
(34, 'Salt and pepper, to taste'),
(34, 'Vegetable oil, for frying'),
(34, '1/2 cup tahini paste'),
(34, '1/4 cup water'),
(34, '2 tbsp lemon juice'),
(34, '1 clove garlic, minced');

-- Insert instructions for recipeId = 34
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(34, 'Step 1: Drain and rinse the soaked chickpeas. In a food processor, combine chickpeas, onion, garlic, parsley, cilantro, cumin, coriander, baking soda, salt, and pepper. Process until mixture forms a coarse paste.'),
(34, 'Step 2: Shape the mixture into small balls or patties. Heat vegetable oil in a frying pan over medium heat. Fry falafel until golden brown and crispy, about 3-4 minutes per side.'),
(34, 'Step 3: For the tahini sauce, whisk together tahini paste, water, lemon juice, minced garlic, and salt until smooth and creamy.'),
(34, 'Step 4: Serve falafel warm with tahini sauce drizzled over the top.');

-- Insert ingredients for recipeId = 35
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(35, '2 cups heavy cream'),
(35, '1 cup whole milk'),
(35, '3/4 cup granulated sugar'),
(35, '1 vanilla bean, split and seeds scraped out'),
(35, '6 large egg yolks'),
(35, '1 tsp vanilla extract');

-- Insert instructions for recipeId = 35
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(35, 'Step 1: In a saucepan, heat cream, milk, sugar, and vanilla bean (seeds and pod) over medium heat until mixture just begins to simmer.'),
(35, 'Step 2: In a bowl, whisk egg yolks. Slowly pour hot cream mixture into yolks, whisking constantly. Return mixture to saucepan and cook over low heat, stirring constantly, until it thickens enough to coat the back of a spoon.'),
(35, 'Step 3: Remove from heat, stir in vanilla extract. Strain mixture through a fine mesh sieve into a bowl. Chill in the refrigerator until cold.'),
(35, 'Step 4: Churn mixture in an ice cream maker according to manufacturer instructions. Transfer to an airtight container and freeze until firm.');

-- Insert ingredients for recipeId = 36
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(36, '1/2 cup granulated sugar'),
(36, '1/4 cup unsweetened cocoa powder'),
(36, '1/4 cup cornstarch'),
(36, '1/8 tsp salt'),
(36, '2 3/4 cups whole milk'),
(36, '2 large egg yolks'),
(36, '1 tsp vanilla extract'),
(36, '2 tbsp unsalted butter');

-- Insert instructions for recipeId = 36
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(36, 'Step 1: In a saucepan, whisk together sugar, cocoa powder, cornstarch, and salt. Gradually whisk in milk until smooth.'),
(36, 'Step 2: Cook over medium heat, stirring constantly, until mixture thickens and boils. Boil for 1 minute, then remove from heat.'),
(36, 'Step 3: In a small bowl, whisk egg yolks. Gradually whisk in 1 cup of the hot cocoa mixture. Return all to saucepan, cook and stir over medium heat until mixture comes to a boil. Boil and stir for 1 minute.'),
(36, 'Step 4: Remove from heat, stir in vanilla extract and butter until butter is melted and mixture is smooth. Pour into serving dishes and refrigerate until chilled.');

-- Insert ingredients for recipeId = 37
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(37, '1 1/2 cups graham cracker crumbs'),
(37, '1/4 cup granulated sugar'),
(37, '1/2 cup unsalted butter, melted'),
(37, '4 packages (8 oz each) cream cheese, softened'),
(37, '1 cup granulated sugar'),
(37, '1 tsp vanilla extract'),
(37, '4 large eggs'),
(37, '1 cup sour cream');

-- Insert instructions for recipeId = 37
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(37, 'Step 1: Preheat oven to 325°F (160°C). Mix graham cracker crumbs, sugar, and melted butter. Press onto bottom of 9-inch springform pan.'),
(37, 'Step 2: Beat cream cheese, sugar, and vanilla extract with electric mixer on medium speed until well blended. Add eggs, 1 at a time, mixing on low speed after each addition just until blended. Pour over crust.'),
(37, 'Step 3: Bake 55 min. or until center is almost set. Remove from oven; cool before removing rim. Refrigerate 4 hours.'),
(37, 'Step 4: Spread sour cream over cheesecake. Run small knife around sides of pan to loosen cake; remove rim. Keep refrigerated.');

-- Insert ingredients for recipeId = 38
INSERT INTO `ingredients` (recipeId, ingredient)
VALUES 
(38, '2 cups all-purpose flour'),
(38, '1/2 cup granulated sugar'),
(38, '2 tsp baking powder'),
(38, '1/2 tsp salt'),
(38, '1/2 cup milk'),
(38, '2 large eggs'),
(38, '4 tbsp unsalted butter, melted'),
(38, '1 tsp vanilla extract'),
(38, '1 cup fresh blueberries'),
(38, '1 cup powdered sugar'),
(38, '2-3 tbsp milk'),
(38, '1/2 tsp vanilla extract');

-- Insert instructions for recipeId = 38
INSERT INTO `instructions` (recipeId, instruction)
VALUES 
(38, 'Step 1: Preheat oven to 375°F (190°C). Grease a donut pan.'),
(38, 'Step 2: In a bowl, whisk together flour, sugar, baking powder, and salt. In another bowl, whisk milk, eggs, melted butter, and vanilla extract. Add wet ingredients to dry ingredients and stir until just combined. Gently fold in blueberries.'),
(38, 'Step 3: Spoon batter into a piping bag or a plastic bag with the corner snipped off. Pipe batter into prepared donut pan, filling each cavity about 2/3 full.'),
(38, 'Step 4: Bake for 10-12 minutes or until donuts spring back when touched. Let cool in pan for 5 minutes before transferring to a wire rack to cool completely.'),
(38, 'Step 5: For the glaze, whisk together powdered sugar, milk, and vanilla extract until smooth. Dip cooled donuts into glaze and place on a wire rack to set.');

-- Recipe: Berry Madness Biscuits (recipeId = 39)
INSERT INTO cos30043.ingredients (recipeId, ingredient)
VALUES (39, '2 cups all-purpose flour'),
       (39, '1/4 cup granulated sugar'),
       (39, '1 tablespoon baking powder'),
       (39, '1/2 teaspoon salt'),
       (39, '1/2 cup unsalted butter, cold and cubed'),
       (39, '3/4 cup mixed berries (such as blueberries, raspberries, strawberries)'),
       (39, '3/4 cup milk'),
       (39, '1 teaspoon vanilla extract');

INSERT INTO cos30043.instructions (recipeId, instruction)
VALUES (39, 'Step 1: Preheat oven to 400°F (200°C). Line a baking sheet with parchment paper.'),
       (39, 'Step 2: In a large bowl, whisk together flour, sugar, baking powder, and salt. Cut in butter until mixture resembles coarse crumbs.'),
       (39, 'Step 3: Gently fold in mixed berries. Add milk and vanilla extract, stirring until dough just comes together.'),
       (39, 'Step 4: Turn dough out onto a lightly floured surface. Pat into a circle about 1 inch thick. Cut into biscuits using a round cutter.'),
       (39, 'Step 5: Place biscuits on the prepared baking sheet. Bake for 15-18 minutes, or until golden brown.'),
       (39, 'Step 6: Remove from oven and let cool slightly before serving.');

-- Recipe: Mixed Berry Smoothie (recipeId = 40)
INSERT INTO cos30043.ingredients (recipeId, ingredient)
VALUES (40, '1 cup mixed berries (strawberries, blueberries, raspberries)'),
       (40, '1 banana, sliced'),
       (40, '1/2 cup plain yogurt'),
       (40, '1/2 cup milk (or almond milk)'),
       (40, '1 tablespoon honey (optional)'),
       (40, 'Ice cubes');

INSERT INTO cos30043.instructions (recipeId, instruction)
VALUES (40, 'Step 1: Place mixed berries, banana, yogurt, milk, and honey in a blender.'),
       (40, 'Step 2: Blend until smooth. Add ice cubes and blend again until desired consistency is reached.'),
       (40, 'Step 3: Pour into glasses and serve immediately.');

-- Recipe: Green Detox Smoothie (recipeId = 41)
INSERT INTO cos30043.ingredients (recipeId, ingredient)
VALUES (41, '1 cup spinach leaves'),
       (41, '1/2 cup cucumber, sliced'),
       (41, '1/2 cup pineapple chunks'),
       (41, '1/2 avocado, peeled and pitted'),
       (41, 'Juice of 1 lemon'),
       (41, '1 tablespoon chia seeds'),
       (41, '1 cup water (or coconut water)'),
       (41, 'Ice cubes');

INSERT INTO cos30043.instructions (recipeId, instruction)
VALUES (41, 'Step 1: Place spinach, cucumber, pineapple, avocado, lemon juice, and chia seeds in a blender.'),
       (41, 'Step 2: Add water and blend until smooth. Add ice cubes and blend again until well combined.'),
       (41, 'Step 3: Pour into glasses and serve immediately.');

-- Recipe: Tropical Mango Smoothie (recipeId = 42)
INSERT INTO cos30043.ingredients (recipeId, ingredient)
VALUES (42, '2 ripe mangoes, peeled and diced'),
       (42, '1 banana, sliced'),
       (42, '1/2 cup Greek yogurt'),
       (42, '1/2 cup orange juice'),
       (42, '1 tablespoon honey (optional)'),
       (42, 'Ice cubes');

INSERT INTO cos30043.instructions (recipeId, instruction)
VALUES (42, 'Step 1: Place mangoes, banana, Greek yogurt, orange juice, and honey in a blender.'),
       (42, 'Step 2: Blend until smooth. Add ice cubes and blend again until creamy and smooth.'),
       (42, 'Step 3: Pour into glasses and serve immediately.');

-- Recipe: Fluffy Cheese Omelette (recipeId = 43)
INSERT INTO cos30043.ingredients (recipeId, ingredient)
VALUES (43, '3 large eggs'),
       (43, '1/4 cup milk'),
       (43, 'Salt and pepper, to taste'),
       (43, '1/3 cup shredded cheddar cheese'),
       (43, '1 tablespoon butter');

INSERT INTO cos30043.instructions (recipeId, instruction)
VALUES (43, 'Step 1: In a bowl, whisk together eggs, milk, salt, and pepper until well combined.'),
       (43, 'Step 2: Heat butter in a non-stick skillet over medium heat. Pour in egg mixture.'),
       (43, 'Step 3: As eggs begin to set, gently push them with a spatula, tilting the pan to let the uncooked eggs flow to the edges.'),
       (43, 'Step 4: Sprinkle cheese over half of the omelette. Fold the omelette in half and cook for another minute, until cheese is melted.'),
       (43, 'Step 5: Slide omelette onto a plate and serve hot.');

-- Inserting ingredients (recipeId = 44)
INSERT INTO cos30043.ingredients (recipeId, ingredient)
VALUES (44, '4 eggs'),
       (44, '1 onion, finely chopped'),
       (44, '2 tomatoes, finely chopped'),
       (44, '2 green chilies, finely chopped'),
       (44, '1/2 teaspoon turmeric powder'),
       (44, '1/2 teaspoon red chili powder'),
       (44, 'Salt to taste'),
       (44, 'Fresh coriander leaves, chopped'),
       (44, '2 tablespoons oil');

-- Inserting instructions
INSERT INTO cos30043.instructions (recipeId, instruction)
VALUES (44, 'Step 1: Heat oil in a pan. Add chopped onions and sauté until golden brown.'),
       (44, 'Step 2: Add chopped tomatoes, green chilies, turmeric powder, red chili powder, and salt. Cook until tomatoes are soft.'),
       (44, 'Step 3: Break eggs directly into the pan. Stir continuously until eggs are cooked and well scrambled.'),
       (44, 'Step 4: Garnish with chopped coriander leaves and serve hot.');

-- Inserting ingredients (recipeId = 45)
INSERT INTO cos30043.ingredients (recipeId, ingredient)
VALUES (45, '2 slices of whole grain bread'),
       (45, '1 ripe avocado'),
       (45, '2 eggs'),
       (45, 'Salt and pepper to taste'),
       (45, 'Red pepper flakes (optional)'),
       (45, 'Lemon juice (optional)');

-- Inserting instructions
INSERT INTO cos30043.instructions (recipeId, instruction)
VALUES (45, 'Step 1: Toast the slices of bread until golden brown.'),
       (45, 'Step 2: Mash the ripe avocado and spread evenly on toasted bread slices.'),
       (45, 'Step 3: Poach the eggs until desired doneness.'),
       (45, 'Step 4: Place poached eggs on top of avocado toast. Season with salt, pepper, red pepper flakes, and lemon juice if desired.');

-- Inserting ingredients (recipeId = 46)
INSERT INTO cos30043.ingredients (recipeId, ingredient)
VALUES (46, '1 head of romaine lettuce'),
       (46, '1/2 cup croutons'),
       (46, '1/4 cup grated Parmesan cheese'),
       (46, '1/2 cup mayonnaise'),
       (46, '2 tablespoons grated Parmesan cheese'),
       (46, '1 tablespoon Dijon mustard'),
       (46, '1 clove garlic, minced'),
       (46, '2 tablespoons lemon juice'),
       (46, 'Salt and pepper to taste');

-- Inserting instructions
INSERT INTO cos30043.instructions (recipeId, instruction)
VALUES (46, 'Step 1: Tear the romaine lettuce into bite-sized pieces and place in a large bowl.'),
       (46, 'Step 2: Add croutons and grated Parmesan cheese.'),
       (46, 'Step 3: In a bowl, whisk together mayonnaise, Parmesan cheese, Dijon mustard, garlic, lemon juice, salt, and pepper until smooth.'),
       (46, 'Step 4: Toss salad with Caesar dressing just before serving.');

-- Inserting ingredients (recipeId = 47)
INSERT INTO cos30043.ingredients (recipeId, ingredient)
VALUES (47, '1 cucumber, sliced'),
       (47, '2 tomatoes, cut into wedges'),
       (47, '1 red onion, thinly sliced'),
       (47, '1 green bell pepper, sliced'),
       (47, '1/2 cup Kalamata olives'),
       (47, '1/2 cup feta cheese, crumbled'),
       (47, '1/4 cup extra virgin olive oil'),
       (47, '2 tablespoons red wine vinegar'),
       (47, '1 teaspoon dried oregano'),
       (47, 'Salt and pepper to taste');

-- Inserting instructions
INSERT INTO cos30043.instructions (recipeId, instruction)
VALUES (47, 'Step 1: Combine cucumber, tomatoes, red onion, bell pepper, olives, and feta cheese in a large bowl.'),
       (47, 'Step 2: In a small bowl, whisk together olive oil, red wine vinegar, dried oregano, salt, and pepper until well combined.'),
       (47, 'Step 3: Toss salad with Greek dressing just before serving.');

-- Inserting ingredients (recipeId = 48)
INSERT INTO cos30043.ingredients (recipeId, ingredient)
VALUES (48, '2 cups mixed salad greens'),
       (48, '1 boneless, skinless chicken breast, grilled and sliced'),
       (48, '1/2 cup cherry tomatoes, halved'),
       (48, '1/2 cup cucumber, sliced'),
       (48, '1/4 cup blue cheese, crumbled'),
       (48, '2 hard-boiled eggs, sliced'),
       (48, 'Bacon bits (optional)'),
       (48, '1/2 cup mayonnaise'),
       (48, '1/2 cup sour cream'),
       (48, '1 tablespoon chopped fresh dill'),
       (48, '1 tablespoon chopped fresh parsley'),
       (48, '1 clove garlic, minced'),
       (48, '1 tablespoon lemon juice'),
       (48, 'Salt and pepper to taste');

-- Inserting instructions
INSERT INTO cos30043.instructions (recipeId, instruction)
VALUES (48, 'Step 1: Arrange mixed salad greens on a plate.'),
       (48, 'Step 2: Top with grilled chicken breast, cherry tomatoes, cucumber, blue cheese, hard-boiled eggs, and bacon bits if using.'),
       (48, 'Step 3: In a bowl, whisk together mayonnaise, sour cream, dill, parsley, garlic, lemon juice, salt, and pepper until smooth.'),
       (48, 'Step 4: Drizzle salad with Ranch dressing just before serving.');

-- Insert ingredients (recipeId = 49)
INSERT INTO cos30043.ingredients (recipeId, ingredient)
VALUES (49, 'Sliced turkey breast'),
       (49, 'Bacon'),
       (49, 'Lettuce'),
       (49, 'Tomato slices'),
       (49, 'Mayonnaise'),
       (49, 'Toasted bread slices');

-- Insert instructions
INSERT INTO cos30043.instructions (recipeId, instruction)
VALUES (49, 'Step 1: Layer toasted bread with mayonnaise.'),
       (49, 'Step 2: Add lettuce, tomato slices, bacon, and sliced turkey.'),
       (49, 'Step 3: Top with another slice of toasted bread.');

-- Insert ingredients (recipeId = 50)
INSERT INTO cos30043.ingredients (recipeId, ingredient)
VALUES (50, 'Ciabatta bread'),
       (50, 'Fresh mozzarella slices'),
       (50, 'Tomato slices'),
       (50, 'Fresh basil leaves'),
       (50, 'Pesto sauce');

-- Insert instructions
INSERT INTO cos30043.instructions (recipeId, instruction)
VALUES (50, 'Step 1: Slice ciabatta bread and spread pesto sauce on both sides.'),
       (50, 'Step 2: Layer with mozzarella slices, tomato slices, and fresh basil leaves.'),
       (50, 'Step 3: Grill until bread is crispy and cheese is melted.');

-- Insert ingredients (recipeId = 51)
INSERT INTO cos30043.ingredients (recipeId, ingredient)
VALUES (51, 'Submarine sandwich roll'),
       (51, 'Salami'),
       (51, 'Ham'),
       (51, 'Provolone cheese'),
       (51, 'Lettuce'),
       (51, 'Tomato slices'),
       (51, 'Red onion slices'),
       (51, 'Italian dressing');

-- Insert instructions
INSERT INTO cos30043.instructions (recipeId, instruction)
VALUES (51, 'Step 1: Slice the submarine roll lengthwise.'),
       (51, 'Step 2: Layer with salami, ham, provolone cheese, lettuce, tomato slices, and red onion slices.'),
       (51, 'Step 3: Drizzle with Italian dressing.');

-- Insert ingredients (recipeId = 52)
INSERT INTO cos30043.ingredients (recipeId, ingredient)
VALUES (52, 'Waffle batter'),
       (52, 'Butter'),
       (52, 'Maple syrup');

-- Insert instructions
INSERT INTO cos30043.instructions (recipeId, instruction)
VALUES (52, 'Step 1: Preheat waffle iron and grease with butter.'),
       (52, 'Step 2: Pour waffle batter onto the iron and cook until golden brown and crispy.'),
       (52, 'Step 3: Serve hot with maple syrup.');

-- Insert ingredients  (recipeId = 53)
INSERT INTO cos30043.ingredients (recipeId, ingredient)
VALUES (53, 'Waffle batter'),
       (53, 'Cocoa powder'),
       (53, 'Whipped cream'),
       (53, 'Chocolate syrup');

-- Insert instructions
INSERT INTO cos30043.instructions (recipeId, instruction)
VALUES (53, 'Step 1: Mix cocoa powder into waffle batter.'),
       (53, 'Step 2: Preheat waffle iron and pour batter onto the iron.'),
       (53, 'Step 3: Cook until done, then top with whipped cream and chocolate syrup.');

-- Insert ingredients (recipeId = 54)
INSERT INTO cos30043.ingredients (recipeId, ingredient)
VALUES (54, 'Waffle batter'),
       (54, 'Fresh blueberries'),
       (54, 'Maple syrup');

-- Insert instructions
INSERT INTO cos30043.instructions (recipeId, instruction)
VALUES (54, 'Step 1: Mix fresh blueberries into waffle batter.'),
       (54, 'Step 2: Preheat waffle iron and pour batter onto the iron.'),
       (54, 'Step 3: Cook until done, then serve hot with maple syrup.');

-- Insert ingredients (recipeId = 55)
INSERT INTO cos30043.ingredients (recipeId, ingredient)
VALUES (55, 'Pork belly'),
       (55, 'Ramen noodles'),
       (55, 'Tonkotsu broth');

-- Insert instructions
INSERT INTO cos30043.instructions (recipeId, instruction)
VALUES (55, 'Step 1: Cook the pork belly until crispy.'),
       (55, 'Step 2: Prepare the tonkotsu broth.'),
       (55, 'Step 3: Cook the ramen noodles according to package instructions.'),
       (55, 'Step 4: Assemble ramen by placing noodles in broth and topping with pork belly.');

-- Insert ingredients (recipeId = 56)
INSERT INTO cos30043.ingredients (recipeId, ingredient)
VALUES (56, 'Soft-boiled eggs'),
       (56, 'Miso paste'),
       (56, 'Ramen noodles');

-- Insert instructions
INSERT INTO cos30043.instructions (recipeId, instruction)
VALUES (56, 'Step 1: Cook the ramen noodles.'),
       (56, 'Step 2: Mix miso paste into hot water for broth.'),
       (56, 'Step 3: Peel and halve the soft-boiled eggs.'),
       (56, 'Step 4: Serve noodles in miso broth, topped with eggs.');

-- Insert ingredients (recipeId = 57)
INSERT INTO cos30043.ingredients (recipeId, ingredient)
VALUES (57, 'Chicken breast'),
       (57, 'Shoyu (soy sauce)'),
       (57, 'Ramen noodles');

-- Insert instructions
INSERT INTO cos30043.instructions (recipeId, instruction)
VALUES (57, 'Step 1: Grill or cook chicken breast.'),
       (57, 'Step 2: Prepare shoyu broth.'),
       (57, 'Step 3: Cook ramen noodles until tender.'),
       (57, 'Step 4: Slice chicken and serve over noodles with broth.');

-- Insert ingredients (recipeId = 58)
INSERT INTO cos30043.ingredients (recipeId, ingredient)
VALUES (58, 'Avocados'),
       (58, 'Tomatoes'),
       (58, 'Lime juice');

-- Insert instructions
INSERT INTO cos30043.instructions (recipeId, instruction)
VALUES (58, 'Step 1: Mash avocados in a bowl.'),
       (58, 'Step 2: Dice tomatoes and add to avocado.'),
       (58, 'Step 3: Mix in lime juice and salt to taste.');

-- Insert ingredients (recipeId = 59)
INSERT INTO cos30043.ingredients (recipeId, ingredient)
VALUES
    (59, '1 can (15 oz) chickpeas, drained and rinsed'),
    (59, '1/4 cup fresh lemon juice'),
    (59, '1/4 cup tahini'),
    (59, '1 small garlic clove, minced'),
    (59, '2 tbsp olive oil'),
    (59, '1/2 tsp ground cumin'),
    (59, 'Salt to taste'),
    (59, '2 to 3 tbsp water');

-- Insert instructions
INSERT INTO cos30043.instructions (recipeId, instruction)
VALUES
    (59, 'Step 1: Combine all ingredients in a food processor.'),
    (59, 'Step 2: Blend until smooth, adding water as needed to achieve desired consistency.');

-- Insert ingredients (recipeId = 60)
INSERT INTO cos30043.ingredients (recipeId, ingredient)
VALUES
    (60, '4 tomatoes, diced'),
    (60, '1/2 red onion, finely chopped'),
    (60, '1/4 cup fresh cilantro, chopped'),
    (60, '1 jalapeño pepper, seeded and minced'),
    (60, '2 tbsp fresh lime juice'),
    (60, 'Salt to taste');

-- Insert instructions
INSERT INTO cos30043.instructions (recipeId, instruction)
VALUES
    (60, 'Step 1: In a bowl, combine tomatoes, red onion, cilantro, jalapeño, lime juice, and salt.'),
    (60, 'Step 2: Mix well and refrigerate for at least 30 minutes before serving.');

-- Insert ingredients (recipeId = 61)
INSERT INTO cos30043.ingredients (recipeId, ingredient)
VALUES
    (61, '1 lb boneless, skinless chicken breast, thinly sliced'),
    (61, '2 cups mixed vegetables (bell peppers, broccoli, snap peas)'),
    (61, '3 tbsp soy sauce'),
    (61, '2 tbsp oyster sauce'),
    (61, '1 tbsp sesame oil'),
    (61, '2 cloves garlic, minced'),
    (61, '1 tsp fresh ginger, minced'),
    (61, 'Salt and pepper to taste');

-- Insert instructions
INSERT INTO cos30043.instructions (recipeId, instruction)
VALUES
    (61, 'Step 1: Heat sesame oil in a large skillet over medium-high heat.'),
    (61, 'Step 2: Add garlic and ginger, sauté for 1 minute. Add chicken and cook until browned.'),
    (61, 'Step 3: Add mixed vegetables, soy sauce, oyster sauce, salt, and pepper. Stir-fry until vegetables are tender and chicken is cooked through.');

-- Insert ingredients (recipeId = 62)
INSERT INTO cos30043.ingredients (recipeId, ingredient)
VALUES
    (62, '2 boneless, skinless chicken breasts, grilled and sliced'),
    (62, '4 large flour tortillas'),
    (62, '1/2 cup ranch dressing'),
    (62, '1/4 cup buffalo sauce'),
    (62, '1 cup shredded lettuce'),
    (62, '1/2 cup diced tomatoes'),
    (62, '1/2 cup shredded cheddar cheese');

-- Insert instructions
INSERT INTO cos30043.instructions (recipeId, instruction)
VALUES
    (62, 'Step 1: In a small bowl, mix ranch dressing and buffalo sauce.'),
    (62, 'Step 2: Lay out tortillas and spread ranch mixture evenly over each. Top with chicken, lettuce, tomatoes, and cheese.'),
    (62, 'Step 3: Roll up tightly and cut in half to serve.');

-- Insert ingredients (recipeId = 63)
INSERT INTO cos30043.ingredients (recipeId, ingredient)
VALUES
    (63, '4 large flour tortillas'),
    (63, '2 cups shredded cheddar cheese'),
    (63, '1/2 cup fresh tomato salsa');

-- Insert instructions
INSERT INTO cos30043.instructions (recipeId, instruction)
VALUES
    (63, 'Step 1: Place a tortilla on a skillet over medium heat. Sprinkle with cheese and top with another tortilla.'),
    (63, 'Step 2: Cook until bottom tortilla is golden brown, then flip and cook until cheese is melted.'),
    (63, 'Step 3: Cut into wedges and serve with fresh tomato salsa.');