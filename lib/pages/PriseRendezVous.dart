import 'package:client_covid/App.dart';
import 'package:client_covid/models/RendezVous.dart';
import 'package:client_covid/models/StructureXML.dart';
import 'package:client_covid/models/Utilisateurs.dart';
import 'package:client_covid/repos/Repos.dart';
import 'package:client_covid/widgets/InscriptionButton.dart';
import 'package:client_covid/widgets/MyButtonStyle.dart';
import 'package:client_covid/widgets/MyTextField.dart';
import 'package:flutter/material.dart';

class PriseRendezVous extends StatelessWidget {
  StructureXML? structure = null;
  Utilisateur? utilisateur = null;
  @override
  Widget build(BuildContext context) {
    this.structure =
        ModalRoute.of(context)!.settings.arguments as StructureXML?;
    TextEditingController controllerEmail = TextEditingController();
    TextEditingController controllerDate = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Rendez vous",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              "Prise de rendez vous à ${structure?.localisation}",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            ),
          ),
          MyTextField(
              MyHintText: "Your email",
              mycontroller: controllerEmail,
              myicon: Icon(
                Icons.email,
                color: Colors.red,
              ),
              autoFocus: true,
              obscure: false),
          MyTextField(
              MyHintText: "rv date",
              mycontroller: controllerDate,
              myicon: Icon(
                Icons.today,
                color: Colors.red,
              ),
              autoFocus: true,
              obscure: false),
          InscriptionButton(
              child: Text(
                "Confimer",
                style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ))),
              pressed: () async {
                String emailUser = controllerEmail.text;
                DateTime rvDate = DateTime(0);
                try {
                  rvDate = DateTime.parse(controllerDate.text);
                } catch (e) {
                  rvDate = DateTime.now();
                }
                if (emailUser.isNotEmpty && controllerDate.text.isNotEmpty) {
                  utilisateur = await Repos().getUtilisateurByEmail(emailUser);
                  if (utilisateur != null) {
                    RendezVous rendezVous = RendezVous(
                        idRendezVous: 0,
                        date: rvDate,
                        heure: rvDate,
                        typeRendezVous: "VACCINATION",
                        status: "EN COURS",
                        utilisateur: utilisateur,
                        structure: structure);
                    bool rvSuccess = await Repos().saveRendezVous(rendezVous);
                    if (rvSuccess) {
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
                                  "Votre rendez a été pris en compte",
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => App(
                                            prenom: utilisateur!.prenom,
                                            nom: utilisateur!.nom),
                                      ));
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
                    print("utilisateur inexistant");
                  }
                }
              })
        ]),
      ),
    );
  }
}
