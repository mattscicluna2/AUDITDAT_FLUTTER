import 'package:auditdat/constants/color_constants.dart';
import 'package:auditdat/db/model/inspection.dart';
import 'package:auditdat/db/model/inspection_check.dart';
import 'package:auditdat/db/model/template_check.dart';
import 'package:auditdat/db/model/template_component.dart';
import 'package:auditdat/db/model/template_response.dart';
import 'package:auditdat/db/repo/inspection_check_repo.dart';
import 'package:auditdat/extensions/HexColor.dart';
import 'package:auditdat/service/inspection_checks_service.dart';
import 'package:auditdat/widget/inspection_common_card_widget.dart';
import 'package:flutter/material.dart';

class InspectionCheckCardWidget extends StatefulWidget {
  final Inspection inspection;
  final TemplateComponent component;
  final TemplateCheck check;

  const InspectionCheckCardWidget(
      {Key? key,
      required this.inspection,
      required this.component,
      required this.check})
      : super(key: key);

  @override
  State<InspectionCheckCardWidget> createState() =>
      _InspectionCheckCardWidgetState();
}

class _InspectionCheckCardWidgetState extends State<InspectionCheckCardWidget> {
  bool isLoading = true;
  late int selectedResponseId = -1;
  late List<TemplateResponse> responses;
  late InspectionCheck inspectionCheck;

  @override
  void initState() {
    super.initState();

    getCheckData();
  }

  Future getCheckData() async {
    setState(() => isLoading = true);

    List<TemplateResponse> _responses =
        await (await widget.check.responseGroup())!.responses();

    InspectionCheck _inspectionCheck = await InspectionChecksService.instance
        .getCreate(widget.inspection.id!, widget.check);

    setState(() => {
          responses = _responses,
          inspectionCheck = _inspectionCheck,
          selectedResponseId = _inspectionCheck.responseId != null
              ? _inspectionCheck.responseId!
              : -1,
          isLoading = false
        });
  }

  onResponsePressed(int responseId) async {
    inspectionCheck = inspectionCheck.copy(responseId: responseId);
    InspectionCheckRepo.instance.update(inspectionCheck);

    setState(() => selectedResponseId = responseId);
  }

  @override
  Widget build(BuildContext context) {
    return InspectionCommonCardWidget(
      title: widget.check.name,
      note: widget.component.note,
      isRequired: widget.check.required,
      mediaRequired: widget.check.mediaRequired,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: List.generate(responses.length, (index) {
                return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: selectedResponseId !=
                                  responses[index].id
                              ? MaterialStateProperty.all(ColorConstants.grey)
                              : MaterialStateProperty.all(
                                  HexColor.fromHex(responses[index].colour)),
                        ),
                        onPressed: () async =>
                            {await onResponsePressed(responses[index].id)},
                        child: Wrap(children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Text(responses[index].response),
                          )
                        ])));
              }),
            ),
    );
  }
}
