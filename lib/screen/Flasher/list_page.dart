import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:yowflash/screen/Authentification/Login/login_screen.dart";
import "package:yowflash/screen/Flasher/components/button_add.dart";
import "package:yowflash/screen/Flasher/number_screen.dart";

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
                child: Column(
          children: const [ListFlash()],
        ))),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (user != null) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NumberScreen()));
            } else {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text("Vous n'etes pas connecte"),
                        content: const Text(
                            "Connecte vous a votre compte avant de publier un produit"),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context, "Cancel"),
                              child: const Text("Cancel",
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 4, 112, 185)))),
                          TextButton(
                              onPressed: () => Navigator.pop(context, "Ok"),
                              child: const Text("Ok",
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 4, 112, 185)))),
                        ],
                      )).then((value) {
                if (value == "Ok") {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const LoginScreen();
                  }));
                }
              });
            }
          },
          elevation: 10.0,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 30.0,
          ),
        ));
  }
}
