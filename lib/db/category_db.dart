import 'package:financia/screens/categories/income_category_list.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:financia/models/category/category_model.dart';

const Category_DB_NAME = 'category-database';
abstract class CategoryDbFunctions{
  Future <List<CategoryModel>> getCategories();
  Future <void> insertCategory(CategoryModel value);
  Future <void> deleteCategory(String CategoryID);
  
}


class CategoryDB implements CategoryDbFunctions{

//Create singleton
  CategoryDB._Internal();
  static CategoryDB instance = CategoryDB._Internal();
  factory CategoryDB()
  {
    return instance;
  }
//

  ValueNotifier<List<CategoryModel>> IncomeCategoryListListener = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> ExpenseCategoryListListener = ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    
    final _categoryDB =await Hive.openBox<CategoryModel>(Category_DB_NAME);
    await _categoryDB.put(value.id,value);
    refreshUI();
  }
  
  @override
  Future<List<CategoryModel>> getCategories() async {
    
    final _categoryDB =await Hive.openBox<CategoryModel>(Category_DB_NAME);
    return _categoryDB.values.toList();
    
  }


  Future <void> refreshUI()async
  {
    final _allCategories = await getCategories();
    IncomeCategoryListListener.value.clear();
    ExpenseCategoryListListener.value.clear();
    await Future.forEach(_allCategories, (CategoryModel category) 
    {
      if(category.type == CategoryType.income)
      {
        IncomeCategoryListListener.value.add(category);
      }
      else ExpenseCategoryListListener.value.add(category);
    });

    IncomeCategoryListListener.notifyListeners();
    ExpenseCategoryListListener.notifyListeners();
  }
  
  @override
  Future<void> deleteCategory(String CategoryID) async{
    
    final _categoryDB = await Hive.openBox<CategoryModel>(Category_DB_NAME);
    await _categoryDB.delete(CategoryID);
    refreshUI();
  }





}