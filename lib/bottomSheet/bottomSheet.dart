import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grafos2_app/controller.dart';
import 'package:grafos2_app/core.dart';
import 'package:grafos2_app/main.dart';

class BottomSheetDialog extends StatefulWidget {
  const BottomSheetDialog({Key? key, required this.latLgn}) : super(key: key);

  final LatLng latLgn;

  @override
  State<BottomSheetDialog> createState() => _BottomSheetDialogState();
}

class _BottomSheetDialogState extends State<BottomSheetDialog> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.5,
      width: size.width,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Descrição do local",
              ),
              controller: Controller.textController),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ListView(
                children: [...Controller.createMarkersList()],
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              Global.markers.add(
                Marker(
                    markerId: MarkerId(Controller.textController.value.text),
                    position:
                        LatLng(widget.latLgn.latitude, widget.latLgn.longitude),
                    infoWindow:
                        InfoWindow(title: Controller.textController.value.text),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRed)),
              );
              Controller.textController.clear();
              Global.markersCount.value = Global.markersCount.value + 1;
              Global.index = 0;
              Navigator.pop(context);
            },
            color: Colors.blue,
            child: Text("Adicionar!"),
            textColor: Colors.white,
          )
        ],
      ),
    );
  }
}
