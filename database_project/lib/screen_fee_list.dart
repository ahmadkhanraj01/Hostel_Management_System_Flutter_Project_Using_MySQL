import 'package:database_project/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScreenFeeList extends StatefulWidget {
  const ScreenFeeList({super.key});

  @override
  State<ScreenFeeList> createState() => _ScreenFeeListState();
}

class _ScreenFeeListState extends State<ScreenFeeList> {
  List<dynamic> feeList = [];
  String selectedFilter = 'All';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchFeeList();
  }

  Future<void> fetchFeeList() async {
    setState(() => isLoading = true);
    String url = 'http://localhost/hosteldb_api/get_fee_list.php';
    if (selectedFilter != 'All') {
      url += '?status=$selectedFilter';
    }

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          feeList = jsonDecode(response.body);
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error: $e");
      setState(() => isLoading = false);
    }
  }

  Future<void> updateFeeStatus(int feeID, String newStatus) async {
    final url = Uri.parse('http://localhost/hosteldb_api/update_fee_status.php');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"feeID": feeID, "status": newStatus}),
      );

      final result = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(result['message']),
        backgroundColor: result['success'] ? Colors.green : Colors.red,
      ));
    } catch (e) {
      print("Update error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fee List',style: TextStyle(fontWeight: FontWeight.bold),),
      centerTitle: true),
      drawer: buildDrawer(context),
      body: Container(
        color: Color(0xff9AA6B2),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedFilter,
              items: ['All', 'Paid', 'Unpaid', 'Pending']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedFilter = val!;
                  fetchFeeList();
                });
              },
            ),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: feeList.length,
                itemBuilder: (context, index) {
                  var student = feeList[index];
                  String currentStatus = student['Status'];
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      title: Text("${student['StudentName']} (ID: ${student['StudentID']})"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Fee ID: ${student['FeeID']}"),
                          Text("Amount: Rs. ${student['Amount']}"),
                          DropdownButton<String>(
                            value: currentStatus,
                            items: ['Paid', 'Unpaid', 'Pending']
                                .map((status) => DropdownMenuItem(
                                value: status, child: Text(status)))
                                .toList(),
                            onChanged: (val) {
                              setState(() => feeList[index]['Status'] = val);
                            },
                          ),
                        ],
                      ),
                      trailing: ElevatedButton(
                        child: const Text('Save'),
                        onPressed: () {
                          updateFeeStatus(student['FeeID'], student['Status']);
                        },
                      ),
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
