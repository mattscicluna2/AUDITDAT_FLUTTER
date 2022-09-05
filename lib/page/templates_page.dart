import 'package:auditdat/changenotifier/model/app_settings.dart';
import 'package:auditdat/db/model/template_category.dart';
import 'package:auditdat/db/model/template_version.dart';
import 'package:auditdat/db/repo/template_repo.dart';
import 'package:auditdat/layout/base_page.dart';
import 'package:auditdat/service/templates_service.dart';
import 'package:auditdat/widget/template_card_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TemplatesPage extends StatefulWidget {
  final TemplateCategory category;

  const TemplatesPage({Key? key, required this.category}) : super(key: key);

  @override
  State<TemplatesPage> createState() => _TemplatesPageState();
}

class _TemplatesPageState extends State<TemplatesPage> {
  bool isLoading = false;
  List<TemplateVersion> templates = [];

  @override
  void initState() {
    super.initState();

    getTemplates(false);
  }

  Future getTemplates(bool sync) async {
    setState(() => isLoading = true);
    //
    List<TemplateVersion> _templates = [];

    if (!sync) {
      _templates =
          await TemplateVersionRepo.instance.getAllByCategory(widget.category.id);
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
    var appSettings = context.watch<AppSettings>();

    return BasePage(
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () async {
                  appSettings.isOnline ? getTemplates(true) : null;
                },
                child: GridView.count(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10.0),
                  crossAxisCount: 2,
                  children: List.generate(templates.length, (index) {
                    return TemplateCardWidget(template: templates[index]);
                    // return CategoryCardWidget(category: templates[index]);
                  }),
                ),
              ));
  }
}
