import 'package:auditdat/db/model/template.dart';
import 'package:auditdat/db/model/template_category.dart';
import 'package:auditdat/db/repo/template_repo.dart';
import 'package:auditdat/layout/base_page.dart';
import 'package:auditdat/service/templates_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TemplatesPage extends StatefulWidget {
  final TemplateCategory category;

  const TemplatesPage({Key? key, required this.category}) : super(key: key);

  @override
  State<TemplatesPage> createState() => _TemplatesPageState();
}

class _TemplatesPageState extends State<TemplatesPage> {
  bool isLoading = false;
  List<Template> templates = [];

  @override
  void initState() {
    super.initState();

    getTemplates(false);
  }

  Future getTemplates(bool sync) async {
    setState(() => isLoading = true);
    //
    List<Template> _templates = [];

    if (!sync) {
      _templates =
          await TemplateRepo.instance.getAllByCategory(widget.category.id);
    } else {
      _templates =
          await TemplatesService.instance.sync(context, widget.category);
    }

    setState(() => templates = _templates);
    //
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () async {
                  getTemplates(true);
                },
                child: GridView.count(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10.0),
                  crossAxisCount: 2,
                  children: List.generate(templates.length, (index) {
                    return Card(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              templates[index].name,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "V${templates[index].version}",
                              textAlign: TextAlign.center,
                            ),
                          ]),
                    );
                    // return CategoryCardWidget(category: templates[index]);
                  }),
                ),
              ));
  }
}
