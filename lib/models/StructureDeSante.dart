class StructureDeSante {
  late int idStructure;
  late String localisation;
  late int capacite;
  late String typeTraitement;
  late String telephone;
  late String email;
  late String typeTest;
  StructureDeSante.fromJson(dynamic jsonData) {
    idStructure = jsonData["idStructuresante"];
    localisation = jsonData["localisation"];
    capacite = jsonData["capacite"];
    typeTraitement = jsonData["typeTraitement"];
    telephone = jsonData["telephone"];
    email = jsonData["email"];
    typeTest = jsonData["typetest"];
  }
}
