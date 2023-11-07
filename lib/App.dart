import 'dart:convert';

import 'package:client_covid/models/StructureDeSante.dart';
import 'package:client_covid/models/StructureXML.dart';
import 'package:client_covid/providers/ProviderCovid.dart';
import 'package:client_covid/widgets/MyDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  String prenom;
  String nom;
  App({
    required this.prenom,
    required this.nom,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ProviderCovid(),
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Bienvenu(e)",
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
          drawer: MyDrawer(prenom: prenom, nom: nom),
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
                List<StructureXML>? list = snapshot.data;
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: (list == null ? 0 : list.length),
                    itemBuilder: (context, index) {
                      return ListTile(
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
                      );
                    });
              } else {
                return Container();
              }
            },
          ),
        ));
  }
}
