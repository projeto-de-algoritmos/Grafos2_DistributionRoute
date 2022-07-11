import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ListItem extends StatefulWidget {
  const ListItem({Key? key, required this.mark}) : super(key: key);

  final Marker mark;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.05,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: MaterialButton(
        child: Center(
          child: Text(
            widget.mark.infoWindow.title ?? "Marker",
            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
          ),
        ),
        onPressed: () {
          isSelected = !isSelected;
          setState(() {});
        },
      ),
    );
  }
}
