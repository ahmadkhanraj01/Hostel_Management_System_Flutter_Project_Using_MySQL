<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

$host = "127.0.0.1";
$db = "hosteldb";
$user = "root";
$pass = "Pass123";

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    die(json_encode(["error" => "Connection failed: " . $conn->connect_error]));
}

$roomID = isset($_GET['roomID']) ? $_GET['roomID'] : '';

$sql = "SELECT 
            s.StudentID, s.StudentName, s.SContactNo, s.Gender,
            f.Status AS FeeStatus,
            'N/A' AS FatherName  -- Placeholder
        FROM Student s
        LEFT JOIN Fee f ON s.StudentID = f.StudentID
        WHERE s.RoomID = ?
        LIMIT 2";

$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $roomID);
$stmt->execute();
$result = $stmt->get_result();

$students = [];
while ($row = $result->fetch_assoc()) {
    $students[] = $row;
}

// If only 1 student found, append a dummy one with NULLs
if (count($students) == 1) {
    $students[] = [
        "StudentID" => null,
        "StudentName" => null,
        "SContactNo" => null,
        "Gender" => null,
        "FeeStatus" => null,
        "FatherName" => null
    ];
}

// If no students found
if (count($students) == 0) {
    echo json_encode([]);
} else {
    echo json_encode($students);
}

$conn->close();
?>
