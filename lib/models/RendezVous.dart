import 'package:client_covid/models/StructureXML.dart';
import 'package:client_covid/models/Utilisateurs.dart';

class RendezVous {
  late int idRendezVous;
  late DateTime date;
  late DateTime heure;
  late String typeRendezVous;
  late String status;
  late Utilisateur? utilisateur;
  late StructureXML? structure;
  RendezVous(
      {required this.idRendezVous,
      required this.date,
      required this.heure,
      required this.typeRendezVous,
      required this.status,
      required this.utilisateur,
      required this.structure});

  Map<String, dynamic> toJson() {
    return {
      "idRendezvous": idRendezVous,
      "date": date.toIso8601String(),
      "heure": heure.toIso8601String(),
      "typerendezvous": typeRendezVous,
      "status": status,
      "utilisateur": utilisateur,
      "structuredesante": structure
    };
  }
}
