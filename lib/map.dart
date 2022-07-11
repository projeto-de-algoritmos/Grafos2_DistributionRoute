// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grafos2_app/bottomSheet/bottomSheet.dart';
import 'package:grafos2_app/controller.dart';
import 'package:grafos2_app/core.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _UnBGama = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(-15.989557572245221, -48.044411838054664),
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: Global.markersCount,
      builder: (BuildContext context, int markersCount, Widget? child) {
        return Scaffold(
          body: GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: _UnBGama,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: Set<Marker>.of(Global.markers),
            onLongPress: (latLng) async {
              await showRegisterDialog(context, latLng);
              print('${latLng.latitude}, ${latLng.longitude}');
              print(Controller.distanceBetweenPoints(
                  Global.markers[0], Global.markers[1]));
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: nextStop,
            label: Text('Próxima Parada!'),
            icon: Icon(Icons.directions_boat),
          ),
        );
      },
    );
  }

  Future<void> nextStop() async {
    final GoogleMapController controller = await _controller.future;
    if (Global.index >= Global.markersCount.value) Global.index = 0;
    Marker nextMarker = Global.markers.elementAt(Global.index);
    CameraPosition nextStop = CameraPosition(
        bearing: 192.8334901395799,
        target:
            LatLng(nextMarker.position.latitude, nextMarker.position.longitude),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);
    controller.animateCamera(CameraUpdate.newCameraPosition(nextStop));
    Global.index++;
  }

  showRegisterDialog(BuildContext contextPage, LatLng latLng) {
    return showBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return BottomSheetDialog(
          latLgn: latLng,
        );
      },
    );
  }
}
