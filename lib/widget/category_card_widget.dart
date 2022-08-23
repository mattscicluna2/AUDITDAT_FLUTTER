import 'package:auditdat/constants/color_constants.dart';
import 'package:auditdat/db/model/template_category.dart';
import 'package:auditdat/page/templates_page.dart';
import 'package:auditdat/service/templates_service.dart';
import 'package:flutter/material.dart';

class CategoryCardWidget extends StatefulWidget {
  final TemplateCategory category;
  const CategoryCardWidget({Key? key, required TemplateCategory this.category})
      : super(key: key);

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

    await TemplatesService.instance.sync(context, widget.category);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TemplatesPage(category: widget.category)));
      },
      child: Card(
        color: isLoading
            ? ColorConstants.white.withOpacity(0.5)
            : ColorConstants.white.withOpacity(1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isLoading) CircularProgressIndicator(),
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
