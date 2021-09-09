import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CheckConnection {
  var status;
  Future checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        status = "Connected";
      }
    } on SocketException catch (_) {
      status = "There is no internet connection!";
      Fluttertoast.showToast(
          msg: status,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
