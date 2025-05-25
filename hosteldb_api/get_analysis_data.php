<?php
header("Content-Type: application/json");
$host = "127.0.0.1";
$db = "hosteldb";
$user = "root";
$pass = "Pass123";

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    die(json_encode(["error" => "Connection failed: " . $conn->connect_error]));
}

// ---- Hostel Occupancy ----
$hostelOccupancy = [];
$hostelQuery = "SELECT h.HostelName, SUM(r.Capacity) as Capacity, SUM(r.OccupiedCount) as Occupied
                FROM Hostel h
                JOIN Room r ON h.HostelID = r.HostelID
                GROUP BY h.HostelID";
$hostelResult = $conn->query($hostelQuery);
while ($row = $hostelResult->fetch_assoc()) {
    $hostelOccupancy[] = [
        "hostelName" => $row['HostelName'],
        "capacity" => (int)$row['Capacity'],
        "occupied" => (int)$row['Occupied']
    ];
}

// ---- Fee Status ----
$feeStats = ["Paid" => 0, "Unpaid" => 0, "Pending" => 0];
$feeQuery = "SELECT Status, COUNT(*) as count FROM Fee GROUP BY Status";
$feeResult = $conn->query($feeQuery);
while ($row = $feeResult->fetch_assoc()) {
    $status = $row['Status'];
    $feeStats[$status] = (int)$row['count'];
}

echo json_encode([
    "hostelOccupancy" => $hostelOccupancy,
    "feeStatus" => $feeStats
]);
$conn->close();
?>
