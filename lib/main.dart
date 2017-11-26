import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plus_minus/expense_manager.dart';

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
  ExpenseManager _expenseManager = new ExpenseManager();

  final TextEditingController _amountController = new TextEditingController();
  final TextEditingController _categoryController = new TextEditingController();

  void insert() {
    var amount = int.parse(_amountController.text) / 100;
    var category = _categoryController.text;
    var expense = new Expense.now(amount, category);
    setState(() {
      _expenseManager.add(expense);
    });

    _amountController.clear();
    _categoryController.clear();
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
            child: new ListView(
              shrinkWrap: true,
              reverse: true,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              children: _expenseManager.getAll().map((Expense expense) {
                return new ExpenseListItem(
                  expense: expense,
                );
              }).toList(),
            ),
          ),
          new Divider(
            height: 1.0,
          ),
          new Container(
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
                    decoration: new InputDecoration(hintText: 'Amount'),
                  ),
                  new TextField(
                    controller: _categoryController,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(hintText: 'Category'),
                  ),
                  new FlatButton(
                    child: new Icon(Icons.add),
                    onPressed: insert,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExpenseListItem extends StatelessWidget {
  ExpenseListItem({this.expense});

  final Expense expense;

  final NumberFormat _currency =
      new NumberFormat.currency(locale: "de_DE", symbol: '€');

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      leading:
          new CircleAvatar(child: new Text(expense.description.toString()[0])),
      title: new Text(expense.description),
      trailing: new Text(_currency.format(expense.amount)),
    );
  }
}
