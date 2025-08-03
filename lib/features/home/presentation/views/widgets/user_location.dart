import 'package:attendance_appp/features/home/data/services/location_service.dart';
import 'package:flutter/material.dart';

class UserLocation extends StatefulWidget {
  const UserLocation({super.key});

  @override
  State<UserLocation> createState() => _UserLocationState();
}

class _UserLocationState extends State<UserLocation> {
  String? userLocation;

  void location() async {
    if (userLocation != null) {
      return;
    }
    final currentLocation = await LocationService.fetchCurrentCityState();
    setState(() {
      userLocation = currentLocation;
    });
    print(userLocation);
  }

  @override
  void initState() {
    location();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text('Location', style: TextStyle(fontSize: 16, color: Colors.white)),
        SizedBox(height: 2),
        Text(
          userLocation.toString(),
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }
}
