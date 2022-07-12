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
      var distance = Controller.distanceBetweenPoints(marker, element);
      Global.grafo[marker.markerId.value].add(
        Edge(
          to: element,
          distance: distance,
        ),
      );
      Global.grafo[element.markerId.value].add(
        Edge(to: marker, distance: distance),
      );
    });
  }

  static primAlgorithym() {
    var mstset = List.filled(Global.markersCount.value, false);
    var e = List.filled(Global.markersCount.value, NodePriorityQueue());

    var parent = List.filled(Global.markersCount.value, 0);

    for (var o = 0; o < Global.markersCount.value; o++) {
      e[o] = NodePriorityQueue();
    }
    for (var j = 0; j < Global.markersCount.value; j++) {
      mstset[j] = false;

      e[j].key = 10000000;
      e[j].vertex = j;
      parent[j] = -1;
    }

    mstset[0] = true;
    e[0].key = 0;

    var queue = [];

    for (var o = 0; o < Global.markersCount.value; o++) {
      queue.add(e[o]);
    }

    queue.sort(((a, b) => a.key.compareTo(b.key)));

    while (queue.isNotEmpty) {
      var node0 = queue.removeAt(0);

      mstset[node0.vertex] = true;

      Global.grafo[node0.vertex.toString()].forEach((element) {
        if (mstset[int.parse(element.to.markerId.value)] == false) {
          if (e[int.parse(element.to.markerId.value)].key > element.distance) {
            queue.removeAt(
                queue.indexOf(e[int.parse(element.to.markerId.value)]));
            e[int.parse(element.to.markerId.value)].key = element.distance;
            queue.add(e[int.parse(element.to.markerId.value)]);
            queue.sort(((a, b) => a.key.compareTo(b.key)));
            parent[int.parse(element.to.markerId.value)] = node0.vertex;
          }
        }

        // Prints the vertex pair of mst
      });
    }
    for (var o = 1; o < Global.markersCount.value; o++)
      print("${parent[o]} - ${o}");

    Global.orderedMarkers = [];
    Global.orderedMarkers.add(Global.markers[0]);
    var selected = 0;
    var aux = 0;

    for (var i = 0; i < Global.markersCount.value; i++) {
      for (var child = 0; child < Global.markersCount.value; child++) {
        if (parent[child] == selected) {
          Global.orderedMarkers.add(Global.markers[child]);
          aux = child;
        }
      }
      selected = aux;
    }
  }
}

class Edge {
  Marker to;
  double distance;

  Edge({required this.to, required this.distance});

  @override
  String toString() {
    return "${this.distance}";
  }
}

class NodePriorityQueue {
  int vertex;
  double key;

  NodePriorityQueue({this.vertex = 0, this.key = 0.0});
}
