import "package:flutter/material.dart";
import "package:yowflash/screen/Authentification/Login/components/form.dart";
import "package:yowflash/screen/Authentification/Login/components/or_divider.dart";
import "package:yowflash/screen/Authentification/Login/components/signup.dart";

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 30.0,
            ),
          ),
          title: const Text(
            "Connexion",
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        body: Center(
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 8,
                  padding: const EdgeInsets.all(20.0),
                  itemBuilder: ((context, index) {
                    switch (index) {
                      case 0:
                        return const SizedBox(
                          height: 30.0,
                        );
                      case 1:
                        return const SignInForm();
                      case 2:
                        return const SizedBox(
                          height: 30.0,
                        );
                      case 3:
                        return const OrDivider();
                      case 4:
                        return const SizedBox(
                          height: 20.0,
                        );
                      case 5:
                        return TextButton(
                            onPressed: () {},
                            child: const Text("Mot de passe oublie ?",
                                style: TextStyle(fontWeight: FontWeight.bold)));
                      case 6:
                        return const SizedBox(
                          height: 20.0,
                        );
                      default:
                        return const SignUp();
                    }
                  })),
            ],
          ),
        ));
  }
}
