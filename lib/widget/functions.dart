import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";

error(String? msg) {
  Fluttertoast.showToast(
      msg: msg ?? "Error",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: const Color.fromARGB(255, 245, 53, 40),
      textColor: Colors.white,
      webBgColor: "linear-gradient(to right, #FF1C1C, #FF1C1C)",
      webPosition: "center",
      fontSize: 20.0);
}

done(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      webBgColor: "linear-gradient(to right, #0078ED, #0078ED)",
      webPosition: "center",
      fontSize: 20.0);
}
