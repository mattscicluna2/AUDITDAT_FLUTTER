import 'package:auditdat/widget/inspection_common_card_widget.dart';
import 'package:flutter/material.dart';

class InspectionFieldCardWidget extends StatelessWidget {
  const InspectionFieldCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InspectionCommonCardWidget(
      title: "Are you sure you want to do this?",
      note: "This is a test Note",
      body: TextField(
        style: TextStyle(fontSize: 15, color: Colors.black),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          border: OutlineInputBorder(),
          hintText: 'Field',
        ),
      ),
    );
  }
}
