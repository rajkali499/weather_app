import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showSnackBar(
  BuildContext context,
  String message, {
  bool isSuccess = true,
  bool isWarning = false,
  bool isError = false,
}) {
  String icon = isSuccess
      ? '✅'
      : isWarning
      ? '⚠️'
      : isError
      ? '❌'
      : '';

  Fluttertoast.showToast(
    msg: icon + message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: isSuccess
        ? Colors.green
        : isError
        ? Colors.red
        : Colors.orange,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
