import 'package:flutter/material.dart';

class UserNotifyUtil {
  BuildContext context;

  UserNotifyUtil({required this.context});

  showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 3),
    ));
  }
}
