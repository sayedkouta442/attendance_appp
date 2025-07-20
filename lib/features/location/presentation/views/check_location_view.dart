import 'dart:async';

import 'package:attendance_appp/core/utils/routs.dart';
import 'package:attendance_appp/features/location/data/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:location/location.dart';

class CheckLocationView extends StatefulWidget {
  const CheckLocationView({super.key});

  @override
  State<CheckLocationView> createState() => _CheckLocationViewState();
}

class _CheckLocationViewState extends State<CheckLocationView> {
  final MapController _mapController = MapController();
  final Location _location = Location();
  bool isLoading = true;
  LatLng? _currentLocation;
  // final LatLng _tantaCollege = const LatLng(
  //   30.7925,
  //   31.0019,
  // ); // Fixed destination
  // LatLng? _destination;
  // List<LatLng> _route = [];
  StreamSubscription<LocationData>? _locationSubscription;
  String? cityState;
  bool isAttended = false;

  @override
  void initState() {
    super.initState();
    // _destination = _tantaCollege; // Set fixed destination
    _initializeLocation();
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }

  Future<void> _initializeLocation() async {
    if (!await _checkRequestPermession()) return;

    _locationSubscription = _location.onLocationChanged.listen((
      LocationData locationData,
    ) async {
      if (locationData.latitude != null && locationData.longitude != null) {
        setState(() {
          _currentLocation = LatLng(
            locationData.latitude!,
            locationData.longitude!,
          );
          isLoading = false;
        });

        if (_currentLocation != null) {
          //  cityState = await getCityStateFromLatLng(_currentLocation!);
          if (cityState != null) {
            print('Location: $cityState');
          }

          // await _fetchRoute();
        }
      }
    });
  }

  Future<bool> _checkRequestPermession() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return false;
    }
    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  // Future<void> _userCurrentLocation() async {
  //   if (_currentLocation != null) {
  //     _mapController.move(_currentLocation!, 15);
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Current location is not available.')),
  //     );
  //   }
  // }

  void errorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Check Location',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 24),
            Image.asset(
              'assets/images/location_sticker.gif',
              width: 120,
              height: 120,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Text(
                "Please confirm your current location",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "to check if you in office location or not.",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 24),
            isLoading
                ? LoadingOfficeLocation()
                : OfficeLocation(mapController: _mapController),

            SizedBox(height: 30),
            // check location button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Color(0xff3662e1),
              ),
              onPressed: () async {
                // Modified to navigate to FaceIDCheckInScreen if location and time check passes
                final result = await AttendanceService().takeAttendance(
                  context,
                );

                if (result == true) {
                  setState(() => isAttended = true);

                  // ignore: use_build_context_synchronously
                  GoRouter.of(context).push(AppRouter.kFaceIdView);
                }
              },
              child: const SizedBox(
                child: Text(
                  'Check Location',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   elevation: 0,
      //   onPressed: _userCurrentLocation,
      //   backgroundColor: Colors.blue,
      //   child: const Icon(Icons.my_location, size: 30, color: Colors.white),
      // ),
    );
  }
}

class OfficeLocation extends StatelessWidget {
  const OfficeLocation({super.key, required MapController mapController})
    : _mapController = mapController;

  final MapController _mapController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 400,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: MapWidget(mapController: _mapController),
          ),
        ),
      ),
    );
  }
}

class LoadingOfficeLocation extends StatelessWidget {
  const LoadingOfficeLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey,
          ),
          width: double.infinity,
          height: 400,

          child: const Center(
            child: Text(
              'Loading Office location...',
              style: TextStyle(color: Colors.white, fontSize: 18),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ),
      ),
    );
  }
}

class MapWidget extends StatelessWidget {
  const MapWidget({
    super.key,
    required MapController mapController,
    // required LatLng? currentLocation,
    // required List<LatLng> route,
  }) : _mapController =
           mapController; //_currentLocation = currentLocation, _route = route;

  final MapController _mapController;
  // final LatLng? _currentLocation;
  // final List<LatLng> _route;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: const MapOptions(
        initialCenter: LatLng(30.7860, 31.0009), // Egypt's center
        initialZoom: 13, // Good zoom to view Egypt clearly
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
        MarkerLayer(
          markers: [
            Marker(
              point: const LatLng(30.7860, 31.0009), // Example: Tanta location
              width: 150,
              height: 80,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
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
            ),
          ],
        ),
        // if (_currentLocation != null && _route.isNotEmpty)
        //   PolylineLayer(
        //     polylines: [
        //       Polyline(points: _route, strokeWidth: 5, color: Colors.red),
        //     ],
        //   ),
      ],
    );
  }
}
