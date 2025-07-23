import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class LocationService {
  final Location _location = Location();
  final LatLng officeLocation = const LatLng(30.7860, 31.0009);

  fetchLatLng() async {
    final userLocation = await _location.getLocation();
    return LatLng(userLocation.latitude!, userLocation.longitude!);
  }

  Future<bool> takeAttendance(BuildContext context) async {
    final now = DateTime.now();
    final weekday = now.weekday;

    // Skip attendance on weekends
    if (weekday == DateTime.friday || weekday == DateTime.saturday) {
      _showMessage(context, "🚫 Attendance is not allowed on weekends.");
      return false;
    }

    final currentTime = TimeOfDay.fromDateTime(now);
    final currentMinutes = currentTime.hour * 60 + currentTime.minute;

    // Attendance window: 9:00 AM to 9:30 AM (540 to 570 minutes)
    const int attendanceStart = 0 * 60; // 540 minutes //9 *60
    const int attendanceEnd = 23 * 60 + 59; // 570 minutes // 9 * 60 + 30

    if (currentMinutes < attendanceStart) {
      _showMessage(context, "⏰ It's too early for attendance.");
      return false;
    }

    if (currentMinutes > attendanceEnd) {
      _showMessage(context, "⏰ Attendance time has ended.");
      return false;
    }

    // Location services check
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) serviceEnabled = await _location.requestService();

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return false;
    }

    final userLocation = await _location.getLocation();
    final userLatLng = LatLng(userLocation.latitude!, userLocation.longitude!);
    // fetchLatLng();

    final distance = const Distance().as(
      LengthUnit.Meter,
      officeLocation,
      userLatLng,
    );

    if (distance <= 10000000000000) {
      // 100 meters radius
      _showMessage(
        // ignore: use_build_context_synchronously
        context,
        "✅ Location verified! Proceeding to face verification.",
      );
      return true;
    } else {
      _showMessage(
        // ignore: use_build_context_synchronously
        context,
        "📍 You are too far from the office (${distance.toStringAsFixed(1)} m)",
      );
      return false;
    }
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }
}
