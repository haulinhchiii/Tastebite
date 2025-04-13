<?php
// Connect to the database
require_once('settings.php');
$conn = mysqli_connect($host, $username, $password, $dbname);

if (!$conn) {
    header('HTTP/1.1 500 Internal Server Error');
    echo json_encode(['error' => 'Database connection failed: ' . mysqli_connect_error()]);
    exit;
}

mysqli_set_charset($conn, 'utf8');

// Initialize the table name
$table = "suggestedrecipes";

// Get the HTTP method and path
$method = $_SERVER['REQUEST_METHOD'];
$request = explode('/', isset($_SERVER['PATH_INFO']) ? trim($_SERVER['PATH_INFO'], '/') : '');

// Get the key field and value from the path
$fld = isset($request[0]) ? preg_replace('/[^a-z0-9_]+/i', '', $request[0]) : null;
$key = isset($request[1]) ? $request[1] : null;

// Handle the request based on the method
switch ($method) {
    case 'GET':
        $userId = isset($_GET['userId']) ? mysqli_real_escape_string($conn, $_GET['userId']) : null;
        $sql = "SELECT * FROM `$table`" . ($userId ? " WHERE `userId`='$userId'" : '');
        break;
    case 'POST':
        $input = json_decode(file_get_contents('php://input'), true);
        $set = '';
        $columns = ['userId', 'srName', 'srCategory', 'srPreptime', 'srServings'];
        foreach ($columns as $column) {
            if (!isset($input[$column])) {
                header('HTTP/1.1 400 Bad Request');
                echo json_encode(['error' => "Missing required field: $column"]);
                exit;
            }
            $value = mysqli_real_escape_string($conn, $input[$column]);
            $set .= "`$column`='$value',";
        }
        $set = rtrim($set, ',');
        $sql = "INSERT INTO `$table` SET $set";
        break;
    case 'DELETE':
        if (!$key) {
            header('HTTP/1.1 400 Bad Request');
            echo json_encode(['error' => 'No srId specified for deletion']);
            exit;
        }
        $key = mysqli_real_escape_string($conn, $key);
        $sql = "DELETE FROM `$table` WHERE `srId`='$key'";
        break;
    default:
        header('HTTP/1.1 405 Method Not Allowed');
        echo json_encode(['error' => 'Invalid HTTP method']);
        exit;
}

$result = mysqli_query($conn, $sql);

if ($result) {
    header('Content-Type: application/json');
    switch ($method) {
        case 'GET':
            $rows = [];
            while ($row = mysqli_fetch_assoc($result)) {
                $rows[] = $row;
            }
            echo json_encode($rows);
            break;
        case 'POST':
            $id = mysqli_insert_id($conn);
            echo json_encode(['id' => $id]);
            break;
        default:
            echo json_encode(['affectedRows' => mysqli_affected_rows($conn)]);
    }
} else {
    header('HTTP/1.1 500 Internal Server Error');
    echo json_encode(['error' => 'Database error: ' . mysqli_error($conn)]);
}

mysqli_close($conn);
?>