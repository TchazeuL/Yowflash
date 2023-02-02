import "package:flutter/material.dart";
import "package:yowflash/screen/Authentification/Login/login_screen.dart";

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<StatefulWidget> createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Vous avez un compte ?"),
        const SizedBox(width: 5.0),
        TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: const Text(
              "S'identifier",
              style: TextStyle(fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
