import 'dart:developer';

import 'package:auditdat/db/model/template_component.dart';
import 'package:auditdat/db/model/template_page.dart';
import 'package:auditdat/widget/inspection_check_card_widget.dart';
import 'package:auditdat/widget/inspection_field_card_widget.dart';
import 'package:flutter/material.dart';

class TemplatePageWidget extends StatefulWidget {
  final TemplatePage page;

  const TemplatePageWidget({Key? key, required this.page}) : super(key: key);

  @override
  State<TemplatePageWidget> createState() => _TemplatePageWidgetState();
}

class _TemplatePageWidgetState extends State<TemplatePageWidget> {
  bool isLoading = true;
  late List<TemplateComponent> components = [];

  @override
  initState() {
    super.initState();

    initializeComponents();
  }

  Future initializeComponents() async {
    components = await widget.page.components();
    setState(() => components = components);

    // log(components.length.toString());
  }

  final item = List<String>.generate(30, (i) => 'Item $i');

  getComponentWidget(TemplateComponent component) {
    if (component.fieldId != null)
      return InspectionFieldCardWidget();
    else if (component.checkId != null) return InspectionCheckCardWidget();
  }

  @override
  Widget build(BuildContext context) {
    log(components.length.toString());
    if (components.isNotEmpty) log(components[0].id.toString());

    return ListView.custom(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        childrenDelegate:
            SliverChildBuilderDelegate((BuildContext context, int index) {
          if (components.length > index) {
            TemplateComponent component = components[index];

            if (index == 0) {
              return Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      widget.page.name,
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 25),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  getComponentWidget(component),
                ],
              );
            } else {
              return getComponentWidget(component);
            }
          }
        }));
  }
}
