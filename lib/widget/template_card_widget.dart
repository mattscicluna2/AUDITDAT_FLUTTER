import 'dart:developer';

import 'package:auditdat/constants/color_constants.dart';
import 'package:auditdat/db/model/template_version.dart';
import 'package:auditdat/page/inspection_page.dart';
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

  @override
  void initState() {
    super.initState();

    downloaded = widget.template.downloaded;
  }

  Future downloadTemplate() async {
    setState(() => isLoading = true);
    //

    log('downloadTemplate');

    // if (!sync) {
    bool synced = await TemplatesService.instance
        .getTemplateData(context, widget.template);

    setState(() => downloaded = true);
    // } else {
    //   _templates =
    //   await TemplatesService.instance.sync(context, widget.category);
    // }

    // setState(() => templates = _templates);
    //
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    log(widget.template.toJson().toString());
    return GestureDetector(
      onTap: () async {
        if (widget.template.downloaded) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const InspectionPage()));
        } else {
          await downloadTemplate();
        }
      },
      child: Card(
        color: !downloaded
            ? ColorConstants.white.withOpacity(0.5)
            : ColorConstants.white.withOpacity(1),
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(10),
        // ),
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
