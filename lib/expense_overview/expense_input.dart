import "package:flutter/material.dart";
import "package:plus_minus/expense_storage.dart";

typedef void InsertExpenseCallback(Expense expense);

class ExpenseInput extends StatelessWidget {
  final TextEditingController _amountController = new TextEditingController();
  final TextEditingController _categoryController = new TextEditingController();
  final FocusNode _categoryFocus = new FocusNode();

  final VoidCallback submittedCallback;

  ExpenseInput({this.submittedCallback});

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new TextField(
              autofocus: true,
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(hintText: "Amount"),
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(_categoryFocus);
              },
            ),
            new TextField(
                focusNode: _categoryFocus,
                controller: _categoryController,
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(hintText: "Category"),
                onSubmitted: (_) {
                  submittedCallback();
                }),
          ],
        ),
      ),
    );
  }

  Expense parseExpense() {
    double amount = 0.0;
    try {
      amount = int.parse(_amountController.text) / 100;
    } catch (FormatException) {
      throw new StateError("TextField for amount"
          " containing '${_amountController.text}'"
          " could not be parsed to a number.");
    }
    String category = _categoryController.text;

    Expense expense = new Expense.now(amount, category);

    _amountController.clear();
    _categoryController.clear();

    return expense;
  }
}
