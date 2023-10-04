
import 'package:financia/models/category/category_model.dart';
import 'package:financia/models/transaction/transaction_model.dart';
import 'package:flutter/material.dart';

import '../../db/category_db.dart';
import '../../db/transaction_db.dart';

class ScreenAddTransaction extends StatefulWidget {
  static const routeName = 'add-transaction';
  const ScreenAddTransaction({super.key});

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType ;
  CategoryModel? _selectedCategoryModel;
  String? _dropdownSelected;
  final _purposeTextEditingController = TextEditingController();
  final _amountEditingController = TextEditingController();

  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add transaction'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [

            //Purpose
            TextFormField(
              controller: _purposeTextEditingController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Purpose',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10,),

            //Amount
            TextFormField(
              controller: _amountEditingController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
              hintText: 'Amount',
                border: OutlineInputBorder(),
            ),),

            //Calendar date
            TextButton.icon(onPressed: ()
            async{
              final _selectedDateTemp = await showDatePicker(context: context, initialDate: DateTime.now(),
               firstDate: DateTime.now().subtract(const Duration(days: 30)), lastDate: DateTime.now());

               if(_selectedDateTemp!=null)
               {
                setState(() {
                  _selectedDate=_selectedDateTemp;
                });
                
               }
            }, 
            
            icon: const Icon(Icons.calendar_today),label: Text(_selectedDate == null ?"Select date" : _selectedDate.toString())),
          //Type
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:[
            Row(
              children: [
                Radio(value: CategoryType.income, groupValue: _selectedCategoryType, 
                onChanged: (newValue)
                {
                  setState(() {
                    _selectedCategoryType = CategoryType.income;
                    _dropdownSelected = null;
                  });
                }),
                Text('Income'),
              ],
            ),
            Row(
              children: [
                Radio(value: CategoryType.expense, groupValue: _selectedCategoryType, 
                onChanged: (
                  newValue){
                    setState(() {
                    _selectedCategoryType = CategoryType.expense;
                    _dropdownSelected = null;
                  });
                  }),
                Text('Expense'),
              ],
            ),

            ]

          ),

          //Category

          DropdownButton(
            hint: Text('Select Category'),
            value: _dropdownSelected,
            items: (
              _selectedCategoryType ==CategoryType.income 
              ? CategoryDB.instance.IncomeCategoryListListener 
              :CategoryDB.instance.ExpenseCategoryListListener)
              .value.map((e)
          {
            return DropdownMenuItem
            (child: Text(e.name),
            value: e.id,
            onTap: ()
            {
            _selectedCategoryModel = e;
            }
            );
          }).toList(), 

          onChanged: (selecedValue)
          {
            setState(() {
              _dropdownSelected = selecedValue;
            });
          }),

          ElevatedButton.icon(
            onPressed: ()
            {
              addTransaction();
            }, icon: Icon(Icons.check), label: Text('Add')),



          ],
        ),
      )),
    );
  }

  Future <void> addTransaction()async
  {
    final _purposeText = _purposeTextEditingController.text;
    final _amountText = _amountEditingController.text;
    if(_purposeText.isEmpty)
    {
      return;
    }
    if(_amountText.isEmpty)
    {
      return;
    }
    if(_dropdownSelected == null)
    {
      return;
    }
    if(_selectedDate == null)
    {
      return;
    }

    if(_selectedCategoryModel == null)
    {
      return;
    }

    final _amountParsed = double.tryParse(_amountText);

    if(_amountParsed==null)
    {
      return;
    }
    
    final _model =TransactionModel(
      purpose: _purposeText,
      amount: _amountParsed,
      date: _selectedDate!,
      type: _selectedCategoryType!,
      category: _selectedCategoryModel!
      );

      TransactionDB.instance.addTransaction(_model);
      Navigator.of(context).pop();

  }
}