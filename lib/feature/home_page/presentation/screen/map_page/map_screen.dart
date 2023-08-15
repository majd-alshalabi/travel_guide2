import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreen createState() => _MapScreen();
}

class _MapScreen extends State<MapScreen> {
  GoogleMapController? mapController;

  CameraPosition _initialCameraPosition =
      CameraPosition(target: const LatLng(33.510414, 36.278336), zoom: 12);
  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: onMapCreated,
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
          new Factory<OneSequenceGestureRecognizer>(
            () => new EagerGestureRecognizer(),
          ),
        ].toSet(),
        mapToolbarEnabled: false,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: false,
        scrollGesturesEnabled: true,
        myLocationButtonEnabled: true,
        initialCameraPosition: _initialCameraPosition,
      ),
    );
  }

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}
