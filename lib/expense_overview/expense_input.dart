import "package:flutter/material.dart";
import "package:plus_minus/expense_manager.dart";

typedef void InsertExpenseCallback(Expense expense);

class ExpenseInput extends StatelessWidget {
  final TextEditingController _amountController = new TextEditingController();
  final TextEditingController _categoryController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(hintText: "Amount"),
            ),
            new TextField(
              controller: _categoryController,
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(hintText: "Category"),
            ),
          ],
        ),
      ),
    );
  }

  Expense parseExpense() {
    var amount = int.parse(_amountController.text) / 100;
    var category = _categoryController.text;

    var expense = new Expense.now(amount, category);

    _amountController.clear();
    _categoryController.clear();

    return expense;
  }
}
