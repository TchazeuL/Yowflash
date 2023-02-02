import 'package:flutter/material.dart';
import 'package:yowflash/screen/Flasher/components/form_flash.dart';

class FormFlasherScreen extends StatelessWidget {
  const FormFlasherScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 30.0,
            ),
          ),
          title: const Text(
            "Publication",
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        body: Center(
          child: Column(children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: 2,
              padding: const EdgeInsets.all(20.0),
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return const SizedBox(
                      height: 10.0,
                    );

                  default:
                    return const FormFlasher();
                }
              },
            ),
          ]),
        ));
  }
}
