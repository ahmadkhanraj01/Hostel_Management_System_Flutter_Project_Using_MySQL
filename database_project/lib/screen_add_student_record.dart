import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScreenAddStudentRecord extends StatefulWidget {
  final String roomID;
  const ScreenAddStudentRecord({required this.roomID, super.key});

  @override
  State<ScreenAddStudentRecord> createState() => _ScreenAddStudentRecordState();
}

class _ScreenAddStudentRecordState extends State<ScreenAddStudentRecord> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  bool isSubmitting = false;

  String hostelName(String roomID) {
    String prefix = roomID.substring(0, 2).toLowerCase();
    if (prefix == 'ah') return "Ahmad Hostel";
    if (prefix == 'al') return "Ali Hostel";
    if (prefix == 'ay') return "Ayesha Hostel";
    return "Unknown Hostel";
  }

  String gender(String roomID) {
    String prefix = roomID.substring(0, 2).toLowerCase();
    if (prefix == 'ah' || prefix == 'al') return "Male";
    if (prefix == 'ay') return "Female";
    return "Unknown";
  }

  Future<void> insertStudent() async {
    if (nameController.text.isEmpty || contactController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    final response = await http.post(
      Uri.parse("http://localhost/hosteldb_api/insertnewstudent.php"),
      body: {
        'roomID': widget.roomID,
        'studentName': nameController.text,
        'contactNo': contactController.text,
      },
    );

    final data = jsonDecode(response.body);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(data['message']),
        backgroundColor: data['success'] ? Colors.green : Colors.red,
      ),
    );

    if (data['success']) {
      Navigator.pop(context);
    }

    setState(() {
      isSubmitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Add Student Record",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xff9AA6B2)
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 80, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Room Number: ${widget.roomID}",
                  style: const TextStyle(fontSize: 18, color: Colors.white)),
              Text("Hostel Name : ${hostelName(widget.roomID)}",
                  style: const TextStyle(fontSize: 18, color: Colors.white)),
              const SizedBox(height: 20),
              _buildTextField("Student Name", "Enter Student Name",
                  controller: nameController),
              const SizedBox(height: 12),
              Text("Gender: ${gender(widget.roomID)}",
                  style: const TextStyle(fontSize: 18, color: Colors.white)),
              const SizedBox(height: 12),
              _buildTextField("Contact Number", "Enter Contact Number",
                  keyboardType: TextInputType.phone,
                  controller: contactController),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isSubmitting ? null : insertStudent,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xff9AA6B2),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  child: isSubmitting
                      ? const CircularProgressIndicator()
                      : const Text("Add Record", style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint,
      {required TextEditingController controller,
        TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
