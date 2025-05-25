<?php
header('Content-Type: application/json');

// Database credentials
$host = "127.0.0.1";
$user = "root";
$password = "Pass123";
$database = "hosteldb";

// Connect to database
$conn = new mysqli($host, $user, $password, $database);
if ($conn->connect_error) {
    echo json_encode(["success" => false, "message" => "Database connection failed"]);
    exit();
}

// Get POST data
$roomID = $_POST['roomID'] ?? '';
$studentName = $_POST['studentName'] ?? '';
$contactNo = $_POST['contactNo'] ?? '';

// Basic validation
if (empty($roomID) || empty($studentName) || empty($contactNo)) {
    echo json_encode(["success" => false, "message" => "Missing required fields"]);
    exit();
}

// Determine gender from room ID prefix
$prefix = strtolower(substr($roomID, 0, 2));
if ($prefix === "ah" || $prefix === "al") {
    $gender = "Male";
} else if ($prefix === "ay") {
    $gender = "Female";
} else {
    echo json_encode(["success" => false, "message" => "Invalid room ID prefix"]);
    exit();
}

// Check room capacity
$roomQuery = $conn->prepare("SELECT Capacity, OccupiedCount FROM room WHERE RoomID = ?");
$roomQuery->bind_param("s", $roomID);
$roomQuery->execute();
$roomResult = $roomQuery->get_result();

if ($roomResult->num_rows === 0) {
    echo json_encode(["success" => false, "message" => "Room not found"]);
    exit();
}

$room = $roomResult->fetch_assoc();
if ($room['OccupiedCount'] >= $room['Capacity']) {
    echo json_encode(["success" => false, "message" => "Room is already full"]);
    exit();
}

// Insert into student table
$insertQuery = $conn->prepare("INSERT INTO student (RoomID, StudentName, SContactNo, Gender) VALUES (?, ?, ?, ?)");
$insertQuery->bind_param("ssss", $roomID, $studentName, $contactNo, $gender);

if ($insertQuery->execute()) {
    // Update OccupiedCount
    $updateQuery = $conn->prepare("UPDATE room SET OccupiedCount = OccupiedCount + 1 WHERE RoomID = ?");
    $updateQuery->bind_param("s", $roomID);
    $updateQuery->execute();

    echo json_encode(["success" => true, "message" => "Student added successfully"]);
} else {
    echo json_encode(["success" => false, "message" => "Failed to insert student"]);
}

$conn->close();
?>
