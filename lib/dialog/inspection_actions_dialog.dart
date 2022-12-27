import 'package:auditdat/constants/color_constants.dart';
import 'package:auditdat/db/model/inspection.dart';
import 'package:flutter/material.dart';

class InspectionActionsDialog {
  static final InspectionActionsDialog instance =
      InspectionActionsDialog._init();
  InspectionActionsDialog._init();

  Future<void> show(
      {required BuildContext context,
      required Inspection inspection,
      required VoidCallback editInspectionCallback,
      required VoidCallback deleteInspectionCallback}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(8),
          title: const Text(
            'Actions',
            textAlign: TextAlign.center,
            style: TextStyle(color: ColorConstants.charcoal),
          ),
          actions: <Widget>[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(primary: ColorConstants.warning),
                  onPressed: editInspectionCallback,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Text(
                      'Edit Inspection',
                      style: TextStyle(color: ColorConstants.charcoal),
                    ),
                  )),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(primary: ColorConstants.danger),
                  onPressed: deleteInspectionCallback,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Text('Delete Inspection'),
                  )),
            ),
            TextButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: ColorConstants.charcoal),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
    );
  }
}
