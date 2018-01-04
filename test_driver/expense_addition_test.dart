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
      // TODO: Refactor duplicated strings to field, when import bug for flutter-dependent files is fixed (http://cogitas.net/write-integration-test-flutter/).
      SerializableFinder addExpenseButton = find.byValueKey("addExpenseButton");
      await driver.tap(addExpenseButton);
    });
}