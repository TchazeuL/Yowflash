import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:yowflash/screen/Flash/consult_screen.dart";
import "package:yowflash/widget/const_image.dart";

class Categorie extends StatelessWidget {
  const Categorie({super.key, required this.categorie});
  final String categorie;
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    CollectionReference db =
        FirebaseFirestore.instance.collection("Publications");
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
          title:  Text(
            categorie,
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
      ),
      body: Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0) , child: FutureBuilder<QuerySnapshot>(
        future: db.where("uid", isNotEqualTo: user?.uid).where("categorie", isEqualTo: categorie).get(),
        builder: (context, snapshot) {
          var connection = snapshot.connectionState;
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
                              child: image["${data["categorie"]}"]!),
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
                                        builder: (context) => ConsultScreen(
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
                if (DateTime.fromMillisecondsSinceEpoch(data["date"])
                        .difference(DateTime.now())
                        .inSeconds <=
                    0) {
                  db.doc(doc[i].id).delete();
                  card.remove(card[i]);
                }
              }

              return card;
            }

            return DefaultTabController(
                length: snapshot.data!.size,
                child: Builder(
                    builder: (context) => Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const TabPageSelector(
                              selectedColor: Color.fromARGB(255, 4, 112, 185),
                            ),
                            const SizedBox(height: 100.0),
                            Expanded(
                                child: IconTheme(
                              data: const IconThemeData(
                                  size: 128.0, color: Colors.deepOrange),
                              child: TabBarView(children: itemToCard()),
                            ))
                          ],
                        ))));
          } else if (connection != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.size == 0) {
            return const Center(child: Text("Aucune publication"));
          }
          return const Center(
            child: Text("Probleme de connexion"),
          );
        })));
  }
}
