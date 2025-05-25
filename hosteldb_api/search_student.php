<?php
header("Content-Type: application/json");

// Database connection
$host = "127.0.0.1";
$user = "root";
$password = "Pass123";
$dbname = "hosteldb";

$conn = new mysqli($host, $user, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die(json_encode(["error" => "Connection failed: " . $conn->connect_error]));
}

// Get search query
$search = isset($_GET['name']) ? $conn->real_escape_string($_GET['name']) : '';

// SQL query without GROUP BY
$sql = "
    SELECT 
        s.StudentID,
        s.StudentName,
        s.RoomID,
        f.Status AS FeeStatus
    FROM 
        Student s
    LEFT JOIN Fee f ON s.StudentID = f.StudentID
    WHERE 
        s.StudentName LIKE '%$search%'
";

$result = $conn->query($sql);

$students = [];

if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $students[] = [
            "student_id" => $row['StudentID'],
            "name" => $row['StudentName'],
            "room_id" => $row['RoomID'] ?? 'Not Assigned',
            "fee_status" => $row['FeeStatus'] ?? 'Unknown',
        ];
    }
} else {
    $students = []; // no results found
}

echo json_encode($students);
$conn->close();
?>
