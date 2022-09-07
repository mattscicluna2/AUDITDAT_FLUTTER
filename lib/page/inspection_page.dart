import 'package:auditdat/db/model/template_page.dart';
import 'package:auditdat/layout/base_page.dart';
import 'package:auditdat/widget/template_page_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InspectionPage extends StatefulWidget {
  final TemplatePage page;

  const InspectionPage({Key? key, required this.page}) : super(key: key);

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
      body: TemplatePageWidget(page: widget.page),
      // body: SingleChildScrollView(
      //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      //   child: TemplatePageWidget(page: widget.page),
      // child: Column(
      //   children: [
      //     InspectionDropdownCardWidget(),
      //     InspectionFieldCardWidget(),
      //     InspectionCheckCardWidget(),
      //   ],
      // ),
      // ),
    );
  }
}
