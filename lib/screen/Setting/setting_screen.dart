import "package:adaptive_theme/adaptive_theme.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:yowflash/database/database.dart";

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingScreen();
}

class _SettingScreen extends State<SettingScreen> {
  final dbHelper = DbHelper();
  Future<String?>? username;
  CollectionReference db =
      FirebaseFirestore.instance.collection("utilisateurs");
  final users = FirebaseAuth.instance.currentUser;
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
            "Parametres",
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(10.0),
            shrinkWrap: true,
            itemCount: 11,
            itemBuilder: (context, i) {
              switch (i) {
                case 0:
                  return Column(children: [
                    const SizedBox(
                      height: 60.0,
                    ),
                    const CircleAvatar(
                        radius: 45.0,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundColor: Color(0xffE6E6E6),
                          radius: 43.0,
                          child: Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 84, 139, 146),
                          ),
                        )),
                    const SizedBox(
                      width: 15.0,
                    ),
                    users == null
                        ? const Text("Pas de connexion")
                        : Text("${users?.email}"),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ]);
                case 1:
                  return const Divider();
                case 2:
                  return OutlinedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: ((context) => SimpleDialog(
                                  title: const Text(
                                    "Theme",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 34, 156, 255)),
                                  ),
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.dark_mode,
                                          color:
                                              Color.fromARGB(255, 4, 112, 185)),
                                      title: const Text("Mode sombre"),
                                      onTap: () =>
                                          Navigator.pop(context, "sombre"),
                                    ),
                                    const Divider(),
                                    ListTile(
                                      leading: const Icon(Icons.sunny,
                                          color:
                                              Color.fromARGB(255, 4, 112, 185)),
                                      title: const Text("Mode clair"),
                                      onTap: () =>
                                          Navigator.pop(context, "clair"),
                                    ),
                                    const Divider(),
                                    ListTile(
                                      leading: const Icon(Icons.system_update,
                                          color:
                                              Color.fromARGB(255, 4, 112, 185)),
                                      title: const Text("Systeme"),
                                      onTap: () =>
                                          Navigator.pop(context, "system"),
                                    )
                                  ],
                                ))).then((value) {
                          if (value == "sombre") {
                            AdaptiveTheme.of(context).setDark();
                          } else if (value == "clair") {
                            AdaptiveTheme.of(context).setLight();
                          } else {
                            AdaptiveTheme.of(context).setSystem();
                          }
                        });
                      },
                      child: const ListTile(
                        leading: Icon(Icons.dark_mode,
                            color: Color.fromARGB(255, 255, 255, 255)),
                        title: Text(
                          "Theme",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ));
                case 3:
                  return const Divider();
                case 4:
                  return OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Compte")));
                      },
                      child: const ListTile(
                        leading: Icon(Icons.language,
                            color: Color.fromARGB(255, 255, 255, 255)),
                        title: Text(
                          "Langue",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ));
                case 5:
                  return const Divider();
                case 6:
                  return OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Compte")));
                      },
                      child: const ListTile(
                        leading: Icon(Icons.key,
                            color: Color.fromARGB(255, 255, 255, 255)),
                        title: Text(
                          "Compte",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ));
                case 7:
                  return const Divider();
                case 8:
                  return OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Aide")));
                      },
                      child: const ListTile(
                        leading: Icon(Icons.help,
                            color: Color.fromARGB(255, 255, 255, 255)),
                        title: Text(
                          "Aide",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ));
                case 9:
                  return const Divider();
                case 10:
                  return OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Signaler un probleme")));
                      },
                      child: const ListTile(
                        leading: Icon(Icons.warning,
                            color: Color.fromARGB(255, 255, 255, 255)),
                        title: Text(
                          "Signaler un probleme",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ));
                default:
                  return null;
              }
            }));
  }
}
