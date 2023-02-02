import "package:flutter/material.dart";

class Consult extends StatefulWidget {
  const Consult({super.key});

  @override
  State<StatefulWidget> createState() => _Consult();
}

class _Consult extends State<Consult> {
  final listTiles = <Widget>[
    const ListTile(
      title: Text("Categorie"),
      subtitle: Text("Telephone"),
    ),
    const Divider(),
    const ListTile(
      title: Text("Nom du produit"),
      subtitle: Text("IphoneXr"),
    ),
    const Divider(),
    const ListTile(
      title: Text("Prix"),
      subtitle: Text("160.000 XAF"),
    ),
    const Divider(),
    const ListTile(
      title: Text("Temps restant"),
      subtitle: Text("3 jours"),
    ),
    const Divider(),
    const ListTile(
      title: Text("Description"),
      subtitle: Text("Batterie 88% , capacite 128 Go, FaceID propre"),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        color: Colors.white,
        child: Column(children: [
          Image.asset('assets/Firebse.png'),
          const SizedBox(
            height: 18.0,
          ),
          ListView(
            children: listTiles,
          )
        ]),
      )
    ]);
  }
}
