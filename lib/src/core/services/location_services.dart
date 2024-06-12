import 'dart:math';

import 'package:geolocator/geolocator.dart';

class LocationServices {
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  static double? latitude;
  static double? longitude;
  static Future determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions');
    }
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) {
      latitude = value.latitude;
      longitude = value.longitude;
    });
  }

  static double calculateDistance(
    double lat,
    double lon,
  ) {
    const R = 6371.0; // Earth's radius in kilometers
    const pi = 3.1415926535897932;

    // Convert latitude and longitude from degrees to radians
    double lat1Rad = radians(lat);
    double lon1Rad = radians(lon);
    double lat2Rad = radians(latitude!);
    double lon2Rad = radians(longitude!);

    // Difference in latitude and longitude
    double dLat = lat2Rad - lat1Rad;
    double dLon = lon2Rad - lon1Rad;

    // Haversine formula
    double a = pow(sin(dLat / 2), 2) + cos(lat1Rad) * cos(lat2Rad) * pow(sin(dLon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = R * c; // Distance in kilometers

    return distance;
  }

  static double radians(double degrees) {
    return degrees * (pi / 180);
  }
}
