import "package:flutter/material.dart";
import "package:yowflash/screen/Authentification/Signup/signup_screen.dart";

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<StatefulWidget> createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Vous n'avez pas de compte ?"),
        const SizedBox(width: 5.0),
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignUpScreen()));
            },
            child: const Text(
              "S'inscrire",
              style: TextStyle(
                   fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
