import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'hostel_model.dart';
import 'hostel_rooms.dart';
import 'constants.dart'; // for buildDrawer()

class ScreenHostelLisst extends StatefulWidget {
  const ScreenHostelLisst({super.key});

  @override
  State<ScreenHostelLisst> createState() => _ScreenHostelLisstState();
}

class _ScreenHostelLisstState extends State<ScreenHostelLisst> {
  List<Hostel> hostels = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchHostels();
  }

  Future<void> fetchHostels() async {
    final String host = Platform.isAndroid ? 'http://10.0.2.2' : 'http://localhost';
    final Uri url = Uri.parse('$host/hosteldb_api/hostelview.php');

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          hostels = data.map((e) => Hostel(
            id: int.parse(e['HostelID'].toString()),
            name: e['HostelName'] ?? 'Unknown',
            warden: e['WardenID'].toString(),
            roomsOccupied: e['RoomOccupied'].toString(),
            totalRooms: e['TotalRooms'].toString(),
          )).toList();
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load hostels. Server responded with status code ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching hostels: $e';
      });
    } finally {
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
        title: const Text("Hostel List",
            style: TextStyle(color: Color(0xff9AA6B2),fontWeight: FontWeight.bold, fontSize: 25)),
        centerTitle: true,
      ),
      drawer: buildDrawer(context),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.blue,
      body: Container(
        decoration: const BoxDecoration(
         color: Color(0xffF8FAFC),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 80),
              
              Row(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  TableCellWidget(
                      child: Text("Hostel ID",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      flex: 2),
                  TableCellWidget(
                      child: Text("Hostel Name",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      flex: 3),
                  TableCellWidget(
                      child:
                      Text("Warden ID", style: TextStyle(fontWeight: FontWeight.bold)),
                      flex: 3),
                  TableCellWidget(
                      child: Text("Occupied",style: TextStyle(fontWeight: FontWeight.bold),
                         ),
                      flex: 3),
                  TableCellWidget(
                      child: Text("Total",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      flex: 3),
                  TableCellWidget(
                      child: Text("Rooms",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      flex: 2),
                ],
              ),
              if (isLoading)
                const Expanded(
                  child: Center(child: CircularProgressIndicator(color: Colors.white)),
                )
              else if (errorMessage != null)
                Expanded(
                  child: Center(
                    child: Text(errorMessage!,
                        style: const TextStyle(color: Colors.white)),
                  ),
                )
              else
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: fetchHostels,
                    child: ListView.builder(
                      itemCount: hostels.length,
                      itemBuilder: (context, index) {
                        final h = hostels[index];
                        return HostelDetail(
                          HostelID: h.id,
                          HostelName: h.name,
                          WardenName: h.warden,
                          RoomsOccupied: h.roomsOccupied,
                          TotalRooms: h.totalRooms,
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class HostelDetail extends StatelessWidget {
  final int HostelID;
  final String HostelName;
  final String WardenName;
  final String RoomsOccupied;
  final String TotalRooms;

  const HostelDetail({
    Key? key,
    required this.HostelID,
    required this.HostelName,
    required this.WardenName,
    required this.RoomsOccupied,
    required this.TotalRooms,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        spacing: 5,
        children: [
          TableCellWidget(
              child: Text(HostelID.toString(), style: TextStyle(fontWeight:FontWeight.bold)),
              flex: 2),
          TableCellWidget(
              child: Text(HostelName, style: TextStyle(fontWeight:FontWeight.bold)),
              flex: 3),
          TableCellWidget(
              child: Text(WardenName, style: TextStyle(fontWeight:FontWeight.bold)),
              flex: 3),
          TableCellWidget(
              child: Text(RoomsOccupied, style: TextStyle(fontWeight:FontWeight.bold)),
              flex: 3),
          TableCellWidget(
              child: Text(TotalRooms, style: TextStyle(fontWeight:FontWeight.bold)),
              flex: 3),
          Expanded(
            flex: 2,
            child: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => HostelRooms(
                      hostelID: HostelID,
                      hostelName: HostelName,
                    )));
              },
              icon: const Icon(Icons.door_back_door_outlined,
                  color: Color(0xff9AA6B2), size: 25),
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

  const TableCellWidget({
    Key? key,
    required this.child,
    this.flex = 1,
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
          border: Border.all(color: Colors.black),
        ),
        child: child,
      ),
    );
  }
}
