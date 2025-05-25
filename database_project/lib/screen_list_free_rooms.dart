import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:database_project/screen_add_student_record.dart';

class ScreenListFreeRooms extends StatefulWidget {
  const ScreenListFreeRooms({super.key});

  @override
  State<ScreenListFreeRooms> createState() => _ScreenListFreeRoomsState();
}

class _ScreenListFreeRoomsState extends State<ScreenListFreeRooms> {
  List<dynamic> freeRooms = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFreeRooms();
  }

  Future<void> fetchFreeRooms() async {
    final String host =
    Platform.isAndroid ? 'http://10.0.2.2' : 'http://localhost';
    final Uri url = Uri.parse('$host/hosteldb_api/listfreerooms.php');

    try {
      final response = await http.get(url);
      final data = jsonDecode(response.body);

      if (data['success'] == true) {
        setState(() {
          freeRooms = data['data'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching rooms: $e");
      setState(() {
        isLoading = false;
      });
    }
  }
  Color getBorderColor(String roomID) {
    String prefix = roomID.substring(0, 2).toLowerCase();
    if (prefix == 'ah' || prefix == 'al') {
      return Colors.blue;
    } else if (prefix == 'ay') {
      return Colors.pinkAccent;
    } else {
      return Colors.grey;
    }
  }
  String getHostelName(String roomID) {
    String prefix = roomID.substring(0, 2).toLowerCase();
    if (prefix == 'ah') return 'Ahmad Hostel';
    if (prefix == 'al') return 'Ali Hostel';
    if (prefix == 'ay') return 'Ayesha Hostel';
    return 'Unknown Hostel';
  }
  Widget buildRoomTile(String roomID, int OccupiedCount) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: getBorderColor(roomID), width: 2),
        borderRadius: BorderRadius.circular(12),
          color: Color(0xff9AA6B2),
      ),
      child: ListTile(

        title: Text(
          roomID.toUpperCase(),
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "${getHostelName(roomID)}\nOccupied: $OccupiedCount / 2",
          style: const TextStyle(color: Colors.black),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ScreenAddStudentRecord(roomID: roomID),
            ),
          );
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffF8FAFC)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text("List of Free Rooms",style: TextStyle(fontWeight: FontWeight.bold),),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : freeRooms.isEmpty
              ? const Center(child: Text("No free rooms found", style: TextStyle(color: Colors.white)))
              : ListView.builder(
            itemCount: freeRooms.length,
            itemBuilder: (context, index) {
              final room = freeRooms[index];
              return buildRoomTile(room['RoomID'], int.parse(room['OccupiedCount']));
            },
          ),
        ),
      ),
    );
  }
}
