import "package:plus_minus/expense_storage.dart";
import "package:test/test.dart";

void main() {
  ExpenseStorage expenseStorage;
  setUp(() {
    expenseStorage = new ExpenseStorage();
  });
  group("ExpenseStorage", () {
    test("adds and retrieves expenses", () {
      Expense expense = new Expense.now(100.34, "Random");
      expenseStorage.add(expense);

      List<Expense> allExpenses = expenseStorage.getAll();
      expect(allExpenses, equals(<Expense>[expense]));
    });
  });
}
