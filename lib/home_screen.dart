// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'dart:math' as Math;
// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//   @override
//   State<Home> createState() => _HomeState();
// }
// class _HomeState extends State<Home> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//   }
//   Future<Position> determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//
//       return Future.error('Location services are disabled.');
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//
//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     return await Geolocator.getCurrentPosition();
//   }
//   double tolerance = 0.0001;
//   Future<void> checkin() async {
//     try {
//       Position p = await determinePosition();
//
//       double tolerance = 0.0001; // Define a tolerance for position matching
//
//       double distance = getDistanceFromLatLonInKm(
//           office_lat, office_long, user_lat, user_long);
//
//       if (distance < 0.50) {
//         print("Position match within 0.50 km");
//       } else {
//         print("Position does not match");
//         print("User's latitude: ${p.latitude}");
//         print("User's longitude: ${p.longitude}");
//         print("Office latitude: $office_lat");
//         print("Office longitude: $office_long");
//         print("Distance between user and office: $distance km");
//       }
//     } catch (e) {
//       print("Error: $e");
//       // Handle the error gracefully, e.g., by showing a message to the user.
//     }
//   }
//
//
//   double getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2) {
//     var R = 6371; // Radius of the earth in km
//     var dLat = deg2rad(lat2 - lat1); // deg2rad below
//     var dLon = deg2rad(lon2 - lon1);
//     var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
//         Math.cos(deg2rad(lat1)) *
//             Math.cos(deg2rad(lat2)) *
//             Math.sin(dLon / 2) *
//             Math.sin(dLon / 2);
//     var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
//     var d = R * c; // Distance in km
//     return d;
//   }
//   double deg2rad(deg) {
//     return deg * (Math.pi /180);
//   }
//   double user_lat = 20.2477527;  // User's correct latitude
//   double user_long = 85.8422003; // User's correct longitude
//   double office_lat = 85.8422841460243; // Office's correct latitude
//   double office_long = 20.248269528087697; // Office's correct longitude
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: ElevatedButton(
//               onPressed: () async {
//                await checkin();
//               },
//               child: Text("HII"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
