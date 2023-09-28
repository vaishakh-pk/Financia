
import 'package:flutter/material.dart';
import 'package:moneymanager/screens/categories/screen_categories.dart';
import 'package:moneymanager/screens/transactions/screen_transaction.dart';
import 'package:moneymanager/widgets/bottom_navigation.dart';

class ScreenHome extends StatelessWidget {
 ScreenHome({super.key});

final _pages = [
  ScreenTransaction(),
  ScreenCategories()
];

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MoneyManager"),
        backgroundColor: Colors.green,
        centerTitle: true,
        ),

      bottomNavigationBar: MoneyManagementBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(valueListenable: selectedIndexNotifier, 
        builder: (BuildContext context,int updatedIndex, _)
        {
          return _pages[updatedIndex];
        },
        )
        ),
        floatingActionButton: FloatingActionButton(onPressed: ()
        {
          
        },child: Icon(Icons.add),),
    );
  }
}