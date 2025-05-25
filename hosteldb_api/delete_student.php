<?php
header('Content-Type: application/json');
include "db_config.php";

if (isset($_GET['studentID'])) {
    $studentID = $_GET['studentID'];

    // Delete from fee table first due to FK constraint
    $query1 = "DELETE FROM fee WHERE StudentID = ?";
    $stmt1 = $conn->prepare($query1);
    $stmt1->bind_param("i", $studentID);
    $stmt1->execute();

    // Then delete from student table
    $query2 = "DELETE FROM student WHERE StudentID = ?";
    $stmt2 = $conn->prepare($query2);
    $stmt2->bind_param("i", $studentID);
    $stmt2->execute();

    if ($stmt2->affected_rows > 0) {
        echo json_encode(["success" => true, "message" => "Student deleted successfully"]);
    } else {
        echo json_encode(["success" => false, "message" => "Student not found or already deleted"]);
    }

    $stmt1->close();
    $stmt2->close();
    $conn->close();
} else {
    echo json_encode(["success" => false, "message" => "studentID parameter missing"]);
}
?>
