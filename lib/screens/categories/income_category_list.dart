import 'package:flutter/material.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (ctx,index)
      {
        return Card(
          child: ListTile(
            title: Text("Income category $index"),
            trailing: IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
          ),
        );

      }, 
      separatorBuilder: ((context, index) => SizedBox(height: 10,)), 
      itemCount: 10);
  }
}