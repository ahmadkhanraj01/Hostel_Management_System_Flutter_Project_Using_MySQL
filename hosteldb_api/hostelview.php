<?php
// Database credentials
$host = 'localhost';
$user = 'root'; // your MySQL username
$pass = 'Pass123'; // your MySQL password (fixed: removed extra space)
$dbname = 'hosteldb'; // your database name

// Create connection
$conn = new mysqli($host, $user, $pass, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Query to get all hostels
$sql = "SELECT HostelID, HostelName, WardenID, RoomOccupied, TotalRooms FROM hostel";
$result = $conn->query($sql);

// Check if data exists
if ($result->num_rows > 0) {
    $hostels = [];
    while ($row = $result->fetch_assoc()) {
        $hostels[] = $row;
    }
    echo json_encode($hostels);  // Return data as JSON
} else {
    echo json_encode([]);  // Return empty array if no data
}

$conn->close();
?>
