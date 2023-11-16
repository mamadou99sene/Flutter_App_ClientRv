import 'dart:math';

import 'package:xml/xml.dart';

class StructureXML {
  late int idStructure;
  late String localisation;
  late int capacite;
  late String typeTraitement;
  late String telephone;
  late String email;
  late String typeTest;

  StructureXML(
      {required this.idStructure,
      required this.localisation,
      required this.capacite,
      required this.typeTraitement,
      required this.email,
      required this.typeTest,
      required this.telephone});
  StructureXML.fromXML(XmlElement xmlData) {
    idStructure = xmlData.findElements("idStructuresante").first.text as int;
    /*localisation = xmlData["localisation"];
    capacite = xmlData["capacite"];
    typeTraitement = xmlData["typeTraitement"];
    telephone = xmlData["telephone"];
    email = xmlData["email"];
    typeTest = xmlData["typetest"];*/
  }
  Map<String, dynamic> toJson() {
    return {
      "idStructuresante": idStructure,
      "localisation": localisation,
      "capacite": capacite,
      "typeTraitement": typeTraitement,
      "email": email,
      "typetest": typeTest,
      "telephone": telephone
    };
  }
}
