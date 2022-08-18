import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuditdatAppbar extends StatelessWidget {
  const AuditdatAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        actions: [
          Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: GestureDetector(
                  onTap: () {
                    // _showLogoutDialog();
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
              ))
        ],
        title: Image.asset(
          'assets/images/updat_logo_white.png',
          width: MediaQuery.of(context).size.width * 0.25,
        ));
  }
}
