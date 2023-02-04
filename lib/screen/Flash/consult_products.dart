import 'package:adaptive_theme/adaptive_theme.dart';
import "package:flutter/material.dart";
import 'package:yowflash/widget/const.dart';
import "package:url_launcher/url_launcher.dart";

class ConsultProducts extends StatefulWidget {
  const ConsultProducts(
      {super.key,
      required this.categorie,
      required this.name,
      required this.prix,
      required this.time,
      required this.description,
      required this.phone,
      this.email});
  final String categorie, prix, name, description;
  final String? email, phone;
  final int? time;

  @override
  State<StatefulWidget> createState() => _ConsultProducts();
}

class _ConsultProducts extends State<ConsultProducts> {
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

  Future<void> _launch(Uri uri) async {
    if (!await launchUrl(uri)) {
      throw Exception("Lancement impossible");
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Uri> url = {
      "call": Uri.parse("tel:${widget.phone}"),
      "sms": Uri.parse("sms:${widget.phone}"),
      "mail": Uri.parse("mailto:${widget.email}")
    };
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
                  Text(
                    widget.categorie,
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
                  Text(
                    widget.name,
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
                  Text(
                    "${widget.prix} XAF",
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
                  Text(widget.time != 0
                      ? "${widget.time} jours"
                      : "Aujourd'hui"),
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
                  Text(
                    widget.description,
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
                  TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: ((context) => SimpleDialog(
                                  title: const Text(
                                    "Choisir",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 34, 156, 255)),
                                  ),
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.phone,
                                          color:
                                              Color.fromARGB(255, 4, 112, 185)),
                                      title: const Text("Appel"),
                                      onTap: () =>
                                          Navigator.pop(context, "call"),
                                    ),
                                    const Divider(),
                                    ListTile(
                                      leading: const Icon(Icons.sms,
                                          color:
                                              Color.fromARGB(255, 4, 112, 185)),
                                      title: const Text("Message"),
                                      onTap: () =>
                                          Navigator.pop(context, "sms"),
                                    ),
                                    const Divider(),
                                  ],
                                ))).then((value) {
                          if (value == "call") {
                            _launch(url["call"]!);
                          }
                          if (value == "sms") {
                            _launch(url["sms"]!);
                          }
                        });
                      },
                      child: Text("${widget.phone}")),
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
                  TextButton(
                      onPressed: () => _launch(url["mail"]!),
                      child: Text("${widget.email}")),
                ])
              ])
        ]));
  }
}
