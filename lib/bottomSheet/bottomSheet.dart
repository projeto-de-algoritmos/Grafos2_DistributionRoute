import 'package:flutter/material.dart';
import 'package:grafos2_app/bottomSheet/listItem.dart';
import 'package:grafos2_app/controller.dart';

class BottomSheetDialog extends StatefulWidget {
  const BottomSheetDialog({Key? key}) : super(key: key);

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
            onPressed: () {},
            color: Colors.blue,
            child: Text("Adicionar!"),
            textColor: Colors.white,
          )
        ],
      ),
    );
  }
}
