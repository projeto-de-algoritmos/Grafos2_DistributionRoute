// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  List<Marker> markers = [
    Marker(
        markerId: MarkerId('Base'),
        position: LatLng(37.42089449167863, -122.08532821387054),
        infoWindow: InfoWindow(title: 'Central distribuidora'),
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange)),
    Marker(
      markerId: MarkerId('Base2'),
      position: LatLng(37.42076588123734, -122.08291556686162),
      infoWindow: InfoWindow(title: 'Central distribuidora'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    )
  ];

  List<LatLng> polylineCoordinates = [];

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyCPDyusnf6v5acaMIUWfO1PvDWbT3WlhXo",
        PointLatLng(37.42089449167863, -122.08532821387054),
        PointLatLng(37.42076588123734, -122.08291556686162));

    if (result.points.isNotEmpty) {
      result.points.forEach((element) {
        polylineCoordinates.add(LatLng(element.latitude, element.longitude));
      });

      setState(() {});
    }
  }

  @override
  void initState() {
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(markers),
        onLongPress: (latLng) {
          print('${latLng.latitude}, ${latLng.longitude}');
          markers.add(
            Marker(
              markerId: MarkerId('${latLng.latitude}'),
              position: LatLng(latLng.latitude, latLng.longitude),
              infoWindow: InfoWindow(title: 'The title of the marker'),
            ),
          );

          setState(() {});
        },
        polylines: {
          Polyline(
              polylineId: PolylineId("Route"),
              points: polylineCoordinates,
              color: Colors.red,
              width: 6)
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('Faça o caminho!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
