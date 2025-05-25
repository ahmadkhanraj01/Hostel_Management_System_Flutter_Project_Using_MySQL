import 'package:flutter/material.dart';

class ScreenUpdateDelete extends StatefulWidget {
  final int roomNo;
  final String studentName;
  final String rollNo;
  final String department;
  final int seater;

  const ScreenUpdateDelete({
    Key? key,
    required this.roomNo,
    required this.studentName,
    required this.rollNo,
    required this.department,
    required this.seater,
  }) : super(key: key);

  @override
  State<ScreenUpdateDelete> createState() => _ScreenUpdateDeleteState();
}

class _ScreenUpdateDeleteState extends State<ScreenUpdateDelete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update/Delete"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 10,
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              initialValue: widget.roomNo.toString(),
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelText: "Room No",
                hintText: "Enter Room No",
              ),
            ),
            TextFormField(
              initialValue: widget.studentName,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelText: "Student Name",
                hintText: "Enter Student Name",
              ),
            ),
            TextFormField(
              initialValue: widget.rollNo,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelText: "Roll No",
                hintText: "Enter Roll No",
              ),
            ),
            TextFormField(
              initialValue: widget.department,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelText: "Department",
                hintText: "Enter Department",
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              initialValue: widget.seater.toString(),
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelText: "Seater",
                hintText: "Enter Seater",
              ),
            ),
            TextButton(onPressed: () {}, child: Text("Update")),
            TextButton(onPressed: () {}, child: Text("Delete")),
          ],
        ),
      ),
    );
  }
}
