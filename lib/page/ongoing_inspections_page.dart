import 'package:auditdat/db/model/inspection.dart';
import 'package:auditdat/db/repo/inspection_repo.dart';
import 'package:auditdat/widget/ongoing_inspection_btn_widget.dart';
import 'package:flutter/material.dart';

class OngoingInspectionsPage extends StatefulWidget {
  const OngoingInspectionsPage({Key? key}) : super(key: key);

  @override
  State<OngoingInspectionsPage> createState() => _OngoingInspectionsPageState();
}

class _OngoingInspectionsPageState extends State<OngoingInspectionsPage> {
  bool isLoading = true;
  late List<Inspection> inspections;

  @override
  void initState() {
    super.initState();

    getInspections();
  }

  Future getInspections() async {
    setState(() => isLoading = true);

    List<Inspection> _inspections = await InspectionRepo.instance.getAll();
    setState(() => inspections = _inspections);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            shrinkWrap: true,
            children: List.generate(inspections.length, (index) {
              return Column(children: [
                OngoingInspectionBtnWidget(
                  inspection: inspections[index],
                  onDeleteCallback: () async {
                    getInspections();
                  },
                ),
                SizedBox(height: 10)
              ]);
            }));
  }
}
