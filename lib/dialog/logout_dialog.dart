import 'package:auditdat/constants/color_constants.dart';
import 'package:auditdat/service/auth_service.dart';
import 'package:flutter/material.dart';

class LogoutDialog {
  static final LogoutDialog instance = LogoutDialog._init();
  LogoutDialog._init();

  Future<void> show(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(8),
          title: Text(
            'Are you sure you want to logout?',
            textAlign: TextAlign.center,
            style: TextStyle(color: ColorConstants.primary),
          ),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: Text('No'),
                        )),
                  )),
              Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: ColorConstants.danger),
                        onPressed: () async {
                          AuthService.instance.logout();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/login', (Route<dynamic> route) => false);
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: Text('Yes'),
                        )),
                  )),
            ],
          ),
        );
      },
    );
  }
}
