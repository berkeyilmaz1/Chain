import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:schallange/constants/constants.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(40.903755512259494, 31.17518115919611),
    zoom: 14.4746,
  );

  static const CameraPosition _kYesilay = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(40.843089542747336, 31.158345545381515),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: {
            const Marker(
              markerId: MarkerId("yesilayduzce"),
              position: LatLng(40.843089542747336, 31.158345545381515),
            ),
            const Marker(
              markerId: MarkerId("yesilaysakarya"),
              position: LatLng(40.75520829989961, 30.377105196134924),
            ),
            const Marker(
              markerId: MarkerId("yesilaymanisa"),
              position: LatLng(38.61965414281593, 27.425797959749215),
            ),
            const Marker(
              markerId: MarkerId("yesilayizmir"),
              position: LatLng(38.42556666312049, 27.13391785108249),
            ),
            const Marker(
              markerId: MarkerId("yesilaybolu"),
              position: LatLng(40.73694979730263, 31.613268190200642),
            ),
            const Marker(
              markerId: MarkerId("yesilayzonguldak"),
              position: LatLng(41.452280349183354, 31.789758126627717),
            ),
          }),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: ufo_green,
        onPressed: _goToTheLake,
        label: const Text(
          'En Yakın Yeşilay',
          style: kButtonTextStyle,
        ),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kYesilay));
  }
}
