import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_slidable/flutter_slidable.dart";

class ListNotification extends StatelessWidget {
  const ListNotification({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference db = FirebaseFirestore.instance.collection("messages");
    final users = FirebaseAuth.instance.currentUser;

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
            "Notifications",
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
            future: db.where("uid", isNotEqualTo: "${users?.uid}").get(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.size >= 1) {
                var doc = snapshot.data!.docs;
                List<Widget> itemToList() {
                  List<Widget> list = [];
                  for (int i = 0; i < snapshot.data!.size; i++) {
                    var data = doc[i].data() as Map;
                    list.add(Slidable(
                        endActionPane:
                            ActionPane(motion: const DrawerMotion(), children: [
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
                                  db
                                      .doc(doc[i].id)
                                      .delete()
                                      .then((value) => list.remove(list[i]));
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
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(255, 22, 119, 198),
                            radius: 25.0,
                            child: Text(
                              "${i + 1}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(data["email"]),
                          subtitle: Text(data["message"]),
                          trailing: const Icon(
                            Icons.message,
                            color: Color.fromARGB(255, 22, 119, 198),
                          ),
                        )));
                  }
                  return list;
                }

                return ListView.builder(
                    itemCount: 1,
                    itemBuilder: ((context, index) => Column(
                          children: itemToList(),
                        )));
              } else if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.size == 0) {
                return const Center(child: Text("Aucun message"));
              }
              return const Center(
                child: Text("Probleme de connexion"),
              );
            }));
  }
}
