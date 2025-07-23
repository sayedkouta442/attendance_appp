import 'package:attendance_appp/features/record_attendance/data/services/location_service.dart';
import 'package:attendance_appp/features/record_attendance/presentation/views/widgets/office_marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({super.key, required MapController mapController})
    : _mapController =
          mapController; //_currentLocation = currentLocation, _route = route;

  final MapController _mapController;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: LocationService().officeLocation, // Office Location
        initialZoom: 13,
        minZoom: 3,
        maxZoom: 18,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.atto.attendance',
        ),
        const CurrentLocationLayer(
          style: LocationMarkerStyle(
            marker: DefaultLocationMarker(
              child: Icon(Icons.location_pin, color: Colors.white),
            ),
            markerSize: Size(35, 35),
            markerDirection: MarkerDirection.heading,
          ),
        ),
        MarkerLayer(markers: [officeMarker()]),
      ],
    );
  }
}






       // if (_currentLocation != null && _route.isNotEmpty)
        //   PolylineLayer(
        //     polylines: [
        //       Polyline(points: _route, strokeWidth: 5, color: Colors.red),
        //     ],
        //   ),