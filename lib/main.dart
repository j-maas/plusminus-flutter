import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plus_minus/expense_manager.dart';

void main() {
  Intl.defaultLocale = "de_DE";
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

  _ExpenseOverviewState() {
    _expenseManager
      ..add(new Expense.now(1.11, "First"))
      ..add(new Expense.now(2.22, "Second"))
      ..add(new Expense.now(3.33, "Third"))
      ..add(new Expense.now(4.44, "Fourth"));
  }

  void insertExpense(Expense expense) {
    setState(() {
      _expenseManager.add(expense);
    });
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
          new ExpenseInput(insertExpense),
        ],
      ),
    );
  }
}

class ExpenseListItem extends StatelessWidget {
  final Expense expense;

  final NumberFormat _currency = new NumberFormat.currency(symbol: '€');
  final DateFormat _date = new DateFormat("d.M.y", "en_US");

  ExpenseListItem({this.expense});

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      leading: new CircleAvatar(
        child: new Text(
            expense.description.length > 0 ? expense.description[0] : ""),
        backgroundColor: Theme.of(context).accentColor,
      ),
      title: new Text(
        expense.description,
        style: Theme.of(context).textTheme.body2,
      ),
      subtitle: new Text(
        _date.format(expense.date),
        style: Theme.of(context).textTheme.body1,
      ),
      trailing: new Text(
        _currency.format(expense.amount),
        overflow: TextOverflow.fade,
        softWrap: false,
        style: new TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}

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
              onPressed: parseAndPassExpense,
            )
          ],
        ),
      ),
    );
  }
}
