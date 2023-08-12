// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
//
// class MapScreen extends StatefulWidget {
//   final bool locationPicker;
//
//   const MapScreen({Key? key, this.locationPicker = false}) : super(key: key);
//
//   @override
//   _MapScreen createState() => _MapScreen();
// }
//
// class _MapScreen extends State<MapScreen> {
//   GoogleMapController? mapController;
//
//   Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
//
//   PropertyLocalModel? propertyLocalModel;
//
//   CameraPosition _initialCameraPosition =
//       CameraPosition(target: const LatLng(33.510414, 36.278336), zoom: 12);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         floatingActionButton: widget.locationPicker
//             ? FloatingActionButton(
//                 child: FaIcon(widget.locationPicker
//                     ? FontAwesomeIcons.pizzaSlice
//                     : FontAwesomeIcons.locationArrow),
//                 onPressed: () async {
//                   if (!widget.locationPicker) {
//                     Geolocator.getCurrentPosition(
//                             desiredAccuracy: LocationAccuracy.lowest)
//                         .then((value) async {
//                       await mapController!.animateCamera(
//                           CameraUpdate.newLatLngZoom(
//                               LatLng(value.latitude, value.longitude), 15));
//                     });
//                   } else {
//                     double screenWidth = MediaQuery.of(context).size.width *
//                         MediaQuery.of(context).devicePixelRatio;
//                     double screenHeight = MediaQuery.of(context).size.height *
//                         MediaQuery.of(context).devicePixelRatio;
//
//                     double middleX = screenWidth / 2;
//                     double middleY = screenHeight / 2;
//
//                     ScreenCoordinate screenCoordinate = ScreenCoordinate(
//                         x: middleX.round(), y: middleY.round());
//
//                     LatLng middlePoint =
//                         await mapController!.getLatLng(screenCoordinate);
//                     sl<AddScreenCubit>().setLatLng(middlePoint);
//                     Navigator.pop(context);
//                   }
//                 },
//               )
//             : null,
//         body: Stack(
//           alignment: Alignment.center,
//           children: <Widget>[
//             GoogleMap(
//               onTap: (argument) {
//                 propertyLocalModel = null;
//                 setState(() {});
//               },
//               onCameraIdle: () async {
//                 if (!widget.locationPicker) {
//                   double screenWidth = MediaQuery.of(context).size.width *
//                       MediaQuery.of(context).devicePixelRatio;
//                   double screenHeight = MediaQuery.of(context).size.height *
//                       MediaQuery.of(context).devicePixelRatio;
//
//                   ScreenCoordinate screenCoordinate1 =
//                       ScreenCoordinate(x: 0, y: 0);
//                   ScreenCoordinate screenCoordinate2 =
//                       ScreenCoordinate(x: screenWidth.round(), y: 0);
//                   ScreenCoordinate screenCoordinate3 = ScreenCoordinate(
//                       x: screenWidth.round(), y: screenHeight.round());
//                   ScreenCoordinate screenCoordinate4 =
//                       ScreenCoordinate(x: 0, y: screenHeight.round());
//
//                   LatLng lanLat1 =
//                       await mapController!.getLatLng(screenCoordinate1);
//                   LatLng lanLat2 =
//                       await mapController!.getLatLng(screenCoordinate2);
//                   LatLng lanLat3 =
//                       await mapController!.getLatLng(screenCoordinate3);
//                   LatLng lanLat4 =
//                       await mapController!.getLatLng(screenCoordinate4);
//                   List<LatLng> li = [lanLat1, lanLat2, lanLat3, lanLat4];
//                   markers.clear();
//
//                   (await HttpHelper.getMapProperty(li)).either((left) {
//                     if (left.data != null) {
//                       left.data!.forEach((element) {
//                         List<String> photo = [];
//                         if (element.photo != null && element.photo!.isNotEmpty)
//                           photo = element.photo!.first.photo!.split('@@');
//                         for (int i = 0; i < photo.length; i++) {
//                           photo[i] = AccountUtils.setImagePath(photo[i]);
//                         }
//
//                         PropertyLocalModel tempProperty = PropertyLocalModel(
//                             viewCount: element.viewCount,
//                             id: element.id,
//                             name: element.name,
//                             bathroomnumber: element.bathroomnumber,
//                             bedroomnumber: element.bedroomnumber,
//                             deletedAt: element.deletedAt,
//                             description: element.description,
//                             lan: element.lan,
//                             lat: element.lat,
//                             local: element.local,
//                             photo: photo,
//                             price: element.price,
//                             propartytype: element.propartytype,
//                             state: element.state,
//                             roomnumber: element.roomnumber,
//                             userId: element.userId);
//
//                         markers[MarkerId(element.id.toString())] = Marker(
//                             markerId: MarkerId(element.id.toString()),
//                             alpha: 0.8,
//                             onTap: () {
//                               propertyLocalModel = tempProperty;
//                               setState(() {});
//                             },
//                             position:
//                                 LatLng(element.lat ?? 0, element.lan ?? 0),
//                             icon: BitmapDescriptor.defaultMarker);
//                       });
//                     }
//                     setState(() {});
//                   }, (right) {});
//                 }
//               },
//               onMapCreated: onMapCreated,
//               markers: Set<Marker>.of(markers.values),
//               gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
//                 new Factory<OneSequenceGestureRecognizer>(
//                   () => new EagerGestureRecognizer(),
//                 ),
//               ].toSet(),
//               mapToolbarEnabled: false,
//               zoomGesturesEnabled: true,
//               zoomControlsEnabled: false,
//               scrollGesturesEnabled: true,
//               myLocationButtonEnabled: true,
//               initialCameraPosition: _initialCameraPosition,
//             ),
//             if (widget.locationPicker) ...[
//               Container(
//                 width: 10,
//                 height: 10,
//                 color: Colors.red,
//               ),
//               Icon(Icons.center_focus_strong),
//             ],
//             if (propertyLocalModel != null) propertyWidget(propertyLocalModel!)
//           ],
//         ),
//       ),
//     );
//   }
//
//   onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }
//
//   Widget propertyWidget(PropertyLocalModel propertyLocalModel) {
//     return Positioned(
//         bottom: 0,
//         child: GestureDetector(
//           onTap: () {
//             Navigator.push(context, MaterialPageRoute(
//               builder: (context) {
//                 return DetailsScreen(
//                   id: propertyLocalModel.id ?? -1,
//                   fromMyProperty: false,
//                 );
//               },
//             ));
//           },
//           child: Container(
//             margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//             child: Column(
//               children: [
//                 Stack(
//                   children: [
//                     Container(
//                       height: 220,
//                       width: 350,
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade900,
//                         borderRadius: BorderRadius.only(
//                             bottomRight: Radius.circular(20),
//                             bottomLeft: Radius.circular(20),
//                             topLeft: Radius.circular(20),
//                             topRight: Radius.circular(20)),
//                         image: DecorationImage(
//                           fit: BoxFit.cover,
//                           image: AdvancedNetworkImage(
//                               propertyLocalModel.photo!.first),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 40,
//                       left: 25,
//                       child: Row(
//                         children: [
//                           Text(
//                             propertyLocalModel.name ?? "",
//                             style: TextStyle(
//                               fontSize: 25,
//                               color: Colors.white,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 100,
//                           ),
//                           Text(
//                             '${propertyLocalModel.price.toString()} \$',
//                             style: TextStyle(
//                               fontSize: 20,
//                               color: Colors.white,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 15,
//                       left: 22,
//                       child: Text(
//                         propertyLocalModel.local ?? "",
//                         style: TextStyle(
//                           fontSize: 15,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 15,
//                       right: 22,
//                       child: Text(
//                         '${propertyLocalModel.viewCount} views',
//                         style: TextStyle(
//                           fontSize: 15,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }
