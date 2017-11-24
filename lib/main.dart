import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'PlusMinus',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new ExpenseOverview(title: 'PlusMinus'),
    );
  }
}

class ExpenseOverview extends StatefulWidget {
  ExpenseOverview({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ExpenseOverviewState createState() => new _ExpenseOverviewState();
}

class _ExpenseOverviewState extends State<ExpenseOverview> {
  List<Expense> _expenses = [
    new Expense(description: 'First', amount: 10),
    new Expense(description: 'Second', amount: 20),
    new Expense(description: 'Third', amount: 30),
    new Expense(description: 'Fourth', amount: 120),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: _expenses.map((Expense expense) {
            return new ExpenseListItem(
              expense: expense,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ExpenseListItem extends StatelessWidget {
  ExpenseListItem({this.expense});

  final Expense expense;

  String printCurrency(int value) {
    var whole = (value / 100).round();
    var cents = value % 100;
    return '$whole,$cents €';
  }

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      leading:
          new CircleAvatar(child: new Text(expense.description.toString()[0])),
      title: new Text(expense.description),
      trailing: new Text(printCurrency(expense.amount)),
    );
  }
}

class Expense {
  Expense({this.description, this.amount});

  final String description;
  final int amount;
}
