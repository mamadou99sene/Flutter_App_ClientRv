import 'dart:convert';

import 'package:client_covid/models/Utilisateurs.dart';
import 'package:http/http.dart' as http;

class Repos {
  Future<bool> saveUser(Utilisateur utilisateur) async {
    String url =
        "http://192.168.43.214:8080/REST_COVID_WEB_SERVICE/rs/utilisateurs";
    http.Response response = await http.post(Uri.parse(url),
        body: jsonEncode(utilisateur.toJson()),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 204) {
      print("cible atteint");
      return true;
    } else {
      print("error connection ");
    }
    return false;
  }
}
