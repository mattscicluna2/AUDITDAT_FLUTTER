import 'package:auditdat/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InspectionCommonCardWidget extends StatelessWidget {
  final Widget body;
  final String title;
  final String? note;

  const InspectionCommonCardWidget(
      {Key? key, required this.body, required this.title, this.note})
      : super(key: key);

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
                Text(
                  "* ",
                  style: TextStyle(color: ColorConstants.danger),
                ),
                Text(
                  title,
                  style: TextStyle(color: ColorConstants.grey),
                ),
              ]),
              subtitle: note != null
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
                                Text(" $note"),
                              ],
                            )),
                      ],
                    )
                  : null,
            ),
            body,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                  child: Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.solidComment,
                        size: 15,
                        color: ColorConstants.grey,
                      ),
                      Text(
                        " Add Comment",
                        style:
                            TextStyle(fontSize: 15, color: ColorConstants.grey),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                  child: Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.solidImage,
                        size: 15,
                        color: ColorConstants.grey,
                      ),
                      Text(
                        " Media",
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(fontSize: 15, color: ColorConstants.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
