import 'package:client_covid/App.dart';
import 'package:client_covid/models/Utilisateurs.dart';
import 'package:client_covid/pages/MyRvPage.dart';
import 'package:client_covid/pages/StructuresPage.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  Utilisateur utilisateur;
  MyDrawer({
    required this.utilisateur,
  });
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: ListView(children: [
        DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 52, 1, 1),
              Colors.red,
              Colors.white
            ])),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("images/logo.jpg"),
                  backgroundColor: Colors.red[300],
                  radius: 50,
                ),
                Text(
                  "${utilisateur.prenom} ${utilisateur.nom}",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      color: Colors.white),
                )
              ],
            )),
        ListTile(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => App(utilisateur: utilisateur)));
          },
          leading: Icon(
            Icons.home,
            color: Colors.red,
          ),
          trailing: Icon(
            Icons.arrow_right,
            color: Colors.red,
          ),
          title: Text(
            "Home",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800),
          ),
        ),
        const Divider(
          height: 5,
          color: Colors.red,
        ),
        ListTile(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyRvPage(utilisateur: utilisateur)));
          },
          leading: Icon(
            Icons.meeting_room,
            color: Colors.red,
          ),
          trailing: Icon(
            Icons.arrow_right,
            color: Colors.red,
          ),
          title: Text(
            "Rendez vous",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800),
          ),
        ),
        const Divider(
          height: 5,
          color: Colors.red,
        ),
        ListTile(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StructuresPage(
                          utilisateur: utilisateur,
                        )));
          },
          leading: Icon(
            Icons.local_hospital,
            color: Colors.red,
          ),
          trailing: Icon(
            Icons.arrow_right,
            color: Colors.red,
          ),
          title: Text(
            "structure de santé",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800),
          ),
        )
      ]),
    );
  }
}
