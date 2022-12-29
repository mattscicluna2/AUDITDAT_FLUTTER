import 'package:auditdat/db/model/inspection.dart';
import 'package:auditdat/db/model/template_page.dart';
import 'package:auditdat/layout/base_page.dart';
import 'package:auditdat/widget/template_page_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InspectionPage extends StatefulWidget {
  final Inspection inspection;
  final int selectedPage;

  const InspectionPage(
      {Key? key, required this.inspection, this.selectedPage = 0})
      : super(key: key);

  @override
  State<InspectionPage> createState() => _InspectionPageState();
}

class _InspectionPageState extends State<InspectionPage> {
  bool isLoading = true;
  late List<TemplatePage> pages;
  late TemplatePage currentPage;

  @override
  void initState() {
    super.initState();

    getPages();
  }

  getPages() async {
    setState(() => isLoading = true);

    List<TemplatePage> _pages =
        await (await widget.inspection.templateVersion())!.pages();

    setState(() => pages = _pages);
    setState(() => currentPage = pages[widget.selectedPage]);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : TemplatePageWidget(inspection: widget.inspection, page: currentPage),
    );
  }
}
