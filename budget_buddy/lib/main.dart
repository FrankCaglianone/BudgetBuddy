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
      //* App Title
      title: 'Budget Buddy',

      //* THEMES
      theme: ThemeData().copyWith(
        // Setting color scheme
        colorScheme: myColorScheme,

        // Setting global App Bar Theme
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: myColorScheme.onPrimaryContainer,
          foregroundColor: myColorScheme.primaryContainer,
        ),

        // Setting global Card Theme
        cardTheme: const CardTheme().copyWith(
          color: myColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),

        // Setting global Eleveated Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: myColorScheme.onPrimaryContainer,
          ),
        ),

        // Setting global Text Theme
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(color: myColorScheme.onSecondaryContainer),
        ),

      ),

      //* HOME WIDGET
      home: const Expenses()
    );
  }
}
