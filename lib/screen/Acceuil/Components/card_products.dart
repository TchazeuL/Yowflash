import 'package:adaptive_theme/adaptive_theme.dart';
import "package:flutter/material.dart";
import 'package:yowflash/widget/const.dart';

class CardProducts extends StatefulWidget {
  const CardProducts({super.key});

  @override
  State<StatefulWidget> createState() => _CardProducts();
}

class _CardProducts extends State<CardProducts> {
  bool darkmode = false;
  dynamic savedTheme;

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
    return Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Column(children: [
          SizedBox(
            width: 100,
            height: 300.0,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/Firebse.png',
                  ),
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
                Column(children: [
                  Text("Categories",
                      style: TextStyle(
                          color: darkmode == true
                              ? kPrimaryColor
                              : kPrimaryLightColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0)),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Text(
                    "Telephone",
                  ),
                  const Divider(),
                  Text("Nom",
                      style: TextStyle(
                          color: darkmode == true
                              ? kPrimaryColor
                              : kPrimaryLightColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0)),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Text(
                    "IPhone Xr",
                  ),
                  const Divider(),
                  Text("Prix",
                      style: TextStyle(
                          color: darkmode == true
                              ? kPrimaryColor
                              : kPrimaryLightColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0)),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Text(
                    "160.000 XAF",
                  ),
                  const Divider(),
                  Text("Temps restants",
                      style: TextStyle(
                          color: darkmode == true
                              ? kPrimaryColor
                              : kPrimaryLightColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0)),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Text("2 jours"),
                  const Divider(),
                  Text("Description",
                      style: TextStyle(
                          color: darkmode == true
                              ? kPrimaryColor
                              : kPrimaryLightColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0)),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Text(
                    "Batterie 88% , capacite 128 Go, FaceID propre",
                  ),
                  const Divider(),
                  Text("Telephone vendeur",
                      style: TextStyle(
                          color: darkmode == true
                              ? kPrimaryColor
                              : kPrimaryLightColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0)),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Text("+237 690919555"),
                  const Divider(),
                  Text("Adresse email",
                      style: TextStyle(
                          color: darkmode == true
                              ? kPrimaryColor
                              : kPrimaryLightColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0)),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Text("loicmeyong17@gmail.com"),
                ])
              ])
        ]));
  }
}
