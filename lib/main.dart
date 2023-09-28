import 'package:flutter/material.dart';
import 'package:moneymanager/screens/home/screen_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 53, 147, 201)),
        useMaterial3: true,
      ),
      home:  ScreenHome(),
    );
  }
}
