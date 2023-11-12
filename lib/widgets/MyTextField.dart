import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  String MyHintText;
  TextEditingController mycontroller;
  Icon myicon;
  VoidCallback? pressed;
  bool obscure = false;
  bool autoFocus;
  MyTextField(
      {required this.MyHintText,
      required this.mycontroller,
      required this.myicon,
      this.pressed,
      required this.autoFocus,
      required this.obscure});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: TextField(
          controller: mycontroller,
          obscureText: obscure,
          autofocus: autoFocus,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: pressed,
                icon: myicon,
                color: Colors.red,
              ),
              hoverColor: Colors.green,
              hintText: MyHintText,
              hintStyle: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w400,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  style: BorderStyle.solid,
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(20),
              ))),
    );
  }
}
