import 'package:budget_buddy/models/expense.dart';
import 'package:budget_buddy/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget{
  const ExpensesList({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: expenses.length, itemBuilder: (context, index) {
      return ExpensesItem(expense: expenses[index]);
    });
  }
  
}