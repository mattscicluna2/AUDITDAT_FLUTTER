import 'dart:io';

import 'package:auditdat/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Utilities {
  static Future<bool> hasInternet() async {
    // return false;
    try {
      final result = await InternetAddress.lookup('updat.com.mt');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  static void showToast({
    Color backgroundColor = ColorConstants.primary,
    Color color = Colors.white,
    IconData icon = FontAwesomeIcons.check,
    required String message,
    required BuildContext context,
    ToastGravity toastGravity = ToastGravity.BOTTOM,
    int duration = 2,
  }) {
    late FToast fToast = FToast().init(context);

    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: backgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            icon,
            color: color,
          ),
          SizedBox(
            width: 12.0,
          ),
          Flexible(
            child: Text(message,
                style: TextStyle(
                  color: color,
                )),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: toastGravity,
      toastDuration: Duration(seconds: duration),
    );
  }
}
