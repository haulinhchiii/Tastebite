<?php
// Reference:
// https://www.leaseweb.com/labs/2015/10/creating-a-simple-rest-api-in-php/

// Use this API for demonstration purposes only


// get the HTTP method, path and body of the request
$method = $_SERVER['REQUEST_METHOD'];
$request = explode('/', trim($_SERVER['PATH_INFO'], '/'));
$input = json_decode(file_get_contents('php://input'), true);  // json string to associative array(true)

// connect to the mysql database, provide the appropriate credentials
require_once('settings.php');
$conn = mysqli_connect($host, $username, $password, $dbname);

mysqli_set_charset($conn, 'utf8');

// initialise the table name accordingly
$table = "users";

// retrieve the search key field name and value from the path
$fld = preg_replace('/[^a-z0-9_]+/i', '', array_shift($request));
$key = array_shift($request);

// retrieve the data to prepare set values
if (isset($input)) {
    $columns = preg_replace('/[^a-z0-9_]+/i', '', array_keys($input));
    $values = array_map(function ($value) use ($conn) {
      if ($value === null) return null;
      return mysqli_real_escape_string($conn, (string)$value);
    }, array_values($input));
  
    $set = '';
    for ($i = 0; $i < count($columns); $i++) {
      $set .= ($i > 0 ? ',' : '') . '`' . $columns[$i] . '`=';
      $set .= ($values[$i] === null ? 'NULL' : '"' . $values[$i] . '"');
    }
  }
  
// create SQL
switch ($method) {
    case 'GET':
        // check if username or email exists
        if (isset($_GET['username']) || isset($_GET['email'])) {
            $username = isset($_GET['username']) ? mysqli_real_escape_string($conn, $_GET['username']) : null;
            $email = isset($_GET['email']) ? mysqli_real_escape_string($conn, $_GET['email']) : null;

            $sql = "SELECT 1 FROM `$table` WHERE (username='$username' OR email='$email')";
            $result = mysqli_query($conn, $sql);
        }
        break;

    case 'POST':
        // login functionality
        if (isset($input['username']) && isset($input['password'])) {
            $username = mysqli_real_escape_string($conn, $input['username']);
            $password = mysqli_real_escape_string($conn, $input['password']);
            $sql = "SELECT * FROM `$table` WHERE username='$username' AND password='$password'";
        } else {
            http_response_code(400);
            echo json_encode(['error' => 'Username and password are required']);
            exit();
        }
        break;

    case 'PUT':
        // update profile functionality
        if (isset($input['userId']) && isset($input['name']) && isset($input['username']) && isset($input['email']) && isset($input['password'])) {
            $userId = mysqli_real_escape_string($conn, $input['userId']);
            $name = mysqli_real_escape_string($conn, $input['name']);
            $username = mysqli_real_escape_string($conn, $input['username']);
            $email = mysqli_real_escape_string($conn, $input['email']);
            $password = mysqli_real_escape_string($conn, $input['password']);
            
            $sql = "UPDATE `$table` SET 
                    name='$name', 
                    username='$username', 
                    email='$email', 
                    password='$password' 
                    WHERE userId='$userId'";
        }
        break;
}

// execute SQL statement
$result = mysqli_query($conn, $sql);
if ($result) {
    if ($method == 'POST') {
        echo json_encode(mysqli_fetch_object($result));
    } elseif ($method == 'PUT') {
        echo json_encode(['success' => mysqli_affected_rows($conn) > 0]);
    }
}

// close mysql connection
mysqli_close($conn);
?>