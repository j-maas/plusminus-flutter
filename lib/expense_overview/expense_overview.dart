import "package:flutter/material.dart";
import "package:plus_minus/expense_manager.dart";
import "package:plus_minus/expense_overview/expense_input.dart";
import "package:plus_minus/expense_overview/expense_list.dart";

class ExpenseOverview extends StatefulWidget {
  final String title;

  ExpenseOverview({Key key, this.title}) : super(key: key);

  @override
  _ExpenseOverviewState createState() => new _ExpenseOverviewState();
}

class _ExpenseOverviewState extends State<ExpenseOverview> {
  ExpenseManager _expenseManager = new ExpenseManager();

  _ExpenseOverviewState() {
    _expenseManager
      ..add(new Expense.now(1.11, "First"))
      ..add(new Expense.now(2.22, "Second"))
      ..add(new Expense.now(3.33, "Third"))
      ..add(new Expense.now(4.44, "Fourth"));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Column(
        children: <Widget>[
          new Expanded(
            child: new ExpenseList(_expenseManager.getAll()),
          ),
          new Divider(
            height: 1.0,
          ),
          new ExpenseInput(insertExpense),
        ],
      ),
    );
  }

  void insertExpense(Expense expense) {
    setState(() {
      _expenseManager.add(expense);
    });
  }
}
