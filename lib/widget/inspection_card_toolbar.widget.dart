import 'package:auditdat/changenotifier/model/app_settings.dart';
import 'package:auditdat/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class InspectionCardToolbar extends StatelessWidget {
  const InspectionCardToolbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appSettings = context.watch<AppSettings>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: Row(
              children: const [
                FaIcon(
                  FontAwesomeIcons.solidComment,
                  size: 15,
                  color: ColorConstants.grey,
                ),
                Text(
                  " Add Comment",
                  style: TextStyle(fontSize: 15, color: ColorConstants.grey),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
          child: Row(
            children: const [
              FaIcon(
                FontAwesomeIcons.solidImage,
                size: 15,
                color: ColorConstants.grey,
              ),
              Text(
                " Media",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15, color: ColorConstants.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
