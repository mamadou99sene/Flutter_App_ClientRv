import 'package:client_covid/models/RendezVous.dart';
import 'package:client_covid/models/Utilisateurs.dart';
import 'package:client_covid/repos/Repos.dart';
import 'package:client_covid/widgets/MyBottomNavMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyRvPage extends StatelessWidget {
  late Utilisateur utilisateur;
  MyRvPage({required this.utilisateur});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mes rendez vous",
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ),
        actions: [
          CircleAvatar(
            radius: 30,
            child: Text(
              "${utilisateur.prenom.substring(0, 1)} ${utilisateur.nom.substring(0, 1)}",
              style:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
            ),
          )
        ],
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(left: 2, right: 2, top: 5),
            padding: EdgeInsets.all(10),
            height: 150,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.white30,
                      blurRadius: 20,
                      blurStyle: BlurStyle.outer)
                ],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: Radius.zero,
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 52, 1, 1),
                  Colors.red,
                  const Color.fromARGB(255, 53, 5, 5)
                ])),
            child: Text(
              textAlign: TextAlign.center,
              "Liste des rendez vous de ${utilisateur.prenom} ${utilisateur.nom}",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
          ),
          FutureBuilder(
            future: Repos().getRvOfUser(utilisateur.email),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SpinKitHourGlass(color: Colors.red);
              } else {
                List<RendezVous>? rendezvous = snapshot.data;
                return Expanded(
                  child: ListView.builder(
                      itemCount: (rendezvous == null ? 0 : rendezvous.length),
                      itemBuilder: (context, index) {
                        return Container(
                          transformAlignment: Alignment.bottomCenter,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red),
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(5),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "numero du rendez vous:",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      "${index + 1}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "type du rendez vous:",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text(
                                      "${rendezvous![index].typeRendezVous}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "date du rendez vous:",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text(
                                      "${rendezvous![index].date.day}/${rendezvous![index].date.month}/${rendezvous![index].date.year} à ${rendezvous![index].date.hour}: ${rendezvous![index].date.minute}:${rendezvous![index].date.second}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "structure de santé",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text(
                                      "${rendezvous[index].structure!.localisation}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                );
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavMenu(utilisateur: utilisateur),
    );
  }
}
