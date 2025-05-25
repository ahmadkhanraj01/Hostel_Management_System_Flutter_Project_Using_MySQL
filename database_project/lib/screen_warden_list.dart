import 'package:database_project/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScreenWardenList extends StatefulWidget {
  const ScreenWardenList({super.key});

  @override
  State<ScreenWardenList> createState() => _ScreenWardenListState();
}

class _ScreenWardenListState extends State<ScreenWardenList> {
  List<Map<String, dynamic>> wardens = [];
  List<bool> isEditing = [];

  @override
  void initState() {
    super.initState();
    fetchWardens();
  }

  Future<void> fetchWardens() async {
    try {
      final response = await http.get(Uri.parse("http://localhost/hosteldb_api/get_wardens.php"));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          wardens = List<Map<String, dynamic>>.from(data);
          isEditing = List<bool>.filled(wardens.length, false);
        });
      } else {
        throw Exception("Failed to load wardens");
      }
    } catch (e) {
      print("❌ Error: $e");
    }
  }

  Future<void> updateWarden(int index) async {
    final warden = wardens[index];
    final response = await http.post(
      Uri.parse("http://localhost/hosteldb_api/update_warden.php"),
      body: {
        "WardenID": warden["WardenID"].toString(),
        "Name": warden["WardenName"],
        "WContactNo": warden["WContactNo"],
      },
    );

    final result = json.decode(response.body);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(result["message"]),
      backgroundColor: result["success"] ? Colors.green : Colors.red,
    ));

    if (result["success"]) {
      setState(() {
        isEditing[index] = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Warden List"),
        centerTitle: true,
        backgroundColor: const Color(0xff9AA6B2),
      ),
      drawer: buildDrawer(context),
      body: Container(
        color: Color(0xff9AA6B2),
        child: ListView.builder(
          itemCount: wardens.length,
          padding: const EdgeInsets.all(12),
          itemBuilder: (context, index) {
            final warden = wardens[index];

            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      warden['HostelName'],
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    isEditing[index]
                        ? Column(
                      children: [
                        TextFormField(
                          initialValue: warden["WardenName"],
                          decoration: const InputDecoration(labelText: "Warden Name"),
                          onChanged: (val) => wardens[index]["WardenName"] = val,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          initialValue: warden["WContactNo"],
                          decoration: const InputDecoration(labelText: "Contact No"),
                          onChanged: (val) => wardens[index]["WContactNo"] = val,
                        ),
                      ],
                    )
                        : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${warden['WardenID']}. ${warden['WardenName']}"),
                        Text("Contact: ${warden['WContactNo']}"),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        isEditing[index]
                            ? ElevatedButton(
                          onPressed: () => updateWarden(index),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          child: const Text("Save"),
                        )
                            : IconButton(
                          onPressed: () => setState(() => isEditing[index] = true),
                          icon: const Icon(Icons.edit, color: Colors.blue),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
