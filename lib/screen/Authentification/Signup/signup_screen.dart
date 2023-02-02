import "package:flutter/material.dart";
import "package:yowflash/screen/Authentification/Login/components/or_divider.dart";
import "package:yowflash/screen/Authentification/Signup/components/form.dart";
import "package:yowflash/screen/Authentification/Signup/components/signin.dart";

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
            "Inscription",
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        body: Center(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: 6,
                padding: const EdgeInsets.all(20.0),
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return const SizedBox(
                        height: 10.0,
                      );

                    case 1:
                      return const SignUpForm();
                    case 2:
                      return const SizedBox(
                        height: 10.0,
                      );
                    case 3:
                      return const OrDivider();
                    case 4:
                      return const SizedBox(
                        height: 10.0,
                      );
                    default:
                      return const SignIn();
                  }
                },
              ),
            ],
          ),
        ));
  }
}
