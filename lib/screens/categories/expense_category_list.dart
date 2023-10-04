import 'package:financia/db/category_db.dart';
import 'package:flutter/material.dart';

import '../../models/category/category_model.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: CategoryDB().ExpenseCategoryListListener, 
    builder: (BuildContext ctx, List<CategoryModel> newlist, Widget?_){
      return ListView.separated(
      itemBuilder: (ctx,index)
      {
        final category = newlist[index];
        return Card(
          child: ListTile(
            title: Text(category.name),
            trailing: IconButton(onPressed: ()
            {
              CategoryDB.instance.deleteCategory(category.id);
            }, icon: Icon(Icons.delete)),
          ),
        );


      }, 
      separatorBuilder: ((ctx, index) => SizedBox(height: 10,)), 
      itemCount: newlist.length);
    });
  }
}