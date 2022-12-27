import 'dart:developer';

import 'package:auditdat/constants/color_constants.dart';
import 'package:auditdat/db/model/inspection.dart';
import 'package:auditdat/db/model/template_page.dart';
import 'package:auditdat/db/model/template_version.dart';
import 'package:auditdat/page/inspection_page.dart';
import 'package:auditdat/service/inspections_service.dart';
import 'package:auditdat/service/templates_service.dart';
import 'package:flutter/material.dart';

class TemplateCardWidget extends StatefulWidget {
  final TemplateVersion template;
  const TemplateCardWidget({Key? key, required this.template})
      : super(key: key);

  @override
  State<TemplateCardWidget> createState() => _TemplateCardWidgetState();
}

class _TemplateCardWidgetState extends State<TemplateCardWidget> {
  bool isLoading = false;
  bool downloaded = false;
  TemplatePage? mainPage;

  @override
  initState() {
    super.initState();

    downloaded = widget.template.downloaded;
    if (downloaded) initializeMainPage();
  }

  Future initializeMainPage() async {
    mainPage = (await widget.template.pages())[0];
    setState(() => mainPage = mainPage);
  }

  Future downloadTemplate() async {
    setState(() => isLoading = true);

    bool synced = await TemplatesService.instance
        .getTemplateData(context, widget.template);

    if (synced) await initializeMainPage();

    setState(() => downloaded = synced);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    log(widget.template.toJson().toString());
    return GestureDetector(
      onTap: () async {
        if (downloaded && mainPage != null) {
          Inspection inspection =
              await InspectionsService.instance.insert(widget.template.id);

          Navigator.of(context).pushNamedAndRemoveUntil(
              '/onGoingInspections', (Route<dynamic> route) => false);

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => InspectionPage(inspection: inspection)));
        } else {
          await downloadTemplate();
        }
      },
      child: Card(
        color: !downloaded
            ? ColorConstants.white.withOpacity(0.5)
            : ColorConstants.white.withOpacity(1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isLoading) CircularProgressIndicator(),
            SizedBox(height: 10),
            Text(
              widget.template.name,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "V${widget.template.version}",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
