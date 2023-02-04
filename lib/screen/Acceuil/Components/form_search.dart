import "package:flutter/material.dart";

class FormSearch extends StatefulWidget {
  const FormSearch({super.key});

  @override
  State<StatefulWidget> createState() => _FormSearch();
}

class _FormSearch extends State<FormSearch> {
  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.deepOrange,
      controller: search,
      keyboardType: TextInputType.text,
      enabled: true,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
            borderSide: BorderSide(
              color: Colors.orange,
              style: BorderStyle.solid,
            )),
        filled: true,
        suffixIcon: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        label: const Text("Que recherchez vous ?"),
        hintText: "Entrer le nom du produit",
      ),
    );
  }
}
