import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grafos2_app/controller.dart';
import 'package:grafos2_app/core.dart';

class Grafo {
  static void addVerticeToGraph(String markerId) {
    if (Global.grafo[markerId] == null) {
      Global.grafo[markerId] = [];
    }
  }

  static void addEdgesToGraph(Marker marker) {
    Global.selectedMarkers.forEach((element) {
      Global.grafo[marker.markerId.value].add(Edge(
          from: marker,
          to: element,
          distance: Controller.distanceBetweenPoints(marker, element)));
    });
  }
}

class Edge {
  Marker from;
  Marker to;
  double distance;

  Edge({required this.from, required this.to, required this.distance});

  @override
  String toString() {
    return "${this.distance}";
  }
}
