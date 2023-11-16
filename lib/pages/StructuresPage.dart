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
                  fontStyle: FontStyle.normal, fontWeight: FontWeight.normal),
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
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              color: Color.fromARGB(255, 251, 236, 237),
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount:
                      (listStructures == null ? 0 : listStructures.length),
                  itemBuilder: (context, index) {
                    return Container(
                      width: 150,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(5),
                      color: Colors.red,
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
                                    Navigator.pushNamed(context, "/rendezvous",
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
            );
          }
        },
      ),
    );
  }
}
