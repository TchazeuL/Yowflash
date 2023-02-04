import "package:flutter/material.dart";
import "package:yowflash/screen/Flashback/components/form_flashback.dart";

class FlashbackScreen extends StatelessWidget {
  const FlashbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: FormFlashback()),
    );
  }
}
