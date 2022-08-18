import 'package:auditdat/common/network_connectivity_listener.dart';
import 'package:auditdat/constants/color_constants.dart';
import 'package:auditdat/constants/material_color_constants.dart';
import 'package:auditdat/dialog/logout_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuditdatAppbar extends AppBar {
  @override
  State<AuditdatAppbar> createState() => _AuditdatAppbarState();
}

class _AuditdatAppbarState extends State<AuditdatAppbar> {
  Map _source = {ConnectivityResult.none: false};
  final NetworkConnectivityListener _networkConnectivity = NetworkConnectivityListener.instance;
  bool online = false;

  @override
  void initState() {
    super.initState();
    _networkConnectivity.initialise();
    _networkConnectivity.myStream.listen((source) {
      _source = source;
      print('source $_source');
      // 1.
      if(_source.keys.toList()[0] == ConnectivityResult.none){
        online = false;
      }else{
        online = true;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        backgroundColor: online ? ColorConstants.primary : ColorConstants.danger,
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
                        Text(
                          online ? "online" : "offline",
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

  @override
  void dispose() {
    _networkConnectivity.disposeStream();
    super.dispose();
  }
}
