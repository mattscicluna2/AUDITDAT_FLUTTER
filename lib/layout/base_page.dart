import 'package:auditdat/changenotifier/model/app_settings.dart';
import 'package:auditdat/widget/auditdat_appbar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BasePage extends StatefulWidget {
  final Widget body;
  final Widget? bottomNavigationBar;

  const BasePage({required this.body, this.bottomNavigationBar, Key? key})
      : assert(body != null),
        super(key: key);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  var subscription;

  @override
  void initState() {
    super.initState();
    var appSettings = context.read<AppSettings>();

    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      appSettings.isOnline = result != ConnectivityResult.none;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuditdatAppbar(),
      bottomNavigationBar: widget.bottomNavigationBar,
      body: widget.body,
    );
  }

  @override
  void dispose() {
    print("Disposing Connection ...");
    super.dispose();
    subscription.cancel();
  }
}