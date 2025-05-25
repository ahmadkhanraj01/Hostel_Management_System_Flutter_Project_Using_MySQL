<?php
$servername = "localhost";
$username = "root";
$password = "Pass123";  // your MySQL password here
$dbname = "hosteldb";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
