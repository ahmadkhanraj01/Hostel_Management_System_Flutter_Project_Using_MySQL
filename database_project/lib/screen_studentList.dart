import 'dart:convert';
import 'package:database_project/screen_edit_student.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'student_model.dart';
import 'screen_list_free_rooms.dart';
import 'dart:io';
import 'constants.dart';

class ScreenStudentList extends StatefulWidget {
  const ScreenStudentList({super.key});

  @override
  State<ScreenStudentList> createState() => _ScreenStudentListState();
}

class _ScreenStudentListState extends State<ScreenStudentList> {
  List<Student> students = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  void fetchStudents() async {
    final String host =
    Platform.isAndroid ? 'http://10.0.2.2' : 'http://localhost';
    final Uri url = Uri.parse('$host/hosteldb_api/studentview.php');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          students = data.map((json) => Student.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load students');
      }
    } catch (e) {
      print("❌ Error: $e");
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
        title: const Text("Student List", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      drawer: buildDrawer(context),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.blue,
      floatingActionButton: FloatingActionButton(
        hoverColor: Colors.green,

        backgroundColor: Color(0xff9AA6B2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const ScreenListFreeRooms()));
        },
        child: const Icon(Icons.person_add_alt_1_outlined, color: Colors.white, size: 45),
      ),
      body: Container(
        decoration: const BoxDecoration(
         color: Color(0xffF8FAFC)
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 50, bottom: 10, right: 10, left: 10),
          child: Column(
            children: [
              // Table header
              Row(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  TableCellWidget(child: Text("Student ID", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)), flex: 2),
                  TableCellWidget(child: Text("Student Name", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)), flex: 3),
                  TableCellWidget(child: Text("Room ID", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)), flex: 3),
                  TableCellWidget(child: Text("Contact", style:TextStyle(color: Colors.black,fontWeight: FontWeight.bold)), flex: 3),
                  TableCellWidget(child: Text("Gender", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)), flex: 1),
                  TableCellWidget(child: Text("Edit", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)), flex: 1),
                ],
              ),
              isLoading
                  ? const Expanded(child: Center(child: CircularProgressIndicator(color: Colors.white)))
                  : Expanded(
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    final s = students[index];
                    return StudentDetail(
                      studentID: s.id,
                      studentName: s.name,
                      roomID: s.roomId,
                      contact: s.contact,
                      gender: s.gender,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StudentDetail extends StatelessWidget {
  final String studentID;
  final String studentName;
  final String roomID;
  final String contact;
  final String gender;

  const StudentDetail({
    Key? key,
    required this.studentID,
    required this.studentName,
    required this.roomID,
    required this.contact,
    required this.gender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color genderColor;
    if (gender.toLowerCase() == 'male') {
      genderColor = Colors.blueAccent;
    } else if (gender.toLowerCase() == 'female') {
      genderColor = Colors.pinkAccent;
    } else {
      genderColor = Colors.white;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        spacing: 5,
        children: [
          TableCellWidget(
              child: Text(studentID, style: const TextStyle(color: Colors.black)),
              flex: 2,
              borderColor: genderColor),
          TableCellWidget(
              child: Text(studentName, style: const TextStyle(color: Colors.black)),
              flex: 3,
              borderColor: genderColor),
          TableCellWidget(
              child: Text(roomID, style: const TextStyle(color: Colors.black)),
              flex: 3,
              borderColor: genderColor),
          TableCellWidget(
              child: Text(contact, style: const TextStyle(color: Colors.black)),
              flex: 3,
              borderColor: genderColor),
          TableCellWidget(
              child: Text(gender, style: const TextStyle(color: Colors.black)),
              flex: 1,
              borderColor: genderColor),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)=>ScreenEditStudent(studentID: studentID,)));
              },
              icon: const Icon(Icons.mode_edit_outline_outlined, color: Color(0xff9AA6B2), size: 25),
            ),
          ),
        ],
      ),
    );
  }
}

class TableCellWidget extends StatelessWidget {
  final Widget child;
  final int flex;
  final Color borderColor;

  const TableCellWidget({
    Key? key,
    required this.child,
    this.flex = 1,
    this.borderColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xff9AA6B2),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: borderColor,width: 2),
        ),
        child: child,
      ),
    );
  }
}
