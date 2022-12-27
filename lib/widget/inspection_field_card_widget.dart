import 'package:auditdat/db/model/template_component.dart';
import 'package:auditdat/db/model/template_field.dart';
import 'package:auditdat/widget/inspection_common_card_widget.dart';
import 'package:flutter/material.dart';

class InspectionFieldCardWidget extends StatefulWidget {
  final TemplateComponent component;
  final TemplateField field;

  const InspectionFieldCardWidget(
      {Key? key, required this.component, required this.field})
      : super(key: key);

  @override
  State<InspectionFieldCardWidget> createState() =>
      _InspectionFieldCardWidgetState();
}

class _InspectionFieldCardWidgetState extends State<InspectionFieldCardWidget> {
  @override
  Widget build(BuildContext context) {
    return InspectionCommonCardWidget(
      title: widget.field.name,
      note: widget.component.note,
      isRequired: widget.field.required,
      mediaRequired: widget.field.mediaRequired,
      body: TextField(
        style: TextStyle(fontSize: 15, color: Colors.black),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          border: OutlineInputBorder(),
          hintText: widget.field.name,
        ),
      ),
    );
  }
}
