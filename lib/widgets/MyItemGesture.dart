import 'package:flutter/material.dart';

class MyItemGesture extends StatelessWidget {
  String textItem;
  VoidCallback itemPressed;
  MyItemGesture({required this.textItem, required this.itemPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.red),
        width: 160,
        height: 150,
        child: ElevatedButton(
          style: ButtonStyle(
              // elevation: MaterialStateProperty.all(0),
              backgroundColor:
                  MaterialStateProperty.all(Color.fromARGB(255, 251, 23, 7)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ))),
          child: Text(
            textItem,
            style: TextStyle(color: Colors.white),
          ),
          onPressed: itemPressed,
        ),
      ),
    );
  }
}
