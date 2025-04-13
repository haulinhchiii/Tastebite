<?php
// Reference:
// https://www.leaseweb.com/labs/2015/10/creating-a-simple-rest-api-in-php/

// Use this API for demonstration purposes only


// get the HTTP method, path and body of the request
$method = $_SERVER['REQUEST_METHOD'];
$request = explode('/', trim($_SERVER['PATH_INFO'], '/'));
$input = json_decode(file_get_contents('php://input'), true);

// connect to the mysql database, provide the appropriate credentials
require_once('settings.php');
$conn = mysqli_connect($host, $username, $password, $dbname);

mysqli_set_charset($conn, 'utf8');

// initialise the table name accordingly
$table = "recipe";

// retrieve the search key field name and value from the path
$fld = preg_replace('/[^a-z0-9_]+/i', '', array_shift($request));
$key = array_shift($request);

// create SQL
switch ($method) {
    case 'GET':
        if ($fld === 'category') {
            $categoryId = mysqli_real_escape_string($conn, $key);
            $sql = "SELECT * FROM `$table` WHERE `categoryId`='$categoryId'";
        } else if ($fld === 'recipe') {
            $recipeId = mysqli_real_escape_string($conn, $key);
            $sql = "SELECT * FROM `$table` WHERE `recipeId`='$recipeId'";
        } else if ($fld === 'ingredients') {
            $recipeId = mysqli_real_escape_string($conn, $key);
            $sql = "SELECT * FROM `ingredients` WHERE `recipeId`='$recipeId'";
        } else if ($fld === 'instructions') {
            $recipeId = mysqli_real_escape_string($conn, $key);
            $sql = "SELECT * FROM `instructions` WHERE `recipeId`='$recipeId'";
        } else {
            $sql = "SELECT * FROM `$table`" . ($key ? " WHERE $fld='$key'" : '');
        }
        break;

    case 'PUT':
        $sql = "UPDATE `$table` SET $set WHERE " . ($key ? "$fld='$key'" : "0=1");
        break;

    case 'POST':
        $sql = "INSERT INTO `$table` SET $set";
        break;

    case 'DELETE':
        $sql = "DELETE FROM `$table` WHERE " . ($key ? "$fld='$key'" : "0=1");
        break;
}

// execute SQL statement
$result = mysqli_query($conn, $sql);
if ($result) {
  if ($method == 'GET') {
    header('Content-Type: application/json');
    echo '[';
    for ($i = 0; $i < mysqli_num_rows($result); $i++) {
      echo ($i > 0 ? ',' : '') . json_encode(mysqli_fetch_object($result));
    }
    echo ']';
  } elseif ($method == 'POST') {
    echo mysqli_insert_id($conn);
  } else {
    echo mysqli_affected_rows($conn);
  }
}

// close mysql connection
mysqli_close($conn);