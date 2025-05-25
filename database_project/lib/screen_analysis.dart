import 'dart:convert';
import 'package:database_project/constants.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;

class HostelOccupancy {
  final String hostelName;
  final int capacity;
  final int occupied;

  HostelOccupancy({
    required this.hostelName,
    required this.capacity,
    required this.occupied,
  });

  factory HostelOccupancy.fromJson(Map<String, dynamic> json) {
    return HostelOccupancy(
      hostelName: json['hostelName'],
      capacity: json['capacity'],
      occupied: json['occupied'],
    );
  }
}

class ScreenAnalysis extends StatefulWidget {
  const ScreenAnalysis({super.key});

  @override
  State<ScreenAnalysis> createState() => _ScreenAnalysisState();
}

class _ScreenAnalysisState extends State<ScreenAnalysis> {
  List<HostelOccupancy> hostelData = [];
  Map<String, int> feeData = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAnalysisData();
  }

  Future<void> fetchAnalysisData() async {
    final url = Uri.parse('http://localhost/hosteldb_api/get_analysis_data.php'); // Replace with actual path
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        setState(() {
          hostelData = (jsonData['hostelOccupancy'] as List)
              .map((item) => HostelOccupancy.fromJson(item))
              .toList();
          feeData = Map<String, int>.from(jsonData['feeStatus']);
          isLoading = false;
        });
      } else {
        print("Error: ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Analysis Screen",style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      drawer: buildDrawer(context),
      body: Container(
        color: Color(0xff9AA6B2),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Fee Chart",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                  height: 250,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 4,
                      centerSpaceRadius: 40,
                      sections: [
                        PieChartSectionData(
                          color: Colors.green,
                          value: (feeData['Paid'] ?? 0).toDouble(),
                          title: 'Paid',
                          radius: 60,
                          titleStyle:
                          const TextStyle(color: Colors.white),
                        ),
                        PieChartSectionData(
                          color: Colors.red,
                          value: (feeData['Unpaid'] ?? 0).toDouble(),
                          title: 'Unpaid',
                          radius: 60,
                          titleStyle:
                          const TextStyle(color: Colors.white),
                        ),
                        PieChartSectionData(
                          color: Colors.yellow,
                          value: (feeData['Pending'] ?? 0).toDouble(),
                          title: 'Pending',
                          radius: 60,
                          titleStyle:
                          const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  "Hostel Room Occupation",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                isLoading
                    ? const CircularProgressIndicator()
                    : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: hostelData.map((hostel) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: HostelPieChart(
                          hostelName: hostel.hostelName,
                          Capacity: hostel.capacity,
                          occupiedCount: hostel.occupied,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HostelPieChart extends StatelessWidget {
  final int occupiedCount;
  final int Capacity;
  final String hostelName;

  const HostelPieChart({
    required this.hostelName,
    required this.Capacity,
    required this.occupiedCount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isGirlsHostel =
    hostelName.toLowerCase().contains("ayesha"); // or other logic
    final Color occupiedColor =
    isGirlsHostel ? Colors.pinkAccent : Colors.blueAccent;

    return Container(
      width: 220,

      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
        borderRadius: BorderRadius.circular(16),
        color: Color(0xffF8FAFC),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            hostelName,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 180,
            child: PieChart(
              PieChartData(
                sectionsSpace: 4,
                centerSpaceRadius: 30,
                borderData: FlBorderData(show: false),
                sections: [
                  PieChartSectionData(
                    color: Colors.white,
                    value: (Capacity - occupiedCount).toDouble(),
                    title: 'Free: ${Capacity - occupiedCount}',
                    radius: 50,
                    titleStyle: const TextStyle(color: Colors.black),
                    borderSide:
                    const BorderSide(color: Colors.grey, width: 1),
                  ),
                  PieChartSectionData(
                    color: occupiedColor,
                    value: occupiedCount.toDouble(),
                    title: 'Occupied: $occupiedCount',
                    radius: 50,
                    titleStyle: const TextStyle(color: Colors.white),
                    borderSide:
                    const BorderSide(color: Colors.black12, width: 1),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
