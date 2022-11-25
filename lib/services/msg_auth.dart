import 'package:flutter/material.dart';

class MsgAuth {
  static GlobalKey<ScaffoldMessengerState> msgkey =
      GlobalKey<ScaffoldMessengerState>();

  static verSnackbar(String msg) {
    final snackbar = SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        msg,
        style: const TextStyle(color: Colors.white),
      ),
    );

    msgkey.currentState!.showSnackBar(snackbar);
  }
}
