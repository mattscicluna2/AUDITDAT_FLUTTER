import 'package:auditdat/widget/inspection_common_card_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class InspectionDropdownCardWidget extends StatefulWidget {
  const InspectionDropdownCardWidget({Key? key}) : super(key: key);

  @override
  State<InspectionDropdownCardWidget> createState() =>
      _InspectionDropdownCardWidgetState();
}

class _InspectionDropdownCardWidgetState
    extends State<InspectionDropdownCardWidget> {
  TextEditingController myController = TextEditingController();
  String _myActivity = "";
  final _testList = [
    'Test Item 1',
    'Test Item 2',
    'Test Item 3',
    'Test Item 4',
  ];

  @override
  Widget build(BuildContext context) {
    return InspectionCommonCardWidget(
        onCommentSavedCallback: (comment) => {},
        title: "Dropdown Test?",
        note: "This is a test Note",
        body: DropdownSearch<String>(
          showSearchBox: true,
          mode: Mode.MENU,
          items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
          selectedItem: null,
          dropdownSearchDecoration: InputDecoration(
            hintText: "Customer",
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            border: OutlineInputBorder(),
          ),
        ));
  }
}
