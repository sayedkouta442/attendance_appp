import 'dart:async';

import 'package:attendance_appp/core/utils/routs.dart';
import 'package:attendance_appp/features/record_attendance/data/services/location_service.dart';
import 'package:attendance_appp/features/record_attendance/presentation/views/widgets/center_map.dart';
import 'package:attendance_appp/features/record_attendance/presentation/views/widgets/check_location_header.dart';
import 'package:attendance_appp/features/record_attendance/presentation/views/widgets/loading_office_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

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
  final LatLng officeLocation = const LatLng(30.7860, 31.0009);

  StreamSubscription<LocationData>? _locationSubscription;
  String? cityState;

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
            CheckLocationHeader(),
            SizedBox(height: 24),
            isLoading
                ? LoadingOfficeLocation()
                : CenterMap(mapController: _mapController),

            SizedBox(height: 30),

            // check location button
            CheckLocationButton(),
          ],
        ),
      ),
    );
  }
}

class CheckLocationButton extends StatelessWidget {
  const CheckLocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Color(0xff3662e1),
      ),
      onPressed: () async {
        final result = await LocationService().takeAttendance(context);

        if (result == true) {
          // ignore: use_build_context_synchronously
          GoRouter.of(context).push(AppRouter.kFaceIdView);
        }
      },
      child: const SizedBox(
        child: Text('Check Location', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
