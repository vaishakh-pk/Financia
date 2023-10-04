import 'package:financia/db/category_db.dart';
import 'package:financia/screens/add_transaction/screen_add_transaction.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:financia/models/category/category_model.dart';
import 'package:financia/models/transaction/transaction_model.dart';
import 'package:financia/screens/home/screen_home.dart';

Future<void> main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(CategoryModelAdapter().typeId))
  {
    Hive.registerAdapter(CategoryModelAdapter());  
  }

  if(!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId))
  {
    Hive.registerAdapter(CategoryTypeAdapter());  
  }
  if(!Hive.isAdapterRegistered(TransactionModelAdapter().typeId))
  {
    Hive.registerAdapter(TransactionModelAdapter());  
  }
  CategoryDB.instance.refreshUI();
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Financia',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 53, 147, 201)),
        useMaterial3: true,
      ),
      home:  ScreenHome(),
      routes: {
        ScreenAddTransaction.routeName:(ctx) => const ScreenAddTransaction(),
      },
    );
  }
}
