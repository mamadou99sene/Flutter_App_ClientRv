import 'package:flutter/material.dart';

class MyButtonStyle extends StatelessWidget {
  String text;
  VoidCallback pressed;
  MyButtonStyle({required this.text, required this.pressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          // elevation: MaterialStateProperty.all(0),
          backgroundColor:
              MaterialStateProperty.all(Color.fromARGB(255, 248, 104, 94)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ))),
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: pressed,
    );
  }
}
