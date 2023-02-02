import "package:adaptive_theme/adaptive_theme.dart";
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
                      height: 70.0,
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
                      width: 10.0,
                    ),
                    FutureBuilder(
                        future: dbHelper.asyncInit(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text("${snapshot.data}");
                          }
                          if (snapshot.data == null) {
                            return const Text("Non connecte");
                          }
                          return const CircularProgressIndicator(
                            color: Colors.blue,
                          );
                        }),
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
                      child: Row(
                        children: const [
                          Icon(Icons.dark_mode,
                              color: Color.fromARGB(255, 255, 255, 255)),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Theme",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ));
                case 3:
                  return const Divider();
                case 4:
                  return OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Compte")));
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.key,
                              color: Color.fromARGB(255, 255, 255, 255)),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Compte",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ));
                case 5:
                  return const Divider();
                case 6:
                  return OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Aide")));
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.help_outlined,
                              color: Color.fromARGB(255, 255, 255, 255)),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Aide",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ));
                case 7:
                  return const Divider();
                case 8:
                  return OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Langue")));
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.language,
                              color: Color.fromARGB(255, 255, 255, 255)),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Langue",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
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
                      child: Row(
                        children: const [
                          Icon(Icons.warning,
                              color: Color.fromARGB(255, 255, 255, 255)),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Signaler un probleme",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ));
                default:
                  return null;
              }
            }));
  }
}
