import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

double degreesToRadians(double degrees) {
  return degrees * (pi / 180);
}

double getDistanceInKm(double lat1, double lon1, double lat2, double lon2) {
  var earthRadiusKm = 6371; // Radius of the Earth in kilometers

  var dLat = degreesToRadians(lat2 - lat1);
  var dLon = degreesToRadians(lon2 - lon1);

  lat1 = degreesToRadians(lat1);
  lat2 = degreesToRadians(lat2);

  var a = sin(dLat / 2) * sin(dLat / 2) +
      sin(dLon / 2) * sin(dLon / 2) * cos(lat1) * cos(lat2);
  var c = 2 * atan2(sqrt(a), sqrt(1 - a));
  var distance = earthRadiusKm * c;

  return distance;
}

bool isWithinRadius(
    double userLat, double userLon, double officeLat, double officeLon, double radiusInKm) {
  double distance = getDistanceInKm(userLat, userLon, officeLat, officeLon);
  return distance <= radiusInKm;
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw Exception('Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted, and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

void checkLocationAndVerify(BuildContext context) async {
  try {
    Position userPosition = await determinePosition();

    double userLat = userPosition.latitude;
    double userLon = userPosition.longitude;

    double officeLat =  20.24795536386714;
    double officeLon = 85.84211789305134;



    double radiusInKm = 0.1; // 100 meters in kilometers

    bool withinRadius = isWithinRadius(userLat, userLon, officeLat, officeLon, radiusInKm);
print(userLat.toString()+"user lat");
print(userLon.toString()+"user lon");

    if (withinRadius) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Location Verification'),
            content: Text('User is within the 100-meter radius of the office.'),
            actions: <Widget>[
              TextButton(

                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Location Verification'),
            content: Text('User is not within the 100-meter radius of the office.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  } catch (e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Verification Error'),
          content: Text(e.toString()),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                checkLocationAndVerify(context);
              },
              child: Text('Verify Location'),
            ),
          ],
        ),
      ),
    );
  }
}
