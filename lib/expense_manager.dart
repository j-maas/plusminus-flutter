class Expense {
  final double amount;
  final String description;
  final DateTime date;

  Expense(this.amount, this.description, this.date);
  Expense.now(this.amount, this.description) : date = new DateTime.now();
}

class ExpenseManager {
  final List<Expense> allExpenses = [];

  void add(Expense expense) {
    allExpenses.add(expense);
  }

  List<Expense> getAll() {
    return allExpenses;
  }
}
