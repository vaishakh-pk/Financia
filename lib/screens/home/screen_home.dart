
import 'package:financia/screens/add_transaction/screen_add_transaction.dart';
import 'package:flutter/material.dart';
import 'package:financia/screens/categories/category_add_popup.dart';
import 'package:financia/screens/categories/screen_categories.dart';
import 'package:financia/screens/transactions/screen_transaction.dart';
import 'package:financia/widgets/bottom_navigation.dart';


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
        title: Text("Financia"),
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
          if(selectedIndexNotifier.value == 0)
          {

            Navigator.of(context).pushNamed(ScreenAddTransaction.routeName);
            
          }
          else
          {

            showCategoryAddPop(context);
            // final _sample = CategoryModel(
            //   id: DateTime.now().millisecondsSinceEpoch.toString(),
            //   name: 'travel',
            //   type: CategoryType.expense,
            // );
            // CategoryDB().insertCategory(_sample);
          }
          
        },child: Icon(Icons.add),),
    );
  }
}