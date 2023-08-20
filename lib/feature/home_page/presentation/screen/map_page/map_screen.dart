import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_guide/core/services/app_settings/app_settings.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';
import 'package:travel_guide/feature/home_page/domain/use_cases/get_all_activity_use_case.dart';

class MapScreen extends StatefulWidget {
  const MapScreen(
      {super.key,
      required this.gesture,
      required Function(dynamic argument) onTap});

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
          return Marker(
            markerId: MarkerId((i++).toString()),
            position: LatLng(e.latitude ?? 0, e.longitude ?? 0),
          );
        }).toSet();
        setState(() {});
      }
    });
    super.initState();
  }

  Future<Uint8List?> getBytesFromImage(String path) async {
    Uint8List? image = await loadNetworkImage(path);
    if (image != null) {
      final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
          image.buffer.asUint8List(),
          targetHeight: 150,
          targetWidth: 150);
      final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
      final ByteData? byteData =
          await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List? resizedImageMarker = byteData?.buffer.asUint8List();
      return resizedImageMarker;
    }
    return null;
  }

  Future<Uint8List?> loadNetworkImage(path) async {
    final completed = Completer<ImageInfo>();
    var image = NetworkImage(path);
    image.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener((info, _) => completed.complete(info)));
    final imageInfo = await completed.future;
    final byteData =
        await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
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

class AddMapScreen extends StatefulWidget {
  const AddMapScreen({super.key, required this.gesture, required this.onTap});

  @override
  AddMapScreenState createState() => AddMapScreenState();
  final bool gesture;
  final CameraPositionCallback onTap;
}

class AddMapScreenState extends State<AddMapScreen> {
  GoogleMapController? mapController;

  final CameraPosition _initialCameraPosition =
      const CameraPosition(target: LatLng(33.510414, 36.278336), zoom: 12);
  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            zoomGesturesEnabled: widget.gesture,
            scrollGesturesEnabled: widget.gesture,
            tiltGesturesEnabled: false,
            rotateGesturesEnabled: false,
            zoomControlsEnabled: false,
            onCameraMove: widget.onTap,
            onMapCreated: onMapCreated,
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
              Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
              ),
            },
            mapToolbarEnabled: false,
            myLocationButtonEnabled: true,
            initialCameraPosition: _initialCameraPosition,
          ),
          const FaIcon(FontAwesomeIcons.mapPin, color: Colors.red),
        ],
      ),
    );
  }

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}
