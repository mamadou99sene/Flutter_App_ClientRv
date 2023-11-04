import 'dart:convert';

import 'package:client_covid/models/StructureDeSante.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProviderCovid extends ChangeNotifier {
  Icon icon = Icon(Icons.visibility);
  bool visibility = false;
  static List<StructureDeSante> listStructures = [];
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

  Future<List<StructureDeSante>> getStructures() async {
    String url = "http://localhost:8080/REST_COVID_WEB_SERVICE/rs/structures";
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print("cible atteint");
    } else {
      print("error connection");
    }
    var responseJson = jsonDecode(response.body);
    for (var s in responseJson[""]) {
      listStructures.add(StructureDeSante.fromJson(s));
    }
    print(listStructures);
    return listStructures;
  }
}
