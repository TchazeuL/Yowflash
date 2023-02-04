import "package:flutter/material.dart";
import "package:yowflash/screen/Categories/categorie_screen.dart";
import "package:yowflash/widget/const_image.dart";

class ListCategories extends StatelessWidget {
  const ListCategories({super.key});

  static const categorie = <String>[
    "Telephone",
    "Livre",
    "Ordinateur",
    "Chaussure",
    "Montre",
    "Ecouteur",
    "Television",
    "Refrigerateur",
    "Modem"
  ];

  @override
  Widget build(BuildContext context) {
    Widget? buildCard(String type) {
      return Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Column(children: [
          const SizedBox(
            height: 60.0,
          ),
          SizedBox(
            width: 100,
            height: 100.0,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Positioned.fill(child: image[type]!),
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
                    type,
                    style: const TextStyle(
                      fontFamily: AutofillHints.name,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                      width: 150.0,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Categorie(
                                        categorie: type,
                                      )));
                        },
                        child: const Text(
                          "Rechercher",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )),
                ],
              )
            ],
          )
        ]),
      );
    }

    return GridView.count(
        crossAxisCount: 1,
        children: List.generate(
            categorie.length,
            (index) => Column(mainAxisSize: MainAxisSize.max, children: [
                  Center(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: buildCard(categorie[index])),
                  ),
                ])));
  }
}
