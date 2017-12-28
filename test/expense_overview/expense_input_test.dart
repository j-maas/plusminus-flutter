import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:plus_minus/expense_overview/expense_input.dart";
import "package:plus_minus/expense_storage.dart";

void main() {
  group("ExpenseInput", () {
    testWidgets("parses valid input", (WidgetTester tester) async {
      ExpenseInput _expenseInput = new ExpenseInput();
      await tester.pumpWidget(
        new MaterialApp(
          home: new Material(child: _expenseInput),
        ),
      );

      // TODO: Make TextField finding more robust by referencing their hints.
      await tester.enterText(find.byType(TextField).first, "12345");
      await tester.enterText(find.byType(TextField).last, "Banana");

      Expense parsedExpense = _expenseInput.parseExpense();
      Duration dateDifference = parsedExpense.date.difference(new DateTime.now());

      expect(parsedExpense.amount, equals(123.45));
      expect(parsedExpense.description, equals("Banana"));
      expect(dateDifference.inSeconds, lessThan(1));
    });
  });
}
