import 'package:auditdat/constants/color_constants.dart';
import 'package:auditdat/db/model/template_category.dart';
import 'package:auditdat/service/categories_service.dart';
import 'package:auditdat/service/templates_service.dart';
import 'package:flutter/material.dart';

class CategoryCardWidget extends StatefulWidget {
  final TemplateCategory category;
  const CategoryCardWidget({Key? key, required TemplateCategory this.category}) : super(key: key);

  @override
  State<CategoryCardWidget> createState() => _CategoryCardWidgetState();
}

class _CategoryCardWidgetState extends State<CategoryCardWidget> {
  bool isLoading = true;
  late List<TemplateCategory> categories;

  @override
  void initState() {
    super.initState();

    getTemplates();
  }

  Future getTemplates() async {
    setState(() => isLoading = true);

    var _categories  = await TemplatesService.instance.sync(context, widget.category);
    setState(() => categories = _categories);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
      },
      child: Card(
        color: ColorConstants.white.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text(
              widget.category.name,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
