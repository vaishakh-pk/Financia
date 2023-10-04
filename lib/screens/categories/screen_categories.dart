import 'package:flutter/material.dart';
import 'package:financia/db/category_db.dart';
import 'package:financia/screens/categories/expense_category_list.dart';
import 'package:financia/screens/categories/income_category_list.dart';

class ScreenCategories extends StatefulWidget {
  const ScreenCategories({super.key});

  @override
  State<ScreenCategories> createState() => _ScreenCategoriesState();
}

class _ScreenCategoriesState extends State<ScreenCategories> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDB().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: [
          Tab(text: 'INCOME',),
          Tab(text: 'EXPENSE',)
        ]),

        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: 
          [
            IncomeCategoryList(),
            ExpenseCategoryList()
          ]
          ),
        )
      ],
    );
  }
}