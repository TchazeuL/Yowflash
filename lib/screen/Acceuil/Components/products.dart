import "package:adaptive_theme/adaptive_theme.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:yowflash/screen/Acceuil/consulter_screen.dart";
import "package:yowflash/widget/const_image.dart";

class ListProducts extends StatefulWidget {
  const ListProducts({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _ListProducts();
}

class _ListProducts extends State<ListProducts> {
  dynamic savedTheme;
  bool darkmode = false;

  @override
  void initState() {
    super.initState();
    getCurrentTheme();
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
    CollectionReference db =
        FirebaseFirestore.instance.collection("Publications");

    final user = FirebaseAuth.instance.currentUser;
    return FutureBuilder<QuerySnapshot>(
        future: user == null
            ? db.get()
            : db.where("uid", isNotEqualTo: user.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.size >= 1) {
            var doc = snapshot.data!.docs;
            List<Card> itemToCard() {
              List<Card> card = [];
              for (int i = 0; i < snapshot.data!.size; i++) {
                var data = doc[i].data() as Map;
                card.add(Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  child: Column(children: [
                    const SizedBox(
                      height: 60.0,
                    ),
                    SizedBox(
                      width: 100,
                      height: 160.0,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Positioned.fill(
                            child: image["${data["categorie"]}"]!
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    ButtonBar(
                      buttonPadding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                      mainAxisSize: MainAxisSize.max,
                      alignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 30.0,
                            ),
                            Text(
                              "${data["name"]}",
                              style: const TextStyle(
                                fontFamily: AutofillHints.name,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "${data["prix"]} XAF",
                              style: const TextStyle(
                                  fontFamily: AutofillHints.name,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Color.fromARGB(255, 4, 112, 185)),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              (DateTime.fromMillisecondsSinceEpoch(data["date"])
                                          .difference(DateTime.now())
                                          .inSeconds <
                                      3600)
                                  ? (DateTime.fromMillisecondsSinceEpoch(
                                                  data["date"])
                                              .difference(DateTime.now())
                                              .inMinutes <
                                          60)
                                      ? (DateTime.fromMillisecondsSinceEpoch(
                                                      data["date"])
                                                  .difference(DateTime.now())
                                                  .inHours <
                                              24)
                                          ? ("Temps restants : ${DateTime.fromMillisecondsSinceEpoch(data["date"]).difference(DateTime.now()).inSeconds} secondes")
                                          : ("Temps restants : ${DateTime.fromMillisecondsSinceEpoch(data["date"]).difference(DateTime.now()).inMinutes} minutes")
                                      : ("Temps restants : ${DateTime.fromMillisecondsSinceEpoch(data["date"]).difference(DateTime.now()).inHours} heures")
                                  : ("Temps restants : ${DateTime.fromMillisecondsSinceEpoch(data["date"]).difference(DateTime.now()).inDays} jours"),
                              style: const TextStyle(
                                fontFamily: AutofillHints.name,
                                // fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ConsulterScreen(
                                              name: data["name"],
                                              categorie: data["categorie"],
                                              prix: data["prix"],
                                              description: data["description"],
                                              time: (DateTime.fromMillisecondsSinceEpoch(data["date"])
                                                          .difference(
                                                              DateTime.now())
                                                          .inSeconds <
                                                      3600)
                                                  ? (DateTime.fromMillisecondsSinceEpoch(data["date"]).difference(DateTime.now()).inMinutes <
                                                          60)
                                                      ? (DateTime.fromMillisecondsSinceEpoch(data["date"]).difference(DateTime.now()).inHours <
                                                              24)
                                                          ? DateTime.fromMillisecondsSinceEpoch(data["date"])
                                                              .difference(
                                                                  DateTime
                                                                      .now())
                                                              .inSeconds
                                                          : DateTime.fromMillisecondsSinceEpoch(data["date"])
                                                              .difference(
                                                                  DateTime
                                                                      .now())
                                                              .inMinutes
                                                      : DateTime.fromMillisecondsSinceEpoch(
                                                              data["date"])
                                                          .difference(
                                                              DateTime.now())
                                                          .inHours
                                                  : DateTime.fromMillisecondsSinceEpoch(
                                                          data["date"])
                                                      .difference(DateTime.now())
                                                      .inDays,
                                              email: data["email"],
                                              phone: data["phone"],
                                            )));
                              },
                              child: const Text(
                                "Consulter",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ]),
                ));
              }
              return card;
            }

            return Column(
              children: itemToCard().length > 3
                  ? [itemToCard()[0], itemToCard()[1], itemToCard()[2]]
                  : itemToCard(),
            );
          } else if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.size < 1 || !snapshot.hasData) {
            return const Center(
              child: Text("Aucune publication"),
            );
          }
          return const Center(
            child: Text("Probleme de connexion"),
          );
        });
  }
}
