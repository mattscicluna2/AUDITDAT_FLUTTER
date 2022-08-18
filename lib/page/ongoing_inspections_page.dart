import 'package:flutter/material.dart';

class OngoingInspectionsPage extends StatefulWidget {
  const OngoingInspectionsPage({Key? key}) : super(key: key);

  @override
  State<OngoingInspectionsPage> createState() => _OngoingInspectionsPageState();
}

class _OngoingInspectionsPageState extends State<OngoingInspectionsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child:Text(
            'Ongoing Inspections',
            style: TextStyle(fontWeight: FontWeight.w500),
          )
      ),
    );
  }
}
