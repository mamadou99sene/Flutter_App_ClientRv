import 'package:client_covid/App.dart';
import 'package:client_covid/models/Utilisateurs.dart';
import 'package:client_covid/pages/Inscription.dart';
import 'package:client_covid/providers/ProviderCovid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class loginPage extends StatelessWidget {
  const loginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerEmail = TextEditingController();
    TextEditingController controllerPassword = TextEditingController();
    Utilisateur utilisateur;
    String email = "";
    String password = "";
    return ChangeNotifierProvider(
      create: (context) => ProviderCovid(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Login",
            style: TextStyle(
                fontSize: 30,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal),
          ),
          centerTitle: true,
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                textAlign: TextAlign.center,
                autofocus: true,
                controller: controllerEmail,
                onTap: () {},
                decoration: InputDecoration(
                    hintText: "Your email",
                    hintStyle: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            width: 1,
                            style: BorderStyle.solid,
                            color: Colors.red))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter your email";
                  }
                  return null;
                },
              )),
          Container(
              padding: const EdgeInsets.all(10),
              child: Consumer<ProviderCovid>(
                builder: (context, value, child) {
                  return TextFormField(
                    textAlign: TextAlign.center,
                    controller: controllerPassword,
                    obscureText: value.visibility,
                    decoration: InputDecoration(
                        hintText: "Your password",
                        hintStyle: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              Provider.of<ProviderCovid>(context, listen: false)
                                  .change_Visibility();
                              Provider.of<ProviderCovid>(context, listen: false)
                                  .changeIcon();
                            },
                            icon: value.icon),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              width: 1,
                              style: BorderStyle.solid,
                              color: Colors.red,
                            ))),
                  );
                },
              )),
          Container(
            padding: EdgeInsets.all(5),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ))),
                  onPressed: () async {
                    email = controllerEmail.text;
                    password = controllerPassword.text;
                    utilisateur = (await ProviderCovid()
                        .getUtilisateurs(email, password))!;
                    if (utilisateur != null) {
                      String prenom = utilisateur.prenom;
                      String nom = utilisateur.nom;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  App(prenom: prenom, nom: nom)));
                      /* Navigator.pushNamed(context, "/home",
                          arguments: utilisa eur);*/
                    }
                  },
                  child: const Text(
                    "Connexion",
                    style: TextStyle(
                        fontSize: 30,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal),
                  )),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Vous n'avez pas encore de compte ? ",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Inscription(),
                        ));
                  },
                  child: Text(
                    "S'inscrire ",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline),
                  ))
            ],
          )
        ]),
      ),
    );
  }
}
