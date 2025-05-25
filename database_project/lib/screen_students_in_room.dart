import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScreenStudentsInRoom extends StatefulWidget {
  final String roomID;
  const ScreenStudentsInRoom({required this.roomID, super.key});

  @override
  State<ScreenStudentsInRoom> createState() => _ScreenStudentsInRoomState();
}

class _ScreenStudentsInRoomState extends State<ScreenStudentsInRoom> {
  List<dynamic> students = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    final url = Uri.parse(
        'http://localhost/hosteldb_api/students_in_room.php?roomID=${widget.roomID}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          students = data is List ? data : [data];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load students');
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Room Number: ${widget.roomID}",
            style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
         color: Color(0xff9AA6B2),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : students.isEmpty
              ? const Center(
              child: Text("No students found.",
                  style: TextStyle(color: Colors.white)))
              : Column(
            children: students.map((student) {
              return StudentDetails(
                name: student['StudentName'] ?? 'N/A',
                studentID: student['StudentID'] ?? 0,
                contact: student['SContactNo'] ?? 'N/A',
                fName: student['FatherName'] ?? 'N/A',
                feeStatus: student['FeeStatus'] ?? 'Unknown',
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class StudentDetails extends StatelessWidget {
  final String name;
  final int studentID;
  final String contact;
  final String fName;
  final String feeStatus;

  const StudentDetails({
    required this.name,
    required this.studentID,
    required this.contact,
    required this.fName,
    required this.feeStatus,
    super.key,
  });

  Color getFeeStatusColor() {
    switch (feeStatus.toLowerCase()) {
      case 'paid':
        return Colors.green;
      case 'pending':
        return Colors.yellow;
      case 'unpaid':
        return Colors.red;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: $name",
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            Text("Student ID: $studentID",
                style: const TextStyle(fontSize: 17, color: Colors.white)),
            Text("Contact: $contact",
                style: const TextStyle(fontSize: 17, color: Colors.white)),

            const SizedBox(height: 16),
            Row(
              children: [
                const Text("Fee: ",
                    style: TextStyle(fontSize: 17, color: Colors.white)),
                Text(feeStatus,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: getFeeStatusColor())),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
