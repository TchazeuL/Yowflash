import 'package:flutter/material.dart';

const categorie = <dynamic>["Telephone", "Papier", "Chaussure"];
const prix = <dynamic>["100", "200", "300"];
final duree = <dynamic>["1 jour", "2 jours", "3 jours"];
const color = Color.fromARGB(137, 13, 13, 13);

const kPrimaryColor = Color.fromRGBO(0, 109, 91, 0.835);
const kPrimaryLightColor = Colors.orange;
const lightColor = Color.fromRGBO(255, 255, 255, 0.835);
const blackColor = Color.fromRGBO(0, 0, 0, 0.835);
const cardcolor = Color.fromARGB(197, 28, 28, 28);
const greyColor = Color.fromARGB(146, 214, 219, 230);

ButtonStyle buttonStyle = ElevatedButton.styleFrom(
  backgroundColor: kPrimaryLightColor,
  elevation: 4.0,
  shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(50.0))),
  fixedSize: const Size(350.0, 50),
);

IconButton back(BuildContext context) {
  return IconButton(
    onPressed: () {
      Navigator.of(context).pop();
    },
    icon: const Icon(
      Icons.arrow_back_ios,
      size: 30.0,
    ),
  );
}

const style = TextStyle(
    color: Colors.deepOrange,
    fontFamily: AutofillHints.name,
    fontWeight: FontWeight.bold,
    fontSize: 18);

ButtonStyle buttonStyleDark = ElevatedButton.styleFrom(
  backgroundColor: kPrimaryColor,
  elevation: 4.0,
  shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(50.0))),
  fixedSize: const Size(350.0, 50),
);
