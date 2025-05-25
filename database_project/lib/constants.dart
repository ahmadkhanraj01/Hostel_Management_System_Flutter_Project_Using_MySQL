import 'package:database_project/screen_analysis.dart';
import 'package:database_project/screen_fee_list.dart';
import 'package:database_project/screen_hostel_list.dart';
import 'package:database_project/screen_search_student.dart';
import 'package:database_project/screen_studentList.dart';
import 'package:database_project/screen_warden_list.dart';
import 'package:flutter/material.dart';

// A proper Navigation Drawer
Drawer buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Color(0xff9AA6B2),
          ),
          child: Text(
            'Navigation Menu',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.person_outlined, color: Color(0xff9AA6B2)),
          title: Text('Student List'),
          onTap: () {
            Navigator.pop(context); // Close the drawer
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScreenStudentList()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.search_outlined, color: Color(0xff9AA6B2)),
          title: Text('Search'),
          onTap: () {
            Navigator.pop(context); // Close the drawer
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScreenSearchStudent()),
            );
          },
        ),

        ListTile(
          leading: Icon(Icons.home_outlined, color: Color(0xff9AA6B2)),
          title: Text('Hostel List'),
          onTap: () {
            Navigator.pop(context); // Close the drawer
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScreenHostelLisst()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.attach_money_outlined, color: Color(0xff9AA6B2)),
          title: Text('Fee'),
          onTap: () {
            Navigator.pop(context); // Close the drawer
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScreenFeeList()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.pie_chart_outline, color: Color(0xff9AA6B2)),
          title: Text('Analysis'),
          onTap: () {
            Navigator.pop(context); // Close the drawer
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScreenAnalysis()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.supervisor_account_outlined, color: Color(0xff9AA6B2)),
          title: Text('Wardens'),
          onTap: () {
            Navigator.pop(context); // Close the drawer
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScreenWardenList()),
            );
          },
        ),

      ],
    ),
  );
}
