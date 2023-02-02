import "package:flutter/material.dart";

class BackFromConsult extends StatefulWidget {
  const BackFromConsult({super.key});

  @override
  State<StatefulWidget> createState() => _BackFromConsult();
}

class _BackFromConsult extends State<BackFromConsult> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 30.0,
              ),
            ),
            const SizedBox(width: 60.0),
            const Text(
              "Produit",
              style: TextStyle(
                fontSize: 35,
                color: Colors.deepOrange,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ));
  }
}
