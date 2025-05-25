import 'dart:convert';
import 'package:database_project/screen_students_in_room.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class HostelRooms extends StatefulWidget {
  final String hostelName;
  final int hostelID;

  const HostelRooms({
    required this.hostelName,
    required this.hostelID,
    Key? key,
  }) : super(key: key);

  @override
  State<HostelRooms> createState() => _HostelRoomsState();
}

class _HostelRoomsState extends State<HostelRooms> {
  List<dynamic> rooms = [];
  String wardenName = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRoomsAndWarden();
  }

  Future<void> fetchRoomsAndWarden() async {
    final String host = Platform.isAndroid ? 'http://10.0.2.2' : 'http://localhost';
    final Uri url = Uri.parse('$host/hosteldb_api/hostelrooms.php?hostelID=${widget.hostelID}');

    try {
      final response = await http.get(url);
      final data = jsonDecode(response.body);

      if (data['success']) {
        setState(() {
          rooms = data['rooms'];
          wardenName = data['wardenName'];
          isLoading = false;
        });
      } else {
        throw Exception(data['message']);
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Failed to fetch data: $e')),
      );
    }
  }

  Widget buildRoomTile(String roomID, int occupiedCount) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          roomID.toUpperCase(),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "Occupied: $occupiedCount/2",
          style: const TextStyle(color: Colors.white70),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_)=> ScreenStudentsInRoom(roomID: roomID)));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          children: [
            Text("${widget.hostelName} Hostel", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
            Text("Warden: $wardenName", style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white)),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xff9AA6B2)
        ),
        padding: const EdgeInsets.only(top: 80, left: 16, right: 16, bottom: 16),
        child: isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.white))
            : rooms.isEmpty
            ? const Center(
          child: Text("No rooms found", style: TextStyle(color: Colors.white)),
        )
            : ListView.builder(
          itemCount: rooms.length,
          itemBuilder: (context, index) {
            final room = rooms[index];
            final roomID = room['RoomID'] ?? 'Unknown';
            final occupied = int.tryParse(room['OccupiedCount'].toString()) ?? 0;
            return buildRoomTile(roomID, occupied);
          },
        ),
      ),
    );
  }
}
