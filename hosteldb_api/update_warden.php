<?php
header("Content-Type: application/json");

$conn = new mysqli("127.0.0.1", "root", "Pass123", "hosteldb");

if ($conn->connect_error) {
    die(json_encode(["error" => "Connection failed: " . $conn->connect_error]));
}

$wardenID = $_POST['WardenID'];
$name = $_POST['Name'];
$contact = $_POST['WContactNo'];

$sql = "
    UPDATE Warden 
    SET Name = ?, WContactNo = ?
    WHERE WardenID = ?
";

$stmt = $conn->prepare($sql);
$stmt->bind_param("ssi", $name, $contact, $wardenID);

if ($stmt->execute()) {
    echo json_encode(["success" => true, "message" => "Warden updated successfully"]);
} else {
    echo json_encode(["success" => false, "message" => "Update failed"]);
}

$stmt->close();
$conn->close();
?>
