import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

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
            future: users?.uid != null ? db.where("uid", isNotEqualTo: users?.uid).get():db.get(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.size >= 1) {
                var doc = snapshot.data!.docs;
                List<ListTile> itemToList() {
                  List<ListTile> list = [];
                  for (int i = 0; i < snapshot.data!.size; i++) {
                    var data = doc[i].data() as Map;
                    list.add(ListTile(
                      leading: CircleAvatar(
                        backgroundColor:const Color.fromARGB(255, 22, 119, 198) ,
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
                    ));
                  }
                  return list;
                }

                return ListView.builder(
                    itemCount: snapshot.data!.size,
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
