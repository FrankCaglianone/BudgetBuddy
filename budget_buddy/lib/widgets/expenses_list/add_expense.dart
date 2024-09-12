import 'package:budget_buddy/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class AddExpense extends StatefulWidget{
  const AddExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<StatefulWidget> createState() {
    return _AddExpense();
  }
}







class _AddExpense extends State<AddExpense> {

  //* ----- STORING VARIABLES -----
  Category _selectedCategory = Category.leisure;
  DateTime? _selectedDate;
  // Controllers Instantiation
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
 


  //* CONTROLLERS DISPOSAL
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }



  //* ----- DATE FORMATTER -----
  final formatter = DateFormat.yMd();
  void _showDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(context: context, firstDate: firstDate, lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }




  //* ----- FORM SUBMISSION -----
  void _submitForm() {
    final enteredAmount = double.tryParse(_amountController.text);
    final bool amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if(_titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate == null) {
      showDialog(context: context, builder: (ctx) {
        return AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text("Please make sure to enter all fields."),
          actions: [
            TextButton(onPressed: () {
              Navigator.pop(ctx);
              }, 
              child: const Text("data"),
            )
          ],
        );
      });
      return;
    }

    widget.onAddExpense(Expense(
      title: _titleController.text, 
      amount: enteredAmount, 
      date: _selectedDate!, 
      category: _selectedCategory
      )
    );
    Navigator.pop(context);
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
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
                  _submitForm();
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