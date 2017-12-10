import "package:flutter/material.dart";
import "package:plus_minus/expense_storage.dart";
import "package:plus_minus/expense_overview/expense_input.dart";
import "package:plus_minus/expense_overview/expense_list.dart";

class ExpenseOverview extends StatefulWidget {
  final String title;

  ExpenseOverview({Key key, this.title}) : super(key: key);

  @override
  _ExpenseOverviewState createState() => new _ExpenseOverviewState();
}

class _ExpenseOverviewState extends State<ExpenseOverview> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PersistentBottomSheetController _bottomSheetController;
  ExpenseInput _expenseInput;
  VoidCallback _fabCallback;

  ExpenseStorage _expenseManager = new ExpenseStorage();

  _ExpenseOverviewState() {
    _expenseManager
      ..add(new Expense.now(1.11, "First"))
      ..add(new Expense.now(2.22, "Second"))
      ..add(new Expense.now(3.33, "Third"))
      ..add(new Expense.now(4.44, "Fourth"))
      ..add(new Expense.now(5.55, "Fifth"))
      ..add(new Expense.now(6.66, "Sixth"))
      ..add(new Expense.now(7.77, "Seventh"))
      ..add(new Expense.now(8.88, "Eigth"))
      ..add(new Expense.now(9.99, "Ninth"));
  }

  @override
  void initState() {
    super.initState();
    _fabCallback = _showExpenseInput;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Column(
        children: <Widget>[
          new Expanded(
            child: new ExpenseList(_expenseManager.getAll()),
          ),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        child: _getFabIcon(),
        onPressed: _fabCallback,
      ),
    );
  }

  void _showExpenseInput() {
    setState(() {
      _fabCallback = _addExpenseAndCloseInput;
    });

    _expenseInput = new ExpenseInput();
    _bottomSheetController = _scaffoldKey.currentState
        .showBottomSheet((BuildContext context) => _expenseInput)
          ..closed.whenComplete(() {
            setState(() {
              _fabCallback = _showExpenseInput;
            });
          });
  }

  void _addExpenseAndCloseInput() {
    var newExpense = _expenseInput.parseExpense();
    setState(() {
      _expenseManager.add(newExpense);
    });
    _bottomSheetController.close();
  }

  Widget _getFabIcon() {
    if (_fabCallback == _showExpenseInput) {
      return new Icon(Icons.add);
    } else {
      return new Icon(Icons.done);
    }
  }
}
