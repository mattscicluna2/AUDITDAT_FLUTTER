import 'package:auditdat/dialog/logout_dialog.dart';
import 'package:auditdat/widget/auditdat_appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BasePage extends StatelessWidget {
  /// Body of [BasePage]
  final Widget body;
  final Widget? bottomNavigationBar;

  const BasePage({required this.body, this.bottomNavigationBar, Key? key})
      : assert(body != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuditdatAppbar(),
      bottomNavigationBar: bottomNavigationBar,
      body: body,
    );
  }
}