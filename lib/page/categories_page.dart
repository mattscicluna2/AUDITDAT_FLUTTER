import 'package:auditdat/constants/color_constants.dart';
import 'package:auditdat/db/model/template_category.dart';
import 'package:auditdat/db/repo/template_category_repo.dart';
import 'package:auditdat/service/categories_service.dart';
import 'package:auditdat/widget/category_card_widget.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'note_detail_page.dart';

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
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: () async {
              getCategories();
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
