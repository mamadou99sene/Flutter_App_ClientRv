class Utilisateur {
  late int idUtilisateur;
  late String prenom;
  late String nom;
  late String email;
  late String phone;
  late String password;
  Utilisateur(
      {required this.idUtilisateur,
      required this.prenom,
      required this.nom,
      required this.email,
      required this.phone,
      required this.password});
  Map<String, dynamic> toJson() {
    return {
      "idUtilisateur": idUtilisateur,
      "prenom": prenom,
      "nom": nom,
      "email": email,
      "phone": phone,
      "password": password
    };
  }

  Utilisateur.fromJson(dynamic jsonData) {
    idUtilisateur = jsonData["idUtilisateur"];
    prenom = jsonData["prenom"];
    nom = jsonData["nom"];
    email = jsonData["email"];
    phone = jsonData["phone"];
    password = jsonData["password"];
  }
}
