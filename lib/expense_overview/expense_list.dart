import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:plus_minus/expense_storage.dart";

class ExpenseList extends StatelessWidget {
  final List<Expense> _allExpenses;

  ExpenseList(this._allExpenses);

  @override
  Widget build(BuildContext context) {
    List<Widget> _expenseList = _allExpenses.map<Widget>((Expense expense) {
      return new ExpenseListItem(
        expense: expense,
      );
    }).toList()
      ..insert(0, new Container(height: ExpenseListItem.height));

    return new ListView(
      key: new Key("expenseList"),
      shrinkWrap: true,
      reverse: true,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemExtent: ExpenseListItem.height,
      children: _expenseList,
    );
  }
}

class ExpenseListItem extends StatelessWidget {
  static final double height = 72.0;

  final Expense expense;

  final NumberFormat _currency = new NumberFormat.currency(symbol: "€");
  final DateFormat _date = new DateFormat("dd.MM.y", "en_US");

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
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
