import 'dart:convert';

import 'package:client_covid/models/RendezVous.dart';
import 'package:client_covid/models/StructureXML.dart';
import 'package:client_covid/models/Utilisateurs.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class Repos {
  late Utilisateur utilisateur;
  List<RendezVous> listRv = [];
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

  Future<Utilisateur> getUtilisateurByEmail(String email) async {
    String url =
        "http://192.168.43.214:8080/REST_COVID_WEB_SERVICE/rs/utilisateurs/$email";
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
    print(utilisateur.phone);
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

  Future<List<RendezVous>> getRvOfUser(String userEmail) async {
    String url =
        "http://192.168.43.214:8080/REST_COVID_WEB_SERVICE/rs/rendezvous/$userEmail";
    http.Response response =
        await http.post(Uri.parse(url), headers: {"Accept": "application/xml"});
    var responseXML = response.body;
    final document = XmlDocument.parse(responseXML);
    final allRvOfuser = document.findAllElements("rendezvous");
    for (var element in allRvOfuser) {
      int idRendezVous =
          int.parse(element.findElements("idRendezvous").first.text);
      DateTime date = DateTime.parse(element.findElements("date").first.text);
      DateTime heure = DateTime.parse(element.findElements("heure").first.text);
      final typeRendezVous = element.findElements("typerendezvous").first.text;
      final status = element.findElements("status").first.text;
      Utilisateur? utilisateur;
      StructureXML? structureXML;
      final userRv = document.findAllElements("utilisateur");
      for (var user in userRv) {
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
      final structures = document.findAllElements("structuredesante");
      for (var element in structures) {
        final capacite = int.parse(element.findElements('capacite').first.text);
        String email = element.findElements('email').first.text;
        final idStructuresante =
            int.parse(element.findElements('idStructuresante').first.text);
        String localisation = element.findElements('localisation').first.text;
        String telephone = element.findElements('telephone').first.text;
        String typeTraitement =
            element.findElements('typeTraitement').first.text;
        String typetest = element.findElements('typetest').first.text;
        structureXML = StructureXML(
            idStructure: idStructuresante,
            localisation: localisation,
            capacite: capacite,
            typeTraitement: typeTraitement,
            email: email,
            typeTest: typetest,
            telephone: telephone);
      }

      RendezVous rv = RendezVous(
          idRendezVous: idRendezVous,
          date: date,
          heure: heure,
          typeRendezVous: typeRendezVous,
          status: status,
          utilisateur: utilisateur,
          structure: structureXML);
      listRv.add(rv);
    }
    print("Nombre de rendez vous ${listRv.length}");
    return listRv;
  }
}
