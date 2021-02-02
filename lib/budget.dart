class Budget {
  String name;
  int maxAmount;
  int timeWithBudget;
  Budget({this.name, this.maxAmount, this.timeWithBudget});

  int currentAmount = 0;
  double budgetRelative;
  int budgetAbsolute;

  addToCurrentAmount(value){
    this.currentAmount += value;
  }

  calculateBudgetRelative(){
    this.budgetRelative = this.currentAmount / this.maxAmount;
  } 

  calculateBudgetAbsolute(){
    this.budgetAbsolute = this.maxAmount - this.currentAmount;
  }

  
}