import 'package:flutter/material.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (ctx,index)
      {
        return Card(
          child: ListTile(
            title: Text("Expense category $index"),
            trailing: IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
          ),
        );


      }, 
      separatorBuilder: ((context, index) => SizedBox(height: 10,)), 
      itemCount: 10);
  }
}