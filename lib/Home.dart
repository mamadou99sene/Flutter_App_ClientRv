import 'package:client_covid/App.dart';
import 'package:client_covid/models/Utilisateurs.dart';
import 'package:client_covid/pages/Inscription.dart';
import 'package:client_covid/pages/LoginPage.dart';
import 'package:client_covid/pages/PriseRendezVous.dart';
import 'package:client_covid/providers/ProviderCovid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ProviderCovid())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //home: App(),
        routes: {
          "/": (context) => loginPage(),
          "/home": (context) => App(
              utilisateur: Utilisateur(
                  idUtilisateur: 0,
                  prenom: "prenom",
                  nom: "nom",
                  email: "email",
                  phone: "phone",
                  password: "password")),
          "/inscription": (context) => Inscription(),
          "/rendezvous": (context) => PriseRendezVous(),
        },
        initialRoute: "/",
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
      ),
    );
  }
}
