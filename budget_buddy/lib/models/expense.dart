import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';




final formatter = DateFormat.yMd();
const uuid = Uuid();


const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

enum Category {
  food,
  travel,
  leisure,
  work
}




class Expense {
  // Constructor
  Expense({
    required this.title, 
    required this.amount, 
    required this.date,
    required this.category
  }): id = uuid.v4();

  // Variables
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  // Getter Methods
  String get formattedDate {
    return formatter.format(date);
  }
}


class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});

  // Additional constructor
  ExpenseBucket.forCategory(List<Expense> allExpenes, this.category) 
    : expenses = allExpenes.where( (expense) {
      return expense.category == category;
    }).toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final exp in expenses) {
      sum += exp.amount;
    }
    return sum;
  }
}
