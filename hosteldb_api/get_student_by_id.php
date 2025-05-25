<?php
header("Content-Type: application/json");

include("db_config.php");

if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['studentID'])) {
    $studentID = $_GET['studentID'];

    $query = "
        SELECT 
            s.StudentID,
            s.RoomID,
            s.StudentName,
            s.SContactNo,
            s.Gender,
            f.Status AS FeeStatus
        FROM Student s
        LEFT JOIN Fee f ON s.StudentID = f.StudentID
        WHERE s.StudentID = '$studentID'
    ";

    $result = mysqli_query($conn, $query);

    if ($result) {
        $student = mysqli_fetch_assoc($result);
        echo json_encode($student);
    } else {
        http_response_code(500);
        echo json_encode(["error" => "Query failed: " . mysqli_error($conn)]);
    }
} else {
    http_response_code(400);
    echo json_encode(["error" => "Invalid request or studentID missing."]);
}
?>
