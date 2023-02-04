import "package:adaptive_theme/adaptive_theme.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:yowflash/screen/Authentification/Login/login_screen.dart";
import "package:yowflash/widget/const.dart";
import "package:yowflash/widget/functions.dart";

class FormFlashback extends StatefulWidget {
  const FormFlashback({super.key});

  @override
  State<StatefulWidget> createState() => _FormFlashback();
}

class _FormFlashback extends State<FormFlashback> {
  final TextEditingController message = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool darkmode = false;
  bool messageValid = true;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getCurrentTheme();
  }

  Future getCurrentTheme() async {
    var savedTheme = await AdaptiveTheme.getThemeMode();
    if (savedTheme.toString() == "AdaptiveThemeMode.dark") {
      setState(() {
        darkmode = true;
      });
    } else {
      setState(() {
        darkmode = false;
      });
    }
  }

  void sendMessage() {
    final user = FirebaseAuth.instance.currentUser;
    if (formkey.currentState!.validate()) {
      loading = true;
      setState(() {});
      formkey.currentState!.save();
      if (messageValid == true || user != null) {
        CollectionReference db =
            FirebaseFirestore.instance.collection("messages");
        db.add({
          "uid": user?.uid,
          "message": message.text,
          "email": user?.email
        }).then((value) => done("Message envoye"));
        formkey.currentState!.save();
        loading = false;
        setState(() {});
      }
      if (user == null) {
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
                                color: Color.fromARGB(255, 4, 112, 185)))),
                    TextButton(
                        onPressed: () => Navigator.pop(context, "Ok"),
                        child: const Text("Ok",
                            style: TextStyle(
                                color: Color.fromARGB(255, 4, 112, 185)))),
                  ],
                )).then((value) {
          if (value == "Ok") {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const LoginScreen();
            }));
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formkey,
        child: Column(children: [
          TextFormField(
            controller: message,
            keyboardType: TextInputType.text,
            cursorColor: darkmode == true ? kPrimaryColor : kPrimaryLightColor,
            enabled: true,
            maxLength: 150,
            maxLines: 10,
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() => messageValid = true);
              } else {
                setState(() => messageValid = false);
              }
            },
            decoration: InputDecoration(
              border: UnderlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  borderSide: BorderSide(
                    color:
                        darkmode == true ? kPrimaryColor : kPrimaryLightColor,
                    style: BorderStyle.solid,
                  )),
              filled: true,
              prefixIcon: const Icon(Icons.message),
              label: const Text("Message"),
              hintText: "Alertez la communaute de ce que vous voulez",
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
              onPressed: (loading == false || messageValid == true)
                  ? sendMessage
                  : null,
              child: loading == true
                  ? const CircularProgressIndicator(
                      backgroundColor: Color.fromARGB(255, 215, 215, 215),
                      valueColor: AlwaysStoppedAnimation(Colors.blue))
                  : const Text("Valider"))
        ]));
  }
}
