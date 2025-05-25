<?php
header("Content-Type: application/json");

// DB connection
$conn = new mysqli("127.0.0.1", "root", "Pass123", "hosteldb");

if ($conn->connect_error) {
    die(json_encode(["error" => "Connection failed: " . $conn->connect_error]));
}

$sql = "
    SELECT 
        w.WardenID,
        w.Name AS WardenName,
        w.WContactNo,
        h.HostelName
    FROM 
        Warden w
    JOIN Hostel h ON w.HostelID = h.HostelID
";

$result = $conn->query($sql);
$wardens = [];

if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $wardens[] = $row;
    }
}

echo json_encode($wardens);
$conn->close();
?>
