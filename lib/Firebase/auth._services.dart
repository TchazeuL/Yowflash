import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yowflash/model/user.dart';
import 'package:yowflash/widget/functions.dart';

class Authentication {
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool errorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case "user-not-found":
        error("Aucun utilisateur trouvé pour cet email.");
        return false;
      case "wrong-password":
        error("Adresse email ou Mot de passe incorrect");
        return false;
      case "weak-password":
        error("Le mot de passe doit contenir au moins 8 caracteres");
        return false;
      case "The email address is already in use by another account":
        error("L'adresse email existe deja pour un autre compte ");
        return false;
      default:
        error("Pas de connexion internet");
        return true;
    }
  }

  void verifier(String phone,
      {required Function(String verificationId, int? resendToken) onCodeSend,
      required Function(PhoneAuthCredential value) onAutoVerify,
      required Function(FirebaseAuthException value) onFailed,
      required Function(String value) autoRetrievial}) async {
    auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: onAutoVerify,
      verificationFailed: onFailed,
      codeSent: onCodeSend,
      timeout: const Duration(seconds: 59),
      codeAutoRetrievalTimeout: autoRetrievial,
    );
  }

  Future<void> validateOtp(String verificationId, String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    await auth.signInWithCredential(credential).then((value) async {
      done("Verification effectue avec succes");
    });
  }

  Future<void> deconnexion() async {
    await auth.signOut();
    done("deconnecte");
  }

  Future<bool> signUp(Users user) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      return false;
    }
  }

  Future<bool> signIn(Users user) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
