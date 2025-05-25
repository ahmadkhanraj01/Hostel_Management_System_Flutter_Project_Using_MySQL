<?php
header('Content-Type: application/json');

// DB connection
$host = 'localhost';
$db   = 'hosteldb';
$user = 'root';
$pass = 'Pass123';
$charset = 'utf8mb4';

$dsn = "mysql:host=$host;dbname=$db;charset=$charset";
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
];

try {
    $pdo = new PDO($dsn, $user, $pass, $options);
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'message' => 'Database connection failed: ' . $e->getMessage()
    ]);
    exit;
}

// Get hostel ID
$hostelID = isset($_GET['hostelID']) ? intval($_GET['hostelID']) : 0;

if ($hostelID <= 0) {
    echo json_encode([
        'success' => false,
        'message' => 'Invalid or missing hostel ID.'
    ]);
    exit;
}

try {
    // Get warden name
    $stmt = $pdo->prepare("SELECT Name FROM warden WHERE HostelID = ?");
    $stmt->execute([$hostelID]);
    $warden = $stmt->fetch();
    $wardenName = $warden ? $warden['Name'] : 'Unknown';

    // Get rooms and student count
    $stmt = $pdo->prepare("
        SELECT r.RoomID, COUNT(s.StudentID) AS OccupiedCount
        FROM room r
        LEFT JOIN student s ON r.RoomID = s.RoomID
        WHERE r.HostelID = ?
        GROUP BY r.RoomID
        ORDER BY r.RoomID
    ");
    $stmt->execute([$hostelID]);
    $rooms = $stmt->fetchAll();

    echo json_encode([
        'success' => true,
        'wardenName' => $wardenName,
        'rooms' => $rooms
    ]);
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'message' => 'Query error: ' . $e->getMessage()
    ]);
}
?>
