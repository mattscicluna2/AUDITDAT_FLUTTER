import 'dart:developer';

import 'package:auditdat/constants/color_constants.dart';
import 'package:auditdat/db/model/template_check.dart';
import 'package:auditdat/db/model/template_component.dart';
import 'package:auditdat/db/model/template_response.dart';
import 'package:auditdat/extensions/HexColor.dart';
import 'package:auditdat/widget/inspection_common_card_widget.dart';
import 'package:flutter/material.dart';

class InspectionCheckCardWidget extends StatefulWidget {
  final TemplateComponent component;
  final TemplateCheck check;

  const InspectionCheckCardWidget(
      {Key? key, required this.component, required this.check})
      : super(key: key);

  @override
  State<InspectionCheckCardWidget> createState() =>
      _InspectionCheckCardWidgetState();
}

class _InspectionCheckCardWidgetState extends State<InspectionCheckCardWidget> {
  bool isLoading = true;
  late int selectedResponseId = -1;
  late List<TemplateResponse> responses;

  @override
  void initState() {
    super.initState();

    getCheckResponses();
  }

  Future getCheckResponses() async {
    setState(() => isLoading = true);

    var _responses = await (await widget.check.responseGroup())!.responses();
    setState(() => responses = _responses);

    setState(() => isLoading = false);
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
                        onPressed: () async {
                          setState(
                              () => selectedResponseId = responses[index].id);

                          log(selectedResponseId.toString());
                        },
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
