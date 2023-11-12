import 'dart:convert';

import 'package:client_covid/repos/Repos.dart';
import 'package:client_covid/models/Utilisateurs.dart';
import 'package:client_covid/providers/ProviderCovid.dart';
import 'package:client_covid/widgets/InscriptionButton.dart';
import 'package:client_covid/widgets/MyTextField.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Inscription extends StatelessWidget {
  const Inscription({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerFirstName = TextEditingController();
    TextEditingController controllerLastName = TextEditingController();
    TextEditingController controllerEmail = TextEditingController();
    TextEditingController controllerPhone = TextEditingController();
    TextEditingController controllerPassword = TextEditingController();
    String firstname = "";
    String lastName = "";
    String email = "";
    String phone = "";
    String password = "";
    Utilisateur utilisateur;
    return ChangeNotifierProvider(
        create: (context) => ProviderCovid(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Inscription",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            centerTitle: true,
            elevation: 0,
            actions: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.connect_without_contact))
                ],
              )
            ],
          ),
          body: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  "INSCRIPTION",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.red[400],
                      height: 3,
                      decoration: TextDecoration.underline),
                ),
                MyTextField(
                  MyHintText: "First name",
                  mycontroller: controllerFirstName,
                  autoFocus: true,
                  myicon: Icon(
                    Icons.person_2,
                    color: Colors.red,
                  ),
                  obscure: false,
                ),
                MyTextField(
                  MyHintText: "Last name",
                  mycontroller: controllerLastName,
                  autoFocus: false,
                  myicon: Icon(
                    Icons.person_3,
                    color: Colors.red,
                  ),
                  obscure: false,
                ),
                MyTextField(
                  MyHintText: "Email",
                  mycontroller: controllerEmail,
                  autoFocus: false,
                  myicon: Icon(
                    Icons.email,
                    color: Colors.red,
                  ),
                  obscure: false,
                ),
                MyTextField(
                  MyHintText: "Phone",
                  mycontroller: controllerPhone,
                  autoFocus: false,
                  myicon: Icon(
                    Icons.phone,
                    color: Colors.red,
                  ),
                  obscure: false,
                ),
                Consumer<ProviderCovid>(
                  builder: (context, value, child) {
                    return MyTextField(
                      MyHintText: "Password",
                      mycontroller: controllerPassword,
                      autoFocus: false,
                      myicon: value.icon,
                      pressed: () {
                        Provider.of<ProviderCovid>(context, listen: false)
                            .change_Visibility();
                        Provider.of<ProviderCovid>(context, listen: false)
                            .changeIcon();
                      },
                      obscure: value.visibility,
                    );
                  },
                ),
                InscriptionButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ))),
                    child: Text(
                      "Register",
                      style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.normal),
                    ),
                    pressed: () async {
                      firstname = controllerFirstName.text.trim();
                      lastName = controllerLastName.text.trim();
                      email = controllerEmail.text.trim();
                      phone = controllerPhone.text.trim();
                      password = controllerPassword.text.trim();
                      if (firstname.isNotEmpty &&
                          lastName.isNotEmpty &&
                          email.isNotEmpty &&
                          phone.isNotEmpty &&
                          password.isNotEmpty) {
                        utilisateur = Utilisateur(
                            idUtilisateur: 0,
                            prenom: firstname,
                            nom: lastName,
                            email: email,
                            phone: phone,
                            password: password);

                        bool successInscription =
                            await Repos().saveUser(utilisateur);
                        if (successInscription) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 0,
                                  title: SizedBox(
                                    height: 100,
                                    width: double.infinity,
                                    child: Text(
                                      "Inscription reussie, connectez vous",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  content: TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ))),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pushNamed(context, "/");
                                    },
                                    child: Text(
                                      "Ok",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                );
                              });
                        }
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 0,
                                title: SizedBox(
                                  height: 100,
                                  width: double.infinity,
                                  child: Text(
                                    "Veuiller remplir tous les champs",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                content: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(Colors.red),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ))),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Ok",
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              );
                            });
                      }
                    })
              ],
            ),
          ),
        ));
  }
}
