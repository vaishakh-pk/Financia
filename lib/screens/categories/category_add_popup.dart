
import 'package:financia/db/category_db.dart';
import 'package:flutter/material.dart';

import '../../models/category/category_model.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier = ValueNotifier(CategoryType.income);

Future <void> showCategoryAddPop(BuildContext context) async
{
  final _nameEditingController = TextEditingController();
  showDialog(context: context, 
  builder: (ctx)
  {
    return SimpleDialog(
      title: const Text('Add Category'),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _nameEditingController,
            decoration: const InputDecoration(
              hintText: 'Category Name',
              border: OutlineInputBorder(),
            ),
          ),
        ),

        const Padding(
          padding: EdgeInsets.all(8),
        child: Row(
          children: [
            RadioButton(title: 'Income', type: CategoryType.income),
            RadioButton(title: 'Expense', type: CategoryType.expense),
          ],
        )),




        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(onPressed: ()
          {

            final _name = _nameEditingController.text;
            if(_name.isEmpty)
            {
              return;
            }
            final _type = selectedCategoryNotifier.value;
            final _category = CategoryModel(id:DateTime.now().millisecondsSinceEpoch.toString() ,name: _name,type: _type);

            CategoryDB().insertCategory(_category);
            Navigator.of(ctx).pop();

          }, child: Text('Add')),
        )
      ],
    );
  }
  );
}


class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  // final CategoryType selectedCategoryType;
  const RadioButton({super.key, required this.title, required this.type});


  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ValueListenableBuilder(valueListenable: selectedCategoryNotifier, 
      builder: (BuildContext ctx, CategoryType newCategory, Widget? _)
      {
        return Radio<CategoryType>(value: type, 
        groupValue: newCategory, onChanged: (value)
        {
          selectedCategoryNotifier.value = value!;
          selectedCategoryNotifier.notifyListeners();
        });
      })
        ,
        Text(title),
      ],);
  }
}