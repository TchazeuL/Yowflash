import "package:adaptive_theme/adaptive_theme.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_slidable/flutter_slidable.dart";
import "package:intl/intl.dart";
import "package:yowflash/database/database.dart";
import "package:yowflash/model/products.dart";
import "package:yowflash/widget/const.dart";

class ListFlash extends StatefulWidget {
  const ListFlash({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _ListFlash();
}

class _ListFlash extends State<ListFlash> {
  dynamic savedTheme;
  bool darkmode = false;
  final dbHelper = DbHelper();
  Future<List<Map<String, dynamic>>>? product;
  List<Products> produits = [];

  @override
  void initState() {
    super.initState();
    getCurrentTheme();
    dbHelper.asyncInit();
  }

  Future getCurrentTheme() async {
    savedTheme = await AdaptiveTheme.getThemeMode();
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

  @override
  Widget build(BuildContext context) {
    CollectionReference db = FirebaseFirestore.instance.collection("Produits");

    final user = FirebaseAuth.instance.currentUser;
    return FutureBuilder<QuerySnapshot>(
        future: user != null
            ? db.where("user_id", isEqualTo: user.uid).get()
            : null,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.size >= 1) {
            var doc = snapshot.data!.docs;
            List<Widget> itemToSlide() {
              List<Widget> slides = [
                const SizedBox(
                  height: 10.0,
                )
              ];
              for (int i = 0; i < snapshot.data!.size; i++) {
                var element = doc[i].data() as Map;
                var data = element;
                slides.add(Slidable(
                    endActionPane:
                        ActionPane(motion: const DrawerMotion(), children: [
                      SlidableAction(
                        onPressed: (context) {
                          // db.doc(user?.uid).update(data);
                        },
                        flex: 2,
                        backgroundColor:
                            const Color.fromARGB(255, 37, 129, 200),
                        foregroundColor: Colors.white,
                        icon: Icons.mode,
                        label: "Modifier",
                      ),
                      SlidableAction(
                        onPressed: (context) {
                          showDialog(
                              context: context,
                              builder: ((context) => AlertDialog(
                                      title: const Text(
                                        "Suppression",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 34, 156, 255)),
                                      ),
                                      content: const Text(
                                          "Etes vous sur de vouloir supprimer votre produits ?"),
                                      actions: [
                                        TextButton(
                                          child: const Text("Oui",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 34, 156, 255))),
                                          onPressed: () =>
                                              Navigator.pop(context, "oui"),
                                        ),
                                        TextButton(
                                          child: const Text("Non",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 34, 156, 255))),
                                          onPressed: () =>
                                              Navigator.pop(context, "non"),
                                        ),
                                      ]))).then((value) {
                            if (value == "oui") {
                              db.doc(user?.uid).delete();
                            }
                          });
                        },
                        flex: 2,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: "Supprimer",
                      )
                    ]),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 2,
                        padding: const EdgeInsets.all(10.0),
                        itemBuilder: (context, index) {
                          List<Widget> list = [
                            Row(children: [
                              CircleAvatar(
                                backgroundColor: darkmode == true
                                    ? kPrimaryColor
                                    : kPrimaryLightColor,
                                radius: 25.0,
                                child: Text(
                                  "${i + 1}",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "${data["name"]}",
                                      style: const TextStyle(fontSize: 18.0),
                                    ),
                                    Text(
                                      "Cree le ${DateFormat.yMMMd().format(DateTime.fromMillisecondsSinceEpoch(data["date"]))}",
                                      textAlign: TextAlign.start,
                                    )
                                  ]),
                            ]),
                            const Divider()
                          ];
                          if (index % 3 == 0) {
                            return list[0];
                          }

                          if (index - 1 % 3 == 0) {
                            return list[1];
                          }

                          return null;
                        })));
              }
              return slides;
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: itemToSlide(),
            );
          } else if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.size < 1 || !snapshot.hasData) {
            return const Center(
              child: Text("Aucune publication"),
              // OutlinedButton(
              //     style: ElevatedButton.styleFrom(
              //         foregroundColor: Colors.white,
              //         fixedSize: const Size(100, 60)),
              //     onPressed: () {
              //       // Navigator.pushReplacement(
              //       //     context,
              //       //     MaterialPageRoute(
              //       //         builder: (context) => build(context)));
              //     },
              //     child: const Text("Actualiser"))
            );
          } else if (user == null) {
            return const Center(
              child: Text("Vous n'etes pas connecte"),
            );
          }
          return const Center(
            child: Text("Probleme de connexion"),
          );
        });
  }
}
