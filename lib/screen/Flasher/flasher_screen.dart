import "package:flutter/material.dart";
import "package:yowflash/screen/Flasher/components/form_screen.dart";

class FlasherScreen extends StatelessWidget {
  const FlasherScreen({super.key, this.phone});
  final String? phone;
  @override
  Widget build(BuildContext context) {
    return FormFlasherScreen(
      phone: "$phone",
    );
  }
}
