import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScreenEditStudent extends StatefulWidget {
  final String studentID;

  const ScreenEditStudent({super.key, required this.studentID});

  @override
  State<ScreenEditStudent> createState() => _ScreenEditStudentState();
}

class _ScreenEditStudentState extends State<ScreenEditStudent> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  String feeStatus = "Paid";

  bool isLoading = true;

  Future<void> fetchStudentData() async {
    try {
      final response = await http.get(Uri.parse(
          'http://localhost/hosteldb_api/get_student_by_id.php?studentID=${widget.studentID}'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          nameController.text = data['StudentName'] ?? '';
          contactController.text = data['SContactNo'] ?? '';
          genderController.text = data['Gender'] ?? '';
          feeStatus = data['FeeStatus'] ?? 'Paid';
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load student data");
      }
    } catch (e) {
      print("❌ Error fetching student data: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to fetch student data."),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> updateStudentData() async {
    final response = await http.post(
      Uri.parse('http://localhost/hosteldb_api/update_student.php'),
      body: {
        'studentID': widget.studentID,
        'StudentName': nameController.text,
        'SContactNo': contactController.text,
        'Gender': genderController.text,
        'FeeStatus': feeStatus,
      },
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(result['message']),
        backgroundColor: Colors.green,
      ));
      Navigator.pop(context);
    } else {
      print("❌ Failed to update student: ${response.body}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to update student."),
        backgroundColor: Colors.red,
      ));
    }
  }
  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Student"),
        content: const Text("Are you sure you want to delete this student?"),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.pop(context); // Close dialog
              deleteStudent();
            },
          ),
        ],
      ),
    );
  }

  Future<void> deleteStudent() async {
    final uri = Uri.parse('http://localhost/hosteldb_api/delete_student.php?studentID=${widget.studentID}');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(result['message']),
        backgroundColor: result['success'] == true ? Colors.green : Colors.red,
      ));
      if (result['success'] == true) {
        Navigator.pop(context); // Go back after deletion
      }
    } else {
      print("❌ Failed to delete student: ${response.body}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to delete student."),
        backgroundColor: Colors.red,
      ));
    }
  }


  @override
  void initState() {
    super.initState();
    fetchStudentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        title: const Text("Edit Student",style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Color(0xff9AA6B2),
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    "Update Student Information",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff9AA6B2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Student Name",
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) =>
                    value!.isEmpty ? "Enter name" : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: contactController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: "Contact Number",
                      prefixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) =>
                    value!.isEmpty ? "Enter contact number" : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: genderController,
                    decoration: InputDecoration(
                      labelText: "Gender",
                      prefixIcon: const Icon(Icons.wc),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) =>
                    value!.isEmpty ? "Enter gender" : null,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: feeStatus,
                    decoration: InputDecoration(
                      labelText: "Fee Status",
                      prefixIcon: const Icon(Icons.payment),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: ['Paid', 'Unpaid', 'Pending']
                        .map((status) => DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    ))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => feeStatus = value!),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: const Text("Save Changes"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff9AA6B2),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        updateStudentData();
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    label: const Text(
                      "Delete Student",
                      style: TextStyle(color: Colors.red),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => _confirmDelete(),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
