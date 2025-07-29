import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationService {
  static final Location _location = Location();

  static Future<String?> fetchCurrentCityState() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedLocation = prefs.getString('location');

    if (cachedLocation != null && cachedLocation.isNotEmpty) {
      return cachedLocation;
    }

    if (!await _location.serviceEnabled()) {
      if (!await _location.requestService()) return null;
    }

    PermissionStatus permission = await _location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await _location.requestPermission();
      if (permission != PermissionStatus.granted) return null;
    }

    final locationData = await _location.getLocation();

    if (locationData.latitude != null && locationData.longitude != null) {
      final latLng = LatLng(locationData.latitude!, locationData.longitude!);

      final getCity = await getCityStateFromLatLng(latLng);

      if (getCity != null && getCity.isNotEmpty) {
        await prefs.setString('location', getCity);
      }

      return getCity;
    }

    return null;
  }
}

Future<String?> getCityStateFromLatLng(LatLng position) async {
  final url = Uri.parse(
    'https://nominatim.openstreetmap.org/reverse?format=json&lat=${position.latitude}&lon=${position.longitude}&addressdetails=1&accept-language=ar',
  );

  final response = await http.get(
    url,
    headers: {'User-Agent': 'FlutterApp (your@email.com)'},
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final address = data['address'];

    final city = address['city'] ?? address['town'] ?? address['village'] ?? '';
    final state = address['state'] ?? '';

    if (city.isNotEmpty && state.isNotEmpty) {
      return '$city, $state';
    } else if (city.isNotEmpty) {
      return city;
    } else if (state.isNotEmpty) {
      return state;
    }
  }

  return null;
}
