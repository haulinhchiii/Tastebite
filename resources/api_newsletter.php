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
$table = "newsletter";

// create SQL
switch ($method) {
    case 'GET':
        // check if email exists
        if (isset($_GET['email'])) {
            $email = mysqli_real_escape_string($conn, $_GET['email']);
            $sql = "SELECT 1 FROM `$table` WHERE newsletterEmail='$email'";
            $result = mysqli_query($conn, $sql);
            $exists = mysqli_num_rows($result) > 0;
            echo json_encode(['exists' => $exists]);
            exit();
        }
        break;

    case 'POST':
        // subscribe email functionality
        if (isset($input['email'])) {
            $email = mysqli_real_escape_string($conn, $input['email']);
            
            $sql = "INSERT INTO `$table` (newsletterEmail) VALUES (?)";
            $stmt = mysqli_prepare($conn, $sql);
            mysqli_stmt_bind_param($stmt, 's', $email);
            $result = mysqli_stmt_execute($stmt);
            mysqli_stmt_close($stmt);

            if ($result) {
                echo json_encode(['success' => true]);
            } else {
                http_response_code(500);
                echo json_encode(['error' => 'Database error: ' . mysqli_error($conn)]);
            }
            exit();
        }
        break;
}

// close mysql connection
mysqli_close($conn);
?>