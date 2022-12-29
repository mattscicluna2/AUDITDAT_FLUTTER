import 'package:auditdat/constants/color_constants.dart';
import 'package:auditdat/interface/types.dart';
import 'package:auditdat/page/camera_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InspectionCardToolbar extends StatefulWidget {
  final bool mediaRequired;
  final String? comments;
  final VoidCallbackWithStringParam onCommentSavedCallback;
  final VoidCallback onShowCommentsCallback;
  final VoidCallback onHideCommentsCallback;

  const InspectionCardToolbar(
      {Key? key,
      required this.onCommentSavedCallback,
      required this.onShowCommentsCallback,
      required this.onHideCommentsCallback,
      this.comments,
      required this.mediaRequired})
      : super(key: key);
  @override
  State<InspectionCardToolbar> createState() => _InspectionCardToolbarState();
}

class _InspectionCardToolbarState extends State<InspectionCardToolbar> {
  late bool showComments = false;
  final TextEditingController txtComment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (showComments)
        Padding(
            padding: EdgeInsets.only(bottom: 5, top: 10),
            child: Column(children: [
              TextField(
                controller: txtComment,
                style: TextStyle(fontSize: 15, color: Colors.black),
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  border: OutlineInputBorder(),
                  hintText: "Comments",
                ),
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: null,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            ColorConstants.primaryAlt),
                      ),
                      onPressed: () async {
                        widget.onCommentSavedCallback(txtComment.text);
                        setState(() => showComments = false);
                        widget.onHideCommentsCallback();
                      },
                      child: Wrap(children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: FaIcon(
                            FontAwesomeIcons.check,
                            size: 20,
                          ),
                        )
                      ])),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ColorConstants.grey),
                      ),
                      onPressed: () async {
                        setState(() => showComments = false);
                        widget.onHideCommentsCallback();
                      },
                      child: Wrap(children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: FaIcon(
                            FontAwesomeIcons.times,
                            size: 20,
                          ),
                        )
                      ]))
                ],
              )
            ])),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () async {
              txtComment.text = widget.comments != null ? widget.comments! : "";
              setState(() => showComments = true);
              widget.onShowCommentsCallback();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.solidComment,
                    size: 15,
                    color: showComments
                        ? ColorConstants.primary
                        : ColorConstants.grey,
                  ),
                  Text(
                    " ${widget.comments == null ? "Add Comment" : "Edit Comment"}",
                    style: TextStyle(
                        fontSize: 15,
                        color: showComments
                            ? ColorConstants.primary
                            : ColorConstants.grey),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await availableCameras().then((value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => CameraPage(cameras: value))));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: Row(
                children: [
                  if (widget.mediaRequired)
                    const Text(
                      "* ",
                      style: TextStyle(color: ColorConstants.danger),
                    ),
                  const FaIcon(
                    FontAwesomeIcons.solidImage,
                    size: 15,
                    color: ColorConstants.grey,
                  ),
                  const Text(
                    " Media",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 15, color: ColorConstants.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    ]);
  }
}
