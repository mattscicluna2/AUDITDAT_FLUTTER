import 'package:auditdat/constants/color_constants.dart';
import 'package:auditdat/interface/types.dart';
import 'package:auditdat/widget/inspection_card_toolbar.widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InspectionCommonCardWidget extends StatefulWidget {
  final Widget body;
  final String title;
  final String? note;
  final String? comments;
  final bool isRequired;
  final bool mediaRequired;
  final VoidCallbackWithStringParam onCommentSavedCallback;

  const InspectionCommonCardWidget(
      {Key? key,
      required this.body,
      required this.title,
      required this.onCommentSavedCallback,
      this.note,
      this.comments,
      this.isRequired = false,
      this.mediaRequired = false})
      : super(key: key);

  @override
  State<InspectionCommonCardWidget> createState() =>
      _InspectionCommonCardWidgetState();
}

class _InspectionCommonCardWidgetState
    extends State<InspectionCommonCardWidget> {
  bool commentsHidden = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              title: Row(children: [
                if (widget.isRequired)
                  Text(
                    "* ",
                    style: TextStyle(color: ColorConstants.danger),
                  ),
                Text(
                  widget.title,
                  style: TextStyle(color: ColorConstants.grey),
                ),
              ]),
              subtitle: widget.note != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                            child: Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.solidStickyNote,
                                  size: 12,
                                ),
                                Text(" ${widget.note}"),
                              ],
                            )),
                      ],
                    )
                  : null,
            ),
            widget.body,
            if (widget.comments != null && !commentsHidden)
              Text(
                widget.comments!,
                style: const TextStyle(
                  color: ColorConstants.charcoal,
                  fontSize: 15,
                ),
              ),
            InspectionCardToolbar(
              comments: widget.comments,
              onCommentSavedCallback: widget.onCommentSavedCallback,
              onShowCommentsCallback: () {
                setState(() => commentsHidden = true);
              },
              onHideCommentsCallback: () {
                setState(() => commentsHidden = false);
              },
              mediaRequired: widget.mediaRequired,
            )
          ],
        ),
      ),
    );
  }
}
