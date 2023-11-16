import 'dart:convert';

import 'package:client_covid/models/RendezVous.dart';
import 'package:client_covid/models/Utilisateurs.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class Repos {
  Utilisateur? utilisateur = null;
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

  Future<Utilisateur?> getUtilisateurByEmail(String email) async {
    String url =
        "http://192.168.43.214:8080/REST_COVID_WEB_SERVICE/rs/utilisateurs/$email";
    http.Response response =
        await http.post(Uri.parse(url), headers: {'Accept': 'application/xml'});
    var responseXML = response.body;
    print(response.statusCode);
    final document = XmlDocument.parse(responseXML);
    final users = document.findElements("utilisateur");
    for (var user in users) {
      final idUtilisateur =
          int.parse(user.findElements("idUtilisateur").first.text);
      final email = user.findElements("email").first.text;
      final prenom = user.findAllElements("prenom").first.text;
      final nom = user.findAllElements("nom").first.text;
      final telephone = user.findAllElements("phone").first.text;
      final password = user.findAllElements("password").first.text;
      utilisateur = Utilisateur(
          idUtilisateur: idUtilisateur,
          prenom: prenom,
          nom: nom,
          email: email,
          phone: telephone,
          password: password);
    }
    print(utilisateur?.phone);
    return utilisateur;
  }

  Future<bool> saveRendezVous(RendezVous rendezVous) async {
    String url =
        "http://192.168.43.214:8080/REST_COVID_WEB_SERVICE/rs/rendezvous";
    http.Response response = await http.post(Uri.parse(url),
        body: jsonEncode(rendezVous.toJson()),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 204) {
      print("cible atteint");
      return true;
    } else {
      print("error connection ${response.statusCode}");
    }
    return false;
  }
}
