import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_guide/core/services/app_settings/app_settings.dart';
import 'package:travel_guide/feature/details_page/presentation/page/details_activity_screen.dart';
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
    subscription?.cancel();
    super.dispose();
  }

  StreamSubscription? subscription;
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

    subscription = AppSettings().controller.stream.listen((event) {
      int i = 0;
      if (event is UpdateLatLong) {
        if (event.latLng != null) {
          mapController?.animateCamera(CameraUpdate.newLatLng(event.latLng!));
        }
      } else if (event is NearByLocationEvent) {
        List<Marker> li = [];
        Future.forEach(event.list, (ActivityRemoteModel element) async {
          li.add(
            Marker(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailsActivitiesRegionScreen(model: element),
                  ),
                );
              },
              markerId: MarkerId((i++).toString()),
              position: LatLng(element.latitude ?? 0, element.longitude ?? 0),
            ),
          );
        }).then((value) {
          marker = li.toSet();
          setState(() {});
        });
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

  bool screenOpen = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          screenOpen = false;
        });
        Navigator.of(context).pop();
        return true;
      },
      child: Visibility(
        visible: screenOpen,
        child: Stack(
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
      ),
    );
  }

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}

class MapForDetails extends StatefulWidget {
  const MapForDetails({super.key, required this.latLng});

  @override
  MapForDetailsState createState() => MapForDetailsState();
  final LatLng latLng;
}

class MapForDetailsState extends State<MapForDetails> {
  GoogleMapController? mapController;

  late CameraPosition _initialCameraPosition =
      CameraPosition(target: widget.latLng, zoom: 15);
  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  bool screenOpen = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          screenOpen = false;
        });
        Navigator.of(context).pop();
        return true;
      },
      child: Visibility(
        visible: screenOpen,
        child: Container(
          padding: EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: GoogleMap(
                markers: {
                  Marker(
                    markerId: MarkerId(
                      "MapForDetails",
                    ),
                    position: widget.latLng,
                  )
                },
                zoomGesturesEnabled: false,
                scrollGesturesEnabled: false,
                tiltGesturesEnabled: false,
                rotateGesturesEnabled: false,
                zoomControlsEnabled: false,
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
            ),
          ),
        ),
      ),
    );
  }

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}
