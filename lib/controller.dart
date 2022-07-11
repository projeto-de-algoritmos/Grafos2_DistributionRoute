import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grafos2_app/bottomSheet/listItem.dart';
import 'package:grafos2_app/core.dart';

class Controller {
  static TextEditingController textController = TextEditingController();

  static double distanceBetweenPoints(Marker marker1, Marker marker2) {
    var x = pow((marker1.position.latitude - marker2.position.latitude), 2);
    var y = pow((marker1.position.longitude - marker2.position.longitude), 2);

    return sqrt(x + y);
  }

  static List<Widget> createMarkersList() {
    List<Widget> result = [];

    Global.markers.forEach((element) {
      result.add(ListItem(mark: element));
    });

    return result;
  }
}
