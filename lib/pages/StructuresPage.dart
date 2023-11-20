import 'package:client_covid/models/StructureDeSante.dart';
import 'package:client_covid/models/StructureXML.dart';
import 'package:client_covid/providers/ProviderCovid.dart';
import 'package:client_covid/widgets/MyButtonStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class StructuresPage extends StatelessWidget {
  const StructuresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Nos Structures de santé",
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
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
        titleTextStyle: const TextStyle(decoration: TextDecoration.underline),
      ),
      body: FutureBuilder(
        future: ProviderCovid().getStructuresXML(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SpinKitHourGlass(
              color: Colors.red,
              size: 100,
            );
          } else if (snapshot.hasError) {
            return Text(
              "Internet error",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
            );
          } else {
            List<StructureXML>? listStructures = snapshot.data;
            return Container(
              padding: EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(left: 0, right: 0, top: 1),
                    padding: EdgeInsets.all(20),
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
                            bottomRight: Radius.elliptical(200, 75),
                            bottomLeft: Radius.elliptical(200, 100)),
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 52, 1, 1),
                          Colors.red,
                          const Color.fromARGB(255, 53, 5, 5)
                        ])),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Liste  de nos structures de santé",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: (listStructures == null
                            ? 0
                            : listStructures.length),
                        itemBuilder: (context, index) {
                          return Container(
                            height: 100,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white30,
                                      blurRadius: 20,
                                      blurStyle: BlurStyle.outer)
                                ],
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20)),
                                gradient: LinearGradient(colors: [
                                  Color.fromARGB(255, 100, 11, 11),
                                  Colors.red,
                                  const Color.fromARGB(255, 53, 5, 5)
                                ])),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${listStructures![index].localisation}: ",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "${listStructures[index].capacite} places",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    MyButtonStyle(
                                        text: "prendre rendez vous",
                                        pressed: () {
                                          Navigator.pop(context);
                                          Navigator.pushNamed(
                                              context, "/rendezvous",
                                              arguments: listStructures[index]);
                                        })
                                  ],
                                )
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
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
