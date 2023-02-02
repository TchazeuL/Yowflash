import "dart:async";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:hash/hash.dart";
import "package:otp_text_field/otp_text_field.dart";
import "package:yowflash/Firebase/auth._services.dart";
import "package:yowflash/model/user.dart";
import 'package:yowflash/widget/const.dart';
import "package:yowflash/screen/main_app_screen.dart";
import "package:yowflash/widget/functions.dart";
import "package:yowflash/database/database.dart";

class OtpForm extends StatefulWidget {
  const OtpForm(
      {super.key,
      required this.verificationId,
      required this.name,
      required this.email,
      required this.phone,
      required this.password});

  final String verificationId, email, phone, password;
  final String name;
  @override
  State<StatefulWidget> createState() => _OtpForm();
}

class _OtpForm extends State<OtpForm> {
  String smsCode = "";
  bool loading = false, resend = false, snack = false;
  int count = 59;
  final dbHelper = DbHelper();
  @override
  void initState() {
    super.initState();
    dbHelper.asyncInit();
    decompte();
  }

  late Timer timer;

  void decompte() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (count < 1) {
        timer.cancel();
        count = 59;
        resend = true;
        setState(() {});
        return;
      }
      count--;
      setState(() {});
    });
  }

  void onResendSms() {
    resend = false;
    setState(() {});
    Authentication().verifier(widget.phone,
        onCodeSend: (verificationId, resendToken) {
      loading = false;
      decompte();
      setState(() {});
    }, onAutoVerify: (val) async {
      await Authentication().auth.signInWithCredential(val);
    }, onFailed: (val) {
      error("Verification echouee");
    }, autoRetrievial: (val) {});
  }

  void onVerifyCode() async {
    loading = true;
    setState(() {});
    await Authentication()
        .validateOtp(widget.verificationId, smsCode)
        .then((value) {
      CollectionReference db =
          FirebaseFirestore.instance.collection("utilisateurs");
      User? users = FirebaseAuth.instance.currentUser;
      final Map<String, dynamic> user = {
        "uid": users?.uid,
        "name": widget.name,
        "email": widget.email,
        "phone": widget.phone,
        "password": widget.password
      };
      Users us = Users(
          name: user["name"],
          email: user["email"],
          phone: user["phone"],
          password: user["password"]);
      users?.delete();
      Authentication().signUp(us).then((value) {
        final u = FirebaseAuth.instance.currentUser;
        if (value == true) {
          db
              .doc(u!.uid)
              .set({
                "uid": u.uid,
                "name": user["name"],
                "email": user["email"],
                "phone": user["phone"],
                "password": SHA1()
                    .update([user["password"].hashCode])
                    .digest()
                    .toString()
              })
              .then((value) => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const BottomMenu())))
              .onError((error, stackTrace) => debugPrint("Echec de l'ajout"));

          dbHelper.insertUser({'id': 0, 'name': user["name"]});
        } else {
          loading = false;
          setState(() {});
          error("Echec de la verification");
        }
      });
    });
  }

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
            "Verification",
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50.0,
              ),
              const Text(
                "Entrer le code  qui vous a ete envoye par sms",
                style: TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              Container(padding: const EdgeInsets.all(18)),
              const SizedBox(
                height: 50.0,
              ),
              OTPTextField(
                length: 6,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 40,
                onChanged: (val) {
                  smsCode = val;
                  setState(() {});
                },
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 17),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                onCompleted: (pin) {
                  debugPrint("Completed: $pin");
                },
              ),
              const SizedBox(
                height: 30.0,
              ),
              const Text(
                "Vous n'avez pas recu code ?",
                style: TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 50.0,
              ),
              TextButton(
                  onPressed: () {
                    if (!resend) {
                      return;
                    } else {
                      onResendSms();
                    }
                  },
                  child: Text(
                    !resend
                        ? "00:${count.toString().padLeft(2, "0")}"
                        : "Renvoyer le Code",
                    textAlign: TextAlign.center,
                  )),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                style: buttonStyle,
                onPressed:
                    smsCode.length < 6 || loading == true ? null : onVerifyCode,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: loading == true
                      ? const CircularProgressIndicator(
                          backgroundColor: Color.fromARGB(255, 215, 215, 215),
                          valueColor: AlwaysStoppedAnimation(Colors.blue),
                        )
                      : const Text(
                          'Verifier',
                          style: TextStyle(fontSize: 20),
                        ),
                ),
              ),
            ],
          ),
        ));
  }
}
