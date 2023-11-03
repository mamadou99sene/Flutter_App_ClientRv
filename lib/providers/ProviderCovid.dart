import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProviderCovid extends ChangeNotifier {
  Icon icon = Icon(Icons.visibility);
  bool visibility = false;
  void change_Visibility() {
    visibility = !visibility;
    notifyListeners();
  }

  void changeIcon() {
    if (visibility == true) {
      icon = Icon(Icons.visibility_off);
      notifyListeners();
    } else {
      icon = Icon(Icons.visibility);
      notifyListeners();
    }
  }
}
