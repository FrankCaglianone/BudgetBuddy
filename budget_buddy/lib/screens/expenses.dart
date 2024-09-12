import 'package:budget_buddy/models/expense.dart';
import 'package:budget_buddy/widgets/expenses_list/add_expense.dart';
import 'package:budget_buddy/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {

  final List<Expense> _dummies = [
    Expense(title: "dummy 1", amount: 10, date: DateTime.now(), category: Category.food),
    Expense(title: "dummy 2", amount: 20, date: DateTime.now(), category: Category.leisure),
    Expense(title: "dummy 3", amount: 30, date: DateTime.now(), category: Category.travel),
    Expense(title: "dummy 4", amount: 40, date: DateTime.now(), category: Category.work),
  ];



  void _openAddExpenseOverlay() {
    showModalBottomSheet(isScrollControlled: true, context: context, builder: (ctx) {
      return AddExpense(onAddExpense: _addExpense);
    });
  }



  void _addExpense(Expense expense) {
    setState(() {
      _dummies.add(expense);
    });
  }


  void _removeExpense(Expense expense) {
    setState(() {
      _dummies.remove(expense);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add)),
        ]
      ),
      body: Column(
        children: [
          const Text("chart"),
          Expanded(child: ExpensesList(expenses: _dummies, onRemoveExpense: _removeExpense)),
        ],
      ),
    );
  }
}
