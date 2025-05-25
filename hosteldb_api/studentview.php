<?php
// Database credentials
$host = 'localhost';
$user = 'root';
$pass = 'Pass123'; // Make sure there's no extra space at the end
$dbname = 'hosteldb';

// Create connection
$conn = new mysqli($host, $user, $pass, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Query to fetch all students
$sql = "SELECT StudentID, RoomID, StudentName, SContactNo, Gender FROM student";
$result = $conn->query($sql);

// Check and return results
if ($result->num_rows > 0) {
    $students = [];
    while ($row = $result->fetch_assoc()) {
        $students[] = $row;
    }
    echo json_encode($students); // Return student data as JSON
} else {
    echo json_encode([]); // Return empty array if no data
}

$conn->close();
?>
