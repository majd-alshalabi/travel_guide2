import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_guide/core/services/app_settings/app_settings.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';
import 'package:travel_guide/feature/home_page/domain/use_cases/get_all_activity_use_case.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.gesture, required  Function(dynamic argument) onTap});

  @override
  _MapScreen createState() => _MapScreen();
  final bool gesture;
}

class _MapScreen extends State<MapScreen> {
  GoogleMapController? mapController;

  CameraPosition _initialCameraPosition = CameraPosition(
      target: LatLng(AppSettings().currentLocation?.latitude ?? 33.510414,
          AppSettings().currentLocation?.longitude ?? 36.278336),
      zoom: 12);
  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.gesture) {
      GetNearbyLocationUseCase().call(
        GetNearbyActivityParamsModel(
          longitude: AppSettings().currentLocation?.longitude,
          latitude: AppSettings().currentLocation?.latitude,
        ),
      );
    }
    AppSettings().controller.stream.listen((event) {
      if (event is UpdateLatLong) {
        if (event.latLng != null) {
          mapController?.animateCamera(CameraUpdate.newLatLng(event.latLng!));
        }
      }
    });
    AppSettings().controller.stream.listen((event) {
      int i = 0;
      if (event is NearByLocationEvent) {
        marker = event.list?.map((e) {
          return Marker(markerId: MarkerId((i++).toString()), position: e);
        }).toSet();
        setState(() {});
      }
    });
    super.initState();
  }

  Set<Marker>? marker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        zoomGesturesEnabled: widget.gesture,
        scrollGesturesEnabled: widget.gesture,
        tiltGesturesEnabled: widget.gesture,
        rotateGesturesEnabled: widget.gesture,
        zoomControlsEnabled: false,
        markers: marker ?? {},
        onMapCreated: onMapCreated,
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
          new Factory<OneSequenceGestureRecognizer>(
            () => new EagerGestureRecognizer(),
          ),
        ].toSet(),
        mapToolbarEnabled: false,
        myLocationButtonEnabled: true,
        initialCameraPosition: _initialCameraPosition,
      ),
    );
  }

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}
