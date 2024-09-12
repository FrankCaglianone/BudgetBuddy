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
    final expenseIndex = _dummies.indexOf(expense);

    setState(() {
      _dummies.remove(expense);
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense Deleted"),
        action: SnackBarAction(label: "Undo", onPressed: () {
          setState(() {
            _dummies.insert(expenseIndex, expense);
          });
        }),
      ));
  }



  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(child: Text("No expenses found. Start adding some!"));
    
    if (_dummies.isNotEmpty) {
      mainContent = ExpensesList(expenses: _dummies, onRemoveExpense: _removeExpense);
    }




    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add)),
        ]
      ),
      body: Column(
        children: [
          const Text("chart"),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
