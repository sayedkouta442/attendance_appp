import 'package:attendance_appp/features/record_attendance/data/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

Marker officeMarker() {
  return Marker(
    point: LocationService().officeLocation, // Example: Tanta location
    width: 150,
    height: 80,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'DevCode Office',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        const Icon(Icons.location_pin, color: Colors.red, size: 36),
      ],
    ),
  );
}
