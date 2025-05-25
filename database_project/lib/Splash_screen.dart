import 'package:database_project/screen_hostel_list.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              ScreenHostelLisst(),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Color(0xff62cff4),
            Color(0xff2c67f2),
          ],
        )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Database Project",
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
              Text(
                "Semester: 4th",
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
              Text(
                "CS & IT Department",
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
              Container(
                  height: 200,
                  width: 200,
                  child: Image(image: AssetImage("assets/UETLOGO.png"))),
              Text(
                "Group Members:",
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
              Text(
                "Muhammad Ahmad Khan 23jzbcs0238",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              Text(
                "Faizanullah Wazir 23jzbcs0242",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              Text(
                "Aleena Khan 23jzbcs0229",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
