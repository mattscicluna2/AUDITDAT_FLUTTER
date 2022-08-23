import 'package:auditdat/changenotifier/model/app_settings.dart';
import 'package:auditdat/db/model/template_category.dart';
import 'package:auditdat/service/categories_service.dart';
import 'package:auditdat/widget/category_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  bool isLoading = true;
  late List<TemplateCategory> categories;

  @override
  void initState() {
    super.initState();

    getCategories();
  }

  Future getCategories() async {
    setState(() => isLoading = true);

    var _categories = await CategoriesService.instance.sync(context);
    setState(() => categories = _categories);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    var appSettings = context.watch<AppSettings>();

    return isLoading
        ? Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: () async {
              appSettings.isOnline ? getCategories() : null;
            },
            child: GridView.count(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
              crossAxisCount: 2,
              children: List.generate(categories.length, (index) {
                return CategoryCardWidget(category: categories[index]);
              }),
            ),
          );
  }
}
