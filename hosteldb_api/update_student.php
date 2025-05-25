<?php
header("Content-Type: application/json");
include("db_config.php");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $studentID = $_POST['studentID'];
    $studentName = $_POST['StudentName'];
    $sContactNo = $_POST['SContactNo'];
    $gender = $_POST['Gender'];
    $feeStatus = $_POST['FeeStatus'];

    // Update Student table
    $updateStudentQuery = "
        UPDATE Student SET 
            StudentName = '$studentName',
            SContactNo = '$sContactNo',
            Gender = '$gender'
        WHERE StudentID = '$studentID'
    ";

    $studentUpdated = mysqli_query($conn, $updateStudentQuery);

    // Update Fee table
    $updateFeeQuery = "
        UPDATE Fee SET 
            Status = '$feeStatus'
        WHERE StudentID = '$studentID'
    ";

    $feeUpdated = mysqli_query($conn, $updateFeeQuery);

    if ($studentUpdated && $feeUpdated) {
        echo json_encode(["success" => true, "message" => "Student updated successfully."]);
    } else {
        echo json_encode(["success" => false, "message" => "Update failed."]);
    }
} else {
    echo json_encode(["error" => "Invalid request."]);
}
?>
