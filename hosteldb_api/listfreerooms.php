<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

// Database credentials
$host = "localhost";
$user = "root";
$password = "Pass123"; // change if needed
$database = "hosteldb";

// Create connection
$conn = new mysqli($host, $user, $password, $database);

// Check connection
if ($conn->connect_error) {
    die(json_encode(["success" => false, "message" => "Connection failed: " . $conn->connect_error]));
}

// SQL query to get free rooms (OccupiedCount != 2)
$sql = "SELECT RoomID, HostelID, Capacity, OccupiedCount FROM room WHERE OccupiedCount != 2";
$result = $conn->query($sql);

// Prepare response
$rooms = [];

if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $rooms[] = $row;
    }
    echo json_encode(["success" => true, "data" => $rooms]);
} else {
    echo json_encode(["success" => true, "data" => [], "message" => "No free rooms found"]);
}

$conn->close();
?>
