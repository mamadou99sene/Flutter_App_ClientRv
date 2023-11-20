import 'dart:convert';

import 'package:client_covid/models/StructureDeSante.dart';
import 'package:client_covid/models/StructureXML.dart';
import 'package:client_covid/models/Utilisateurs.dart';
import 'package:client_covid/pages/MyRvPage.dart';
import 'package:client_covid/pages/StructuresPage.dart';
import 'package:client_covid/providers/ProviderCovid.dart';
import 'package:client_covid/widgets/InscriptionButton.dart';
import 'package:client_covid/widgets/MyButtonStyle.dart';
import 'package:client_covid/widgets/MyDrawer.dart';
import 'package:client_covid/widgets/MyItemGesture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  Utilisateur utilisateur;
  App({
    required this.utilisateur,
  });

  @override
  Widget build(BuildContext context) {
    //this.utilisateur = ModalRoute.of(context).settings.arguments;
    return ChangeNotifierProvider(
        create: (context) => ProviderCovid(),
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Bienvenue",
                  style: TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.logout))
              ],
            ),
            backgroundColor: Colors.red[400],
            elevation: 0,
            centerTitle: true,
            titleTextStyle:
                const TextStyle(decoration: TextDecoration.underline),
          ),
          drawer: MyDrawer(prenom: utilisateur.prenom, nom: utilisateur.nom),
          body: FutureBuilder(
            future: ProviderCovid().getStructuresXML(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SpinKitHourGlass(
                  color: Colors.red,
                  size: 100,
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Connection error",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                );
              } else if (snapshot.hasData) {
                print("OK");
                List<StructureXML>? structures = snapshot.data;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 150,
                      margin: EdgeInsets.all(5),
                      color: Color.fromARGB(255, 251, 236, 237),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              (structures == null ? 0 : structures.length),
                          itemBuilder: (context, index) {
                            return Container(
                              width: 150,
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(5),
                              color: Colors.red,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${structures![index].capacite} places",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  MyButtonStyle(
                                      text: structures![index].localisation,
                                      pressed: () {
                                        Navigator.pushNamed(
                                            context, "/rendezvous",
                                            arguments: structures[index]);
                                      })
                                ],
                              ),
                            ); /*ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "${list![index].email}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  CircleAvatar(
                                    child: Text(list[index].capacite.toString()),
                                  )
                                ],
                              ),
                            );*/
                          }),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Consulter nos fonctionnalités",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(
                          Icons.directions,
                          color: Colors.red,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MyItemGesture(
                            textItem: "Nos Structures",
                            itemPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StructuresPage()));
                            }),
                        MyItemGesture(
                            textItem: "Mes rendez vous",
                            itemPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MyRvPage(utilisateur: utilisateur)));
                            })
                      ],
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: InscriptionButton(
                            child: Text(
                              "Prendre un rendez vous",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.normal),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ))),
                            pressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StructuresPage()));
                            }),
                      ),
                    )
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ));
  }
}
