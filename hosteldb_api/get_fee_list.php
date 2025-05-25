<?php
header('Content-Type: application/json');
include("db_config.php");

$statusFilter = isset($_GET['status']) ? $_GET['status'] : '';

$sql = "SELECT Fee.FeeID, Fee.StudentID, Student.StudentName, Fee.Amount, Fee.Status 
        FROM Fee 
        JOIN Student ON Fee.StudentID = Student.StudentID";

if ($statusFilter && in_array($statusFilter, ['Paid', 'Unpaid', 'Pending'])) {
    $sql .= " WHERE Fee.Status = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $statusFilter);
} else {
    $stmt = $conn->prepare($sql);
}

$stmt->execute();
$result = $stmt->get_result();
$students = [];

while ($row = $result->fetch_assoc()) {
    $students[] = $row;
}

echo json_encode($students);
$conn->close();
?>
