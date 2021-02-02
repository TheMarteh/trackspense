import 'package:trackspensev2/expense.dart';
import 'package:trackspensev2/budget.dart';

class User {
  User(this.name, this.budgets, this.expenses);
  String name;
  List<Budget> budgets;
  List<Expense> expenses;
}