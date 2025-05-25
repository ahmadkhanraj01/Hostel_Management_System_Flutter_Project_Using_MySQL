<?php
header('Content-Type: application/json');
include("db_config.php");

$data = json_decode(file_get_contents("php://input"), true);

$feeID = $data['feeID'];
$newStatus = $data['status'];

if (in_array($newStatus, ['Paid', 'Unpaid', 'Pending'])) {
    $sql = "UPDATE Fee SET Status = ? WHERE FeeID = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("si", $newStatus, $feeID);

    if ($stmt->execute()) {
        echo json_encode(["success" => true, "message" => "Status updated"]);
    } else {
        echo json_encode(["success" => false, "message" => "Update failed"]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Invalid status"]);
}
?>
