import 'package:auditdat/db/model/template_category.dart';
import 'package:auditdat/db/repo/template_category_repo.dart';
import 'package:auditdat/service/categories_service.dart';
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

    var _categories  = await CategoriesService.instance.sync(context);
    setState(() => categories = _categories);

    setState(() => isLoading = false);
  }


  @override
  Widget build(BuildContext context) {
    return isLoading ?
      Center(child: CircularProgressIndicator()) :
      Container(
       child: RefreshIndicator(
         onRefresh: () async {
           getCategories();
         },
         child: GridView.count(
           // Create a grid with 2 columns. If you change the scrollDirection to
           // horizontal, this produces 2 rows.
           crossAxisCount: 2,
           // Generate 100 widgets that display their index in the List.
           children: List.generate(categories.length, (index) {
             return GestureDetector(
               onTap: () async {
                 await Navigator.of(context).push(MaterialPageRoute(
                   builder: (context) => NoteDetailPage(noteId: index),
                 ));
               },
               child: Card(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Text(
                       categories[index].name,
                       style: Theme.of(context).textTheme.headline5,
                     ),
                   ],
                 ),
               ),
             );
           }),
         ),
       )
      );
  }
}
