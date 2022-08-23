import 'package:auditdat/layout/base_page.dart';
import 'package:auditdat/widget/inspection_check_card_widget.dart';
import 'package:auditdat/widget/inspection_dropdown_card_widget.dart';
import 'package:auditdat/widget/inspection_field_card_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InspectionPage extends StatefulWidget {
  const InspectionPage({Key? key}) : super(key: key);

  @override
  State<InspectionPage> createState() => _InspectionPageState();
}

class _InspectionPageState extends State<InspectionPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            InspectionDropdownCardWidget(),
            InspectionFieldCardWidget(),
            InspectionCheckCardWidget(),
          ],
        ),
      ),
    );
  }
}
