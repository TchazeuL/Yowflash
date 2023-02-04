import "package:flutter/material.dart";
import "package:yowflash/screen/Flasher/components/update_screeen.dart";

class Update extends StatelessWidget {
  const Update(
      {super.key,
      this.prix,
      this.name,
      this.description,
      this.docId,
      this.time});

  final String? name, prix, description, docId;
  final DateTime? time;
  @override
  Widget build(BuildContext context) {
    return FormUpdateScreen(
      docId: docId!,
      name: name,
      time: time,
      description: description,
      prix: prix,
    );
  }
}
