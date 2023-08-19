import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:travel_guide/feature/account/data/models/local/my_identity_model.dart';

class AppSettings {
  static final AppSettings _instance = AppSettings._internal();

  factory AppSettings() {
    return _instance;
  }
  AppSettings._internal();
  LatLng? currentLocation;
  MyIdentity? identity;
  String fcmToken = '';
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  StreamController controller = StreamController<LocationEvent>.broadcast();
  Future<LatLng?> getCurrentLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();
    currentLocation = LatLng(
      _locationData.latitude ?? 33.510414,
      _locationData.longitude ?? 36.278336,
    );
    controller.add(UpdateLatLong(currentLocation));
    return currentLocation;
  }
}

abstract class LocationEvent {}

class UpdateLatLong extends LocationEvent {
  final LatLng? latLng;

  UpdateLatLong(this.latLng);
}

class NearByLocationEvent extends LocationEvent {
  final List<LatLng>? list;

  NearByLocationEvent(this.list);
}
