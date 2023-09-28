import 'package:flutter/material.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListView.separated(padding: EdgeInsets.all(10), itemBuilder: (ctx,index)
    {
      return Card(
        elevation: 1,
        child: ListTile(
          leading:  Text('16 jun 23'
            ,textAlign: TextAlign.center,
            ),
          title: Text('12000'),
          subtitle: Text('Category'),
        ),
      );

    }, separatorBuilder: (ctx,index)
    {
      return const SizedBox(height: 10);
    }, itemCount: 10);
  }
}