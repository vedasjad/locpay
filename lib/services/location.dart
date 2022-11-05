import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class Location {
  double latitude = 0.0;
  double longitude = 0.0;

  Future<void> getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    try {
      if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.bestForNavigation);
        latitude = position.latitude;
        longitude = position.longitude;
        debugPrint(latitude.toString());
        debugPrint(longitude.toString());
      } else {
        Map<Permission, PermissionStatus> status = await [
          Permission.location,
        ].request();
      }
      if (await Permission.location.isPermanentlyDenied) {
        openAppSettings();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

// keytool -list -v -keystore "C:\Users\91962\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android
