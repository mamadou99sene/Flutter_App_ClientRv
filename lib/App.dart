import 'package:client_covid/providers/ProviderCovid.dart';
import 'package:client_covid/widgets/MyDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ProviderCovid(),
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
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
                    icon: Icon(Icons.logout))
              ],
            ),
            backgroundColor: Colors.red[400],
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(decoration: TextDecoration.underline),
          ),
          drawer: MyDrawer(),
          body: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 20,
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
                            "data",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        child: Text(("12")),
                      )
                    ],
                  ),
                );
              }),
        ));
  }
}
