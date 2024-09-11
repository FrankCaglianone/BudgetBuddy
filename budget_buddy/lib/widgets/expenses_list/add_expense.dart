import 'package:budget_buddy/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class AddExpense extends StatefulWidget{
  const AddExpense({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddExpense();
  }
}




class _AddExpense extends State<AddExpense> {

  // Controllers Instantiation
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  // Store Variables
  Category _selectedCategory = Category.leisure;

  // Controllers Disposal
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }



  final formatter = DateFormat.yMd();
  DateTime? _selectedDate;

  void _showDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(context: context, firstDate: firstDate, lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Add Title
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text("Title")
            ),
          ),

          Row(
            children: [
              // Add Amount
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$',
                    label: Text("Amount")
                  ),
                ),
              ),

              // Sized Box
              const SizedBox(width: 10),

              // Add Date
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_selectedDate == null ? "Select date" : formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: _showDatePicker, 
                      icon: const Icon(Icons.calendar_month)
                    ),
                  ],
                ),
              )
            ],
          ),

          const SizedBox(height: 25),

          // Buttons
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values.map(
                  (category) => DropdownMenuItem(
                    value: category,
                    child: Text(category.name.toUpperCase())
                  )
                ).toList(), 
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                }
              ),

              const Spacer(),

              
              // Cancel Expense Button
              TextButton(
                 onPressed: () {
                  Navigator.pop(context);
                 }, 
                 child: const Text("Cancel")
              ),

              // Add Expense Button
              ElevatedButton(
                onPressed: () {
                  print(_titleController.text);
                  print(_amountController.text);
                }, 
                child: const Text("Save Expense")
              ),

            ],
          )
        ],
      ),
    );
  }
}