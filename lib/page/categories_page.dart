import 'package:flutter/material.dart';

import 'note_detail_page.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10
      ),
     child: GridView.count(
       // Create a grid with 2 columns. If you change the scrollDirection to
       // horizontal, this produces 2 rows.
       crossAxisCount: 2,
       // Generate 100 widgets that display their index in the List.
       children: List.generate(5, (index) {
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
                   'Category ${index + 1}',
                   style: Theme.of(context).textTheme.headline5,
                 ),
               ],
             ),
           ),
         );
       }),
     ),
    );
  }
}
