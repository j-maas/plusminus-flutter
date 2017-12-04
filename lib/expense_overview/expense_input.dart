import "package:flutter/material.dart";
import "package:plus_minus/expense_manager.dart";

typedef void InsertExpenseCallback(Expense expense);

class ExpenseInput extends StatelessWidget {
  final InsertExpenseCallback insertExpenseCallback;

  final TextEditingController _amountController = new TextEditingController();

  final TextEditingController _categoryController = new TextEditingController();

  ExpenseInput(this.insertExpenseCallback);

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
            new FlatButton(
              child: new Icon(Icons.add),
              onPressed: parseAndPassExpense,
            )
          ],
        ),
      ),
    );
  }

  void parseAndPassExpense() {
    // TODO: Report more info for "getTextBeforeCursor on inactive InputConnection" bug at https://github.com/flutter/flutter/issues/11321
    var amount = int.parse(_amountController.text) / 100;
    var category = _categoryController.text;

    var expense = new Expense.now(amount, category);
    insertExpenseCallback(expense);

    _amountController.clear();
    _categoryController.clear();
  }
}
