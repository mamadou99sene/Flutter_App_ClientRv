import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ConnexionButton extends StatelessWidget {
  final Text child;
  final ButtonStyle style;
  Function onPresse;
  ConnexionButton({
    required this.child,
    required this.style,
    required this.onPresse,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(style: style, onPressed: () {}, child: child),
      ),
    );
  }
}
