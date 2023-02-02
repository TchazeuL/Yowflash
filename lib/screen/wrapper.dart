import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yowflash/screen/Acceuil/introduction_screen.dart';
import 'package:yowflash/screen/main_app_screen.dart';

class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return user == null ? Introscreen() : const BottomMenu();
  }
}
