import "package:flutter/material.dart";
import "package:plus_minus/expense_manager.dart";
import 'package:plus_minus/expense_overview/expense_input/currency_input.dart';

typedef void InsertExpenseCallback(Expense expense);

class ExpenseInput extends StatelessWidget {
  ExpenseInput(this.insertExpenseCallback);

  final InsertExpenseCallback insertExpenseCallback;

  final TextEditingController _amountController = new TextEditingController();
  final TextEditingController _categoryController = new TextEditingController();

  void parseAndPassExpense() {
    // TODO: Report more info for "getTextBeforeCursor on inactive InputConnection" bug at https://github.com/flutter/flutter/issues/11321
    var amount = int.parse(_amountController.text) / 100;
    var category = _categoryController.text;
    if (amount == null) return;

    var expense = new Expense.now(amount, category);
    insertExpenseCallback(expense);

    _amountController.clear();
    _categoryController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        color: Theme.of(context).cardColor,
      ),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Column(
          children: <Widget>[
            new CurrencyInput(
              controller: _amountController,
            ),
            new TextField(
              controller: _categoryController,
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(hintText: "Category"),
            ),
            new FlatButton(
              child: new Icon(Icons.add),
              onPressed: parseAndPassExpense,
            )
          ],
        ),
      ),
    );
  }
}
