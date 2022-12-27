import 'package:auditdat/extensions/HexColor.dart';
import 'package:flutter/material.dart';

class StatusWidget extends StatelessWidget {
  final String text;
  final String colour;

  const StatusWidget({Key? key, required this.text, required this.colour})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: HexColor.fromHex(colour).withOpacity(0.3),
          borderRadius:
          BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 10, vertical: 5),
        child: Text(
          text,
          style: TextStyle(
              color: HexColor.fromHex(colour),
              fontSize: 12),
        ),
      ),
    );
  }
}
