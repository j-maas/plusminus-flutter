import "package:flutter_driver/flutter_driver.dart";
import "package:test/test.dart";

void main() {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });


    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });


    test("added expense is displayed", () async {
      // TODO: Refactor duplicated strings to fields, when import bug for flutter-dependent files is fixed (http://cogitas.net/write-integration-test-flutter/).
      SerializableFinder addExpenseButton = find.byValueKey("addExpenseButton");
      await driver.tap(addExpenseButton);

      SerializableFinder amountInput = find.byValueKey("amountInput");
      await driver.tap(amountInput);
      await driver.enterText("2685");
      SerializableFinder categoryInput = find.byValueKey("categoryInput");
      await driver.tap(categoryInput);
      await driver.enterText("Shoes");

      await driver.tap(addExpenseButton);
      SerializableFinder expenseList = find.byValueKey("expenseList");
      await driver.scroll(expenseList, 0.0, 300.0, new Duration(seconds: 1));

      // TODO: Check if list item displays correct amount.
      SerializableFinder newEntry = find.text("Shoes");
      await driver.waitFor(newEntry);
    });
}