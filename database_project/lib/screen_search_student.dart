import 'dart:convert';
import 'package:database_project/constants.dart';
import 'package:database_project/screen_edit_student.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ScreenSearchStudent extends StatefulWidget {
  const ScreenSearchStudent({super.key});

  @override
  State<ScreenSearchStudent> createState() => _ScreenSearchStudentState();
}

class _ScreenSearchStudentState extends State<ScreenSearchStudent> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> students = [];
  bool isLoading = false;

  Future<void> fetchStudents(String query) async {
    if (query.isEmpty) {
      setState(() {
        students = [];
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse("http://localhost/hosteldb_api/search_student.php?name=$query"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          students = data.cast<Map<String, dynamic>>();
        });
      } else {
        print("Server error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching students: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      fetchStudents(_searchController.text.trim());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search Student",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: buildDrawer(context),
      extendBodyBehindAppBar: true,
      body: Container(
        color: const Color(0xff9AA6B2),
        padding: const EdgeInsets.only(top: 80, left: 16, right: 16),
        child: Column(
          children: [
            TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Search by Student Name",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : Expanded(
              child: students.isEmpty
                  ? const Center(child: Text("No students found."))
                  : ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>ScreenEditStudent(studentID: student['student_id'])));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Go to on ${student['name']}"),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        child: Text(student['student_id'].toString(),style: TextStyle(color: Colors.white),),
                        backgroundColor: Color(0xff9AA6B2),
                      ),
                      title: Text(student['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Room ID: ${student['room_id']}"),
                          Text("Fee Status: ${student['fee_status']}"),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
