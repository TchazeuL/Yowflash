import "package:adaptive_theme/adaptive_theme.dart";
import "package:flutter/material.dart";
import "package:yowflash/screen/Acceuil/consulter_screen.dart";
import "package:yowflash/widget/const.dart";

class ListProducts extends StatefulWidget {
  const ListProducts({super.key});

  @override
  State<StatefulWidget> createState() => _ListProducts();
}

class _ListProducts extends State<ListProducts> {
  dynamic savedTheme;
  bool darkmode = false;

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
          height: 160.0,
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
            Column(
              children: [
                const SizedBox(height: 30.0),
                const Text(
                  "Iphone Xr",
                  style: TextStyle(
                    fontFamily: AutofillHints.name,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  "160.000 XAF",
                  style: TextStyle(
                      fontFamily: AutofillHints.name,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: darkmode == true
                          ? kPrimaryColor
                          : kPrimaryLightColor),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                const Text(
                  "Temps restants : 2 jours",
                  style: TextStyle(
                    fontFamily: AutofillHints.name,
                    // fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ConsulterScreen()));
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
    );
  }
}
