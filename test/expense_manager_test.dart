import 'package:plus_minus/expense_manager.dart';
import 'package:test/test.dart';

void main() {
  ExpenseManager expenseManager;
  setUp(() {
    expenseManager = new ExpenseManager();
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