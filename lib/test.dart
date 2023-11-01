import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    _checkLocation();
  }

  _checkLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );

    double targetLatitude = 85.84222365523986; // Replace with the target latitude
    double targetLongitude = 20.247816345821256; // Replace with the target longitude

    double currentLatitude = position.latitude;
    double currentLongitude = position.longitude;

    double tolerance = 0.0001; // Adjust this tolerance as needed

    if ((currentLatitude - targetLatitude).abs() < tolerance &&
        (currentLongitude - targetLongitude).abs() < tolerance) {
      // Navigator.of(context).push(MaterialPageRoute(
      //   builder: (context) => NewScreen(),
      // ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: Center(
        child: Text('This is the main screen.'),
      ),
    );
  }
}

