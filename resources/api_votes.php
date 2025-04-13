<?php
// Reference:
// https://www.leaseweb.com/labs/2015/10/creating-a-simple-rest-api-in-php/

// Use this API for demonstration purposes only

// get the HTTP method, path and body of the request
$method = $_SERVER['REQUEST_METHOD'];
$request = explode('/', isset($_SERVER['PATH_INFO']) ? trim($_SERVER['PATH_INFO'], '/') : '');
$input = json_decode(file_get_contents('php://input'), true);

// Connect to the MySQL database, provide the appropriate credentials
require_once('settings.php');
$conn = mysqli_connect($host, $username, $password, $dbname);

mysqli_set_charset($conn, 'utf8');

// initialise the table name accordingly
$votesTable = "votes";
$recipeTable = "recipe";

// create SQL
switch ($method) {
    case 'GET':
        if (isset($_GET['userId'])) {
            $userId = mysqli_real_escape_string($conn, $_GET['userId']);

            // fetch the voted recipes for the user
            $fetchVotedRecipesSql = "
                SELECT r.recipeId, r.recipeName, c.categoryName, r.recipePrepTime, r.recipeServings
                FROM `$votesTable` v
                INNER JOIN `$recipeTable` r ON v.recipeId = r.recipeId
                INNER JOIN `category` c ON r.categoryId = c.categoryId
                WHERE v.userId = '$userId'
                ORDER BY v.voteId DESC
            ";

            $result = mysqli_query($conn, $fetchVotedRecipesSql);

            if ($result) {
                $votedRecipes = [];
                while ($row = mysqli_fetch_assoc($result)) {
                    $votedRecipes[] = $row;
                }
                echo json_encode($votedRecipes);
            } else {
                echo json_encode(["error" => "Failed to fetch voted recipes."]);
            }
        } else {
            echo json_encode(["error" => "User ID not provided."]);
        }
        break;
        
    case 'POST':
        // retrieve the input data
        $userId = mysqli_real_escape_string($conn, $input['userId']);
        $recipeId = mysqli_real_escape_string($conn, $input['recipeId']);

        // record the vote
        $insertVoteSql = "INSERT INTO `$votesTable` (userId, recipeId) VALUES ('$userId', '$recipeId')";
        if (mysqli_query($conn, $insertVoteSql)) {
            // update the vote count for the recipe
            $updateVoteSql = "UPDATE `$recipeTable` SET `recipeVote` = `recipeVote` + 1 WHERE `recipeId` = '$recipeId'";
            mysqli_query($conn, $updateVoteSql);
            echo json_encode(["success" => true, "message" => "Voted successfully!"]);
        } else {
            echo json_encode(["success" => false, "message" => "Failed to record vote."]);
        }
        break;

    case 'DELETE':
        // retrieve the input data
        $userId = mysqli_real_escape_string($conn, $input['userId']);
        $recipeId = mysqli_real_escape_string($conn, $input['recipeId']);

        // remove the vote
        $deleteVoteSql = "DELETE FROM `$votesTable` WHERE `userId`='$userId' AND `recipeId`='$recipeId'";
        if (mysqli_query($conn, $deleteVoteSql)) {
            // update the vote count for the recipe
            $updateVoteSql = "UPDATE `$recipeTable` SET `recipeVote` = `recipeVote` - 1 WHERE `recipeId` = '$recipeId'";
            mysqli_query($conn, $updateVoteSql);
            echo json_encode(["success" => true, "message" => "Unvoted successfully!"]);
        } else {
            echo json_encode(["success" => false, "message" => "Failed to remove vote."]);
        }
        break;
}

mysqli_close($conn);
?>