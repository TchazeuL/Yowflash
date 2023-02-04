import "package:flutter/material.dart";

import "package:yowflash/screen/Acceuil/Components/form_search.dart";
import "package:yowflash/screen/Acceuil/Components/products.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: const [
        Padding(padding: EdgeInsets.all(25.0)),
        SizedBox(width: 350.0, child: FormSearch()),
        SizedBox(
          height: 30.0,
        ),
        Text(
          "Produits a la une",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10.0,
        ),
        SizedBox(
          width: 350,
          child: ListProducts(),
        ),
      ],
    ));
  }
}
