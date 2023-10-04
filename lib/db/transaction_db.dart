

import 'package:financia/models/transaction/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/category/category_model.dart';

const TRANSACTION_DB_NAME = 'transaction-db';


abstract class TransactionDbFunctions
{
  Future <void> addTransaction(TransactionModel ob);
  Future <List<TransactionModel>> getTransactions();
  Future <void> deleteTransaction( String id);
}


class TransactionDB implements TransactionDbFunctions
{
  TransactionDB._internal();
  static TransactionDB instance = TransactionDB._internal();

  factory TransactionDB()
  {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> trsansactionListNotifier = ValueNotifier([]);

  ValueNotifier<List<double>> totalListNotifier = ValueNotifier([0.0,0.0]);

  @override
  Future<void> addTransaction(TransactionModel ob) async{
    
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);

    await _db.put(ob.id,ob);
    Refresh();
  }
  

  Future <void> Refresh() async
  {
    final _list = await getTransactions();
    double _totalIncome=0;
    double _totalExpense=0;
    _list.sort((first,second)=> second.date.compareTo(first.date));
    for (var i = 0; i < _list.length; i++) 
    {
      TransactionModel _value = _list[i];
      if(_value.type ==CategoryType.income)
      {
        _totalIncome+=_value.amount;
      }
      else _totalExpense+=_value.amount;
    }
    totalListNotifier.value.clear();
    totalListNotifier.value.add(_totalIncome);
    totalListNotifier.value.add(_totalExpense);
    trsansactionListNotifier.value.clear();
    trsansactionListNotifier.value.addAll(_list);
    trsansactionListNotifier.notifyListeners();
    totalListNotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getTransactions() async{
    
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    
    return _db.values.toList();
  }
  
  @override
  Future<void> deleteTransaction(String id) async{
    
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    _db.delete(id);
    Refresh();
    
  }
  

  


  

}