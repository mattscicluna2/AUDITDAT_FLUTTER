import 'package:auditdat/constants/color_constants.dart';
import 'package:auditdat/widget/inspection_common_card_widget.dart';
import 'package:flutter/material.dart';

class InspectionCheckCardWidget extends StatelessWidget {
  const InspectionCheckCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InspectionCommonCardWidget(
      body: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ColorConstants.grey),
                  ),
                  onPressed: () async {},
                  child: Wrap(children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text('Low'),
                    )
                  ]))),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ColorConstants.warning),
                  ),
                  onPressed: () async {},
                  child: Wrap(children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text('Medium'),
                    )
                  ]))),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ColorConstants.grey),
                  ),
                  onPressed: () async {},
                  child: Wrap(children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text('High'),
                    )
                  ]))),
        ],
      ),
      title: "Test Check",
      note: "Note",
    );
  }
}
