import 'package:client_covid/providers/ProviderCovid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class loginPage extends StatelessWidget {
  const loginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerEmail = TextEditingController();
    TextEditingController controllerPassword = TextEditingController();
    String email = "";
    String password = "";
    return ChangeNotifierProvider(
      create: (context) => ProviderCovid(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Login",
            style: TextStyle(
                fontSize: 30,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal),
          ),
          centerTitle: true,
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: controllerEmail,
                onTap: () {},
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            width: 1,
                            style: BorderStyle.solid,
                            color: Colors.red))),
              )),
          Container(
              padding: const EdgeInsets.all(10),
              child: Consumer<ProviderCovid>(
                builder: (context, value, child) {
                  return TextFormField(
                    controller: controllerPassword,
                    obscureText: value.visibility,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              Provider.of<ProviderCovid>(context, listen: false)
                                  .change_Visibility();
                              Provider.of<ProviderCovid>(context, listen: false)
                                  .changeIcon();
                            },
                            icon: value.icon),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              width: 1,
                              style: BorderStyle.solid,
                              color: Colors.red,
                            ))),
                  );
                },
              )),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                ),
                onPressed: () {
                  //print("Email: ${controllerEmail.text}");
                  //print("Password:${controllerPassword.text}");
                  email = controllerEmail.text;
                  password = controllerPassword.text;
                  if (email.trim() == "sene" && password.trim() == "momo") {
                    Navigator.pushNamed(context, "/home");
                  }
                },
                child: const Text(
                  "Connexion",
                  style: TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal),
                )),
          )
        ]),
      ),
    );
  }
}
