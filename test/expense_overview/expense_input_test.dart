import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:plus_minus/expense_overview/expense_input.dart";
import "package:plus_minus/expense_storage.dart";

void main() {
  group("ExpenseInput", () {
    ExpenseInput expenseInput;
    Widget renderableWrapper;

    // TODO: Make TextField finding more robust by referencing their hints.
    Finder amountTextField = find.byType(TextField).first;
    Finder categoryTextField = find.byType(TextField).last;

    setUp(() async {
      expenseInput = new ExpenseInput();
      renderableWrapper = new MaterialApp(
        home: new Material(child: expenseInput),
      );
    });

    testWidgets("parses valid input", (WidgetTester tester) async {
      await tester.pumpWidget(renderableWrapper);

      await tester.enterText(amountTextField, "12345");
      await tester.enterText(categoryTextField, "Banana");

      Expense parsedExpense = expenseInput.parseExpense();
      Duration dateDifference =
          parsedExpense.date.difference(new DateTime.now());

      expect(parsedExpense.amount, equals(123.45));
      expect(parsedExpense.description, equals("Banana"));
      expect(dateDifference.inSeconds, lessThan(1));
    });

    testWidgets('throws error on invalid date', (WidgetTester tester) async {
      await tester.pumpWidget(renderableWrapper);
    }, skip: true);

    testWidgets('accepts empty description', (WidgetTester tester) async {
      await tester.pumpWidget(renderableWrapper);
    }, skip: true);

    testWidgets('calls submit callback on keyboard submit',
        (WidgetTester tester) async {
      await tester.pumpWidget(renderableWrapper);
    }, skip: true);
  });
}
