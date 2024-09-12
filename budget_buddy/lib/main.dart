import 'package:budget_buddy/screens/expenses.dart';
import 'package:flutter/material.dart';



var myColorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 60, 90, 78));



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Buddy',
      theme: ThemeData().copyWith(
        colorScheme: myColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: myColorScheme.onPrimaryContainer,
          foregroundColor: myColorScheme.primaryContainer,
        )
      ),
      home: const Expenses()
    );
  }
}
