import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Global {
  static List<Marker> markers = [
    Marker(
      markerId: MarkerId('Base'),
      position: LatLng(-15.989557572245221, -48.044411838054664),
      infoWindow: InfoWindow(title: 'UnB Gama'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    ),
  ];

  static ValueNotifier<int> markersCount = ValueNotifier(1);

  static int index = 0;
}
