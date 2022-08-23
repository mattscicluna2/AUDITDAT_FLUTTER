import 'package:auditdat/constants/color_constants.dart';
import 'package:auditdat/db/model/template_category.dart';
import 'package:auditdat/db/model/template_version.dart';
import 'package:auditdat/page/inspection_page.dart';
import 'package:flutter/material.dart';

class TemplateCardWidget extends StatefulWidget {
  final TemplateVersion template;
  const TemplateCardWidget({Key? key, required TemplateVersion this.template})
      : super(key: key);

  @override
  State<TemplateCardWidget> createState() => _TemplateCardWidgetState();
}

class _TemplateCardWidgetState extends State<TemplateCardWidget> {
  bool isLoading = true;
  late List<TemplateCategory> categories;

  @override
  void initState() {
    super.initState();

    getTemplates();
  }

  Future getTemplates() async {
    setState(() => isLoading = true);

    // await TemplatesService.instance.sync(context, widget.category);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const InspectionPage()));
      },
      child: Card(
        color: isLoading
            ? ColorConstants.white.withOpacity(0.5)
            : ColorConstants.white.withOpacity(1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
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
