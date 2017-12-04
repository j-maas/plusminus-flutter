import "package:plus_minus/expense_storage.dart";
import "package:test/test.dart";

void main() {
  ExpenseStorage expenseManager;
  setUp(() {
    expenseManager = new ExpenseStorage();
  });
  group("ExpenseManager", ()
  {
    test("adds and retrieves expenses", () {
      Expense expense = new Expense.now(100.34, "Random");
      expenseManager.add(expense);

      List<Expense> allExpenses = expenseManager.getAll();
      expect(allExpenses, equals(<Expense>[expense]));
    });
  });
}