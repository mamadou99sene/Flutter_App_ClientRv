import 'package:client_covid/App.dart';
import 'package:client_covid/models/Utilisateurs.dart';
import 'package:client_covid/pages/MyRvPage.dart';
import 'package:client_covid/pages/StructuresPage.dart';
import 'package:client_covid/providers/ProviderCovid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBottomNavMenu extends StatelessWidget {
  late Utilisateur utilisateur;
  static int selectedMenu = 0;
  MyBottomNavMenu({required this.utilisateur});
  @override
  Widget build(BuildContext context) {
    void onItemMenuSelected(int index) {
      final provider = Provider.of<ProviderCovid>(context, listen: false);
      selectedMenu = index;
      switch (selectedMenu) {
        case 0:
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => App(utilisateur: utilisateur)));
            provider.changeColorItemSelected();
          }
        case 1:
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyRvPage(utilisateur: utilisateur)));
            provider.changeColorItemSelected();
          }
        case 2:
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StructuresPage(
                          utilisateur: utilisateur,
                        )));
            provider.changeColorItemSelected();
          }
        case 3:
          {
            Navigator.pop(context);
            provider.changeColorItemSelected();
          }
      }
    }

    return Container(
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: Colors.red),
              bottom: BorderSide(color: Colors.red))),
      child: Consumer<ProviderCovid>(
        builder: (context, value, child) {
          return BottomNavigationBar(
            selectedItemColor: value.color,
            unselectedItemColor: Colors.grey,
            elevation: 10,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "accueil"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.meeting_room), label: "rendez vous"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.local_hospital), label: "structures"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.logout), label: "deconnexion")
            ],
            currentIndex: selectedMenu,
            onTap: onItemMenuSelected,
          );
        },
      ),
    );
  }
}
