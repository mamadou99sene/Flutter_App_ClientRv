import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InscriptionButton extends StatelessWidget {
  final Text child;
  final ButtonStyle style;
  VoidCallback? pressed;
  InscriptionButton({
    required this.child,
    required this.style,
    required this.pressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(style: style, onPressed: pressed, child: child),
      ),
    );
  }
}
