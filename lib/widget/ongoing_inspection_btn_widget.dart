import 'package:auditdat/constants/color_constants.dart';
import 'package:auditdat/db/model/inspection.dart';
import 'package:auditdat/db/model/inspection_status.dart';
import 'package:auditdat/db/model/template_version.dart';
import 'package:auditdat/page/inspection_page.dart';
import 'package:auditdat/widget/status_widget.dart';
import 'package:flutter/material.dart';

class OngoingInspectionBtnWidget extends StatefulWidget {
  final Inspection inspection;
  const OngoingInspectionBtnWidget({Key? key, required this.inspection})
      : super(key: key);

  @override
  State<OngoingInspectionBtnWidget> createState() =>
      _OngoingInspectionBtnWidgetState();
}

class _OngoingInspectionBtnWidgetState
    extends State<OngoingInspectionBtnWidget> {
  bool isLoading = true;
  late TemplateVersion version;
  late InspectionStatus status;

  void initState() {
    super.initState();

    getData();
  }

  Future getData() async {
    setState(() => isLoading = true);

    TemplateVersion _version = (await widget.inspection.templateVersion())!;
    InspectionStatus _status = (await widget.inspection.status())!;

    setState(() => version = _version);
    setState(() => status = _status);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(ColorConstants.lightGrey),
            ),
            onPressed: () async {
              if (!isLoading)
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        InspectionPage(inspection: widget.inspection)));
            },
            child: isLoading
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: CircularProgressIndicator())
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.inspection.reportDate != null
                                ? widget.inspection.reportDate!
                                : widget.inspection.createdAt.toString(),
                            style: const TextStyle(
                                color: ColorConstants.charcoal, fontSize: 12),
                          ),
                          StatusWidget(text: status.name, colour: status.colour)
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            version.name,
                            style: const TextStyle(
                                color: ColorConstants.charcoal,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ]),
                  )));
  }
}
