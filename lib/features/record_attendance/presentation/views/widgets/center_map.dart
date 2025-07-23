import 'package:attendance_appp/features/record_attendance/presentation/views/widgets/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class CenterMap extends StatelessWidget {
  const CenterMap({super.key, required MapController mapController})
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
