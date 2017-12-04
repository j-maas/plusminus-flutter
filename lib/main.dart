import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:plus_minus/expense_overview/expense_overview.dart";

void main() {
  Intl.defaultLocale = "de_DE";
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "PlusMinus",
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new ExpenseOverview(title: "PlusMinus"),
    );
  }
}
