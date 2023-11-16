import 'dart:convert';

import 'package:client_covid/models/StructureDeSante.dart';
import 'package:client_covid/models/StructureXML.dart';
import 'package:client_covid/models/Utilisateurs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class ProviderCovid extends ChangeNotifier {
  Icon icon = Icon(Icons.visibility);
  bool visibility = false;
  static List<StructureDeSante> listStructures = [];
  Utilisateur? utilisateur = null;
  List<StructureXML> listStructuresXML = [];
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
    String url =
        "http://192.168.43.214:8080/REST_COVID_WEB_SERVICE/rs/structures";
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {"Accept": "application/xml"},
    );
    if (response.statusCode == 200) {
      print("cible atteint");
    } else {
      print("error connection");
    }
    var responseJson = jsonDecode(response.body);
    for (var s in responseJson["data"]) {
      listStructures.add(StructureDeSante.fromJson(s));
    }
    return listStructures;
  }

  Future<List<StructureXML>> getStructuresXML() async {
    String url =
        "http://192.168.43.214:8080/REST_COVID_WEB_SERVICE/rs/structures";
    http.Response response =
        await http.get(Uri.parse(url), headers: {'Accept': 'application/xml'});
    var responseXML = response.body;
    final document = XmlDocument.parse(responseXML);
    final structures = document.findAllElements("structuredesante");
    for (var element in structures) {
      final capacite = int.parse(element.findElements('capacite').first.text);
      String email = element.findElements('email').first.text;
      final idStructuresante =
          int.parse(element.findElements('idStructuresante').first.text);
      String localisation = element.findElements('localisation').first.text;
      String telephone = element.findElements('telephone').first.text;
      String typeTraitement = element.findElements('typeTraitement').first.text;
      String typetest = element.findElements('typetest').first.text;
      StructureXML structureXML = StructureXML(
          idStructure: idStructuresante,
          localisation: localisation,
          capacite: capacite,
          typeTraitement: typeTraitement,
          email: email,
          typeTest: typetest,
          telephone: telephone);
      listStructuresXML.add(structureXML);
    }
    return listStructuresXML;
  }

  Future<Utilisateur?> getUtilisateurs(String email, String password) async {
    String url =
        "http://192.168.43.214:8080/REST_COVID_WEB_SERVICE/rs/utilisateurs/connexion/$email/$password";
    http.Response response =
        await http.post(Uri.parse(url), headers: {'Accept': 'application/xml'});
    var responseXML = response.body;
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
    return utilisateur;
  }
}
