import 'package:client_covid/App.dart';
import 'package:client_covid/pages/Inscription.dart';
import 'package:client_covid/pages/LoginPage.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: App(),
      routes: {
        "/": (context) => loginPage(),
        "/home": (context) => App(prenom: "prenom", nom: "nom"),
        "/inscription": (context) => Inscription(),
      },
      initialRoute: "/",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}
