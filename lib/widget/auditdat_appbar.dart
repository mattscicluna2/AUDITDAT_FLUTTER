import 'package:auditdat/changenotifier/model/app_settings.dart';
import 'package:auditdat/constants/color_constants.dart';
import 'package:auditdat/dialog/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AuditdatAppbar extends AppBar {

  @override
  State<AuditdatAppbar> createState() => _AuditdatAppbarState();
}

class _AuditdatAppbarState extends State<AuditdatAppbar> {
  @override
  Widget build(BuildContext context) {
    var appSettings = context.watch<AppSettings>();

    return AppBar(
        centerTitle: true,
        backgroundColor: appSettings.isOnline ? ColorConstants.primary : ColorConstants.danger,
        actions: [
          Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: GestureDetector(
                  onTap: () {
                    LogoutDialog.instance.show(context);
                  },
                  child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.signOutAlt,
                          size: 16,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ]),
                ),
              )),
          Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: GestureDetector(
                  onTap: () {
                    LogoutDialog.instance.show(context);
                  },
                  child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        // Text(
                        //   online ? "online" : "offline",
                        //   style: TextStyle(fontWeight: FontWeight.w500),
                        // ),
                      ]),
                ),
              ))
        ],
        title: Image.asset(
          'assets/images/updat_logo_white.png',
          width: MediaQuery.of(context).size.width * 0.25,
        ));
  }
}
