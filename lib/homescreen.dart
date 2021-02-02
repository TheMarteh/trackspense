import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:trackspensev2/constants.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:trackspensev2/budget.dart';
import 'package:trackspensev2/expense.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';


// List of initial budgets

List<Budget> initialBudgetSelection = [Budget(name: "No budgets added!", maxAmount: 0, timeWithBudget: 7),
Budget(name: "Boodschappen", maxAmount: 100, timeWithBudget: 7),
Budget(name: "Kleding", maxAmount: 200, timeWithBudget: 31),
Budget(name: "Uit eten", maxAmount: 50, timeWithBudget: 31),
Budget(name: "Hobby's", maxAmount: 100, timeWithBudget: 31),
Budget(name: "Huishouden", maxAmount: 100, timeWithBudget: 31),
Budget(name: "Persoonlijke verzorging", maxAmount: 25, timeWithBudget: 14),
Budget(name: "Huur", maxAmount: 485, timeWithBudget: 31),
Budget(name: "Abonnementen", maxAmount: 25, timeWithBudget: 31),
Budget(name: "Vrije tijd", maxAmount: 50, timeWithBudget: 7),

];
List<Expense> initialExpenseSelection = [Expense(id: 0, name: "No expenses added!", amount: 0, category: "None"),
Expense(id: 0, name: "No expenses added!0", amount: 0, category: "None"),
Expense(id: 0, name: "No expenses added!1", amount: 0, category: "None"),
Expense(id: 0, name: "No expenses added!2", amount: 0, category: "None"),
Expense(id: 0, name: "No expenses added!3", amount: 0, category: "None"),
Expense(id: 0, name: "No expenses added!4", amount: 0, category: "None"),
Expense(id: 0, name: "No expenses added!5", amount: 0, category: "None"),
Expense(id: 0, name: "No expenses added!6", amount: 0, category: "None"),
Expense(id: 0, name: "No expenses added!7", amount: 0, category: "None"),
Expense(id: 0, name: "No expenses added!8", amount: 0, category: "None"),
Expense(id: 0, name: "No expenses added!9", amount: 0, category: "None"),
Expense(id: 0, name: "No expenses added!10", amount: 0, category: "None"),
Expense(id: 0, name: "No expenses added!11", amount: 0, category: "None"),
Expense(id: 0, name: "No expenses added!12", amount: 0, category: "None"),

];
List<Budget> budgetSelection = initialBudgetSelection;
List<Expense> expenseSelection = initialExpenseSelection;


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  // DialogForm Variables
  final _formKey = GlobalKey<FormState>();
  Budget _newBudget = Budget();
  Expense _newExpense = Expense();
  String _currentSelectedValue = '';



  final _ctrlBudgetName = TextEditingController();
  List<TextEditingController> controllers;
  String allValues = '';

  // DialogForm Methods
  _resetForm() {
    _formKey.currentState.reset();
    _newBudget = Budget();
    _newExpense = Expense();
    // _newBudget = null;
    // for (var i=0; i < this.controllers.length; i++) 
    // {
    //   this.controllers[i].clear();
    //   print("Cleared!");
    // }
  }

  // Submit function of add/edit dialog
  _onSubmit(type) {
    var form = _formKey.currentState;
    if (form.validate()) {
      print("Valid");
      form.save();
      if (type == "addBudget"){
        // setState(() {
          _addBudget(_newBudget);
          print("Added budget");
        // });
      }
      else if (type == "addExpense") {
        _addExpense(_newExpense);
        print("Added Expense!");
      }
      Navigator.of(context, rootNavigator: true).pop('dialog');
      print("Allvalues: " + allValues);
      _resetForm();
    }
  }


  // Function to add a budget to the budgetSelection
  void _addBudget(Budget newObject) {
    setState(() {
        Budget newBudget = new Budget(name: newObject.name, maxAmount: newObject.maxAmount, timeWithBudget: newObject.timeWithBudget);
        if (budgetSelection[0].name == "No budgets added!") {budgetSelection.removeAt(0);}
        budgetSelection.add(newBudget);
        
    });
  }
  void _removeBudget(Budget budToRemove) {
    setState(() {
      budgetSelection.remove(budToRemove);
    });
  }

  // Function to add a budget to the budgetSelection
  void _addExpense(Expense newObject) {
    setState(() {
        Expense newExpense = new Expense(name: newObject.name, amount: newObject.amount, category: newObject.category);
        if (expenseSelection[0].name == "No expenses added!") {expenseSelection.removeAt(0);}
        expenseSelection.add(newExpense);
        budgetSelection.forEach((element) {
          if (element.name == newExpense.category) {
            element.currentAmount += newExpense.amount;
          }
         });
        
    });
  }

  void _removeExpense(Expense expToRemove) {
    setState(() {
      expenseSelection.remove(expToRemove);
    });
  }

  // Main alert dialog (add or edit form)
  showAlertDialog(BuildContext context, String type, {var itemToEdit}) async {

    // Setting  up the buttons
    List<Widget> buttons = [];
    String buttonText;  
    
    // seting up the AlertDialog
    String alertTitle;
    List<Widget> fields = [];    
    if (type == "addBudget") {
      buttonText = "Add new Budget";
      alertTitle = "Add new Budget";
      print("Adding Fields");

      //Field for Budget name
      fields.add(
        TextFormField(

          decoration: InputDecoration(labelText: 'Budget name'),
          validator: (val) =>
                            (val.length == 0 ? 'This field is required!' : null),
          onSaved: (val) => {
            // setState((){
            print(val),
            _newBudget.name = val,
            // }),
          }

        )
      );

      //Field for budget amount
      fields.add(
        TextFormField(
          inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
          decoration: InputDecoration(labelText: 'Budget amount'),
          validator: (val) =>
                            (val.length == 0 ? 'This field is required!' : null),
          onSaved: (val) => { 
          // setState((){ 
            print(val),
            _newBudget.maxAmount = int.parse(val),
            }
          // }),

          // onSaved: (val) => {
          //   print(val),
          //   allValues = allValues + val,
          //   _addBudget(Budget(val, 50, 10))
          // },

        )
      );

      // Field for budget timeframe
      fields.add(
        TextFormField(
          inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
          decoration: InputDecoration(labelText: 'Budget timeframe'),
          validator: (val) =>
                            (val.length == 0 ? 'This field is required!' : null),
          onSaved: (val) => {
          // setState((){
            print(val),
            _newBudget.timeWithBudget = int.parse(val),
          }
          // }),

        )
      );

      

    }
    else if (type == "addExpense") {      
      buttonText = "Add new expense";
      alertTitle = "Add new " + type;
      fields.add(
        TextFormField(

          decoration: InputDecoration(labelText: 'Expense name'),
          validator: (val) =>
                            (val.length == 0 ? 'This field is required!' : null),
          onSaved: (val) => {
            // setState((){
            print(val),
            _newExpense.name = val,
            // }),
          }

        )
      );
      fields.add(
        TextFormField(

          decoration: InputDecoration(labelText: 'Expense amount'),
          validator: (val) =>
                            (val.length == 0 ? 'This field is required!' : null),
          onSaved: (val) => {
            // setState((){
            print(val),
            _newExpense.amount = int.parse(val)
            // }),
          }

        )
      );


      // Test field


      // List<<String><String>> datasource;
      List<dynamic>datasource = [];

      
      for(var i=0;i<budgetSelection.length;i++){
        datasource.add({'name': budgetSelection[i].name.toString(), 'value': budgetSelection[i].name.toString()});
        /*
        datasource.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  })
        */

        /*
        datasource.add({
          DropdownMenuItem<String>(
            value: budgetSelection[i].name,
            child: Text(budgetSelection[i].name),
          )
        });
        */
      }
      var _currencies = [
        "Food",
        "Transport",
        "Personal",
        "Shopping",
        "Medical",
        "Rent",
        "Movie",
        "Salary"
      ];
      // datasource.toList();
     
     /*
      fields.add(
        FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  // labelStyle: textStyle,
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  hintText: 'Please select expense',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
              isEmpty: _currentSelectedValue == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _currentSelectedValue,
                  isDense: true,
                  onChanged: (String newValue) {
                    setState(() {
                      _currentSelectedValue = newValue;
                      state.didChange(newValue);
                    });
                  },
                  items: _currencies.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        )
      */



        // FormField<String>(
        //   builder: (FormFieldState<String> state) {
        //     return InputDecorator(
        //       decoration: InputDecoration(
        //           // labelStyle: textStyle,
        //           errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
        //           hintText: 'Please select expense',
        //           border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
        //       isEmpty: _currentSelectedValue == '',
        //       child: DropdownButtonHideUnderline(
        //         child: DropdownButton<String>(
        //           value: _currentSelectedValue,
        //           isDense: true,
        //           onChanged: (String newValue) {
        //             setState(() {
        //               _currentSelectedValue = newValue;
        //               state.didChange(newValue);
        //             });
        //           },
        //           items: datasource.map((String value) {
        //             return DropdownMenuItem<String>(
        //               value: value,
        //               child: Text(value),
        //             );
        //           }).toList(),
        //         ),
        //       ),
        //     );
        //   },
        // )
        // );


      
      fields.add(DropDownFormField(
                  contentPadding: EdgeInsets.all(0),
                  filled: false,
                  titleText: '',
                  hintText: 'Select category',
                  value: _currentSelectedValue,
                  onSaved: (value) {
                    setState(() {
                      _newExpense.category = value;
                      print("onSaved" + _newExpense.category);
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      _currentSelectedValue = value;
                      print("onChanged" + _newExpense.category);
                    });
                  },
                  dataSource: datasource,
                  textField: 'name',
                  valueField: 'value',
                ),
              );
              
             
    }
    else if (type == "editBudget"){
      buttonText = "Edit budget";
      alertTitle = "Edit " + type + ": "+ itemToEdit.name;
    }
    
    else if (type == "editExpense"){
      buttonText = "Edit expense";
      alertTitle = "Edit " + type + ": "+ itemToEdit.name;
    }





    // Cancel button or reset button. Used in every form
    Widget cancelButton = FlatButton(
        child: Text("Cancel"),
        onPressed:  () {_resetForm();},
      );
    buttons.add(cancelButton);

        // Confirmation button. Changes according to type.
    Widget confButton = FlatButton(
      child: Text(buttonText),
      onPressed:  () {
        _onSubmit(type);
        if (_formKey.currentState.validate()) {
        }
      },
    );
    buttons.add(confButton);

    AlertDialog dialogScreen = AlertDialog(
      insetPadding: EdgeInsets.all(50),
      title: Text(alertTitle),
      content:

        // Main content of Dialog Box

        Container(
          width: 530530,
          child: Form(
            key: _formKey,
            child: Column(
            mainAxisSize: MainAxisSize.min,
            children: fields,
          ),
          ),

 
          

          // Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [

          //     ListView.builder(
          //       shrinkWrap: true,
          //       physics: NeverScrollableScrollPhysics(),
          //       itemCount: filteredControllers.length,
          //       itemBuilder: (BuildContext context, int index) {
          //         var data = filteredControllers[index];

          //         // Main view of a budget
          //         Widget field = TextFormField(
                    
          //           key: _formKey,
          //           controller: data,

          //         );
          //         print("making field");
          //         return field;

          //       },
          //     ),

          //   ],
          // ),


          padding: EdgeInsets.fromLTRB(20, 30, 20, 20),

        ),

      
      actions: buttons
    );


    // show the dialog
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialogScreen;
      },
    ).then((value) => _resetForm());
  }


  @override
  Widget build(BuildContext context) {
    double height = 0.0 + 80 * budgetSelection.length;

    if (height > MediaQuery.of(context).size.height*0.6) {height = MediaQuery.of(context).size.height*0.6;}
    double otherHeight = MediaQuery.of(context).size.height-110;


    return Scaffold(
      appBar: myAppBar("Budgets"),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(children: <Widget>[

/*
SliverList(delegate: SliverChildBuilderDelegate((context, index) {
  return budgetCard(initialBudgetSelection[0]);
},
childCount: 2,)),


            SliverAppBar(
              title: Text("SliverAppBar"),
              expandedHeight: 100.0,
              
            ),
budgetSliverView(budgetSelection),

SliverPersistentHeader(
    delegate: SectionHeaderDelegate("Section B"),
    pinned: true,
),

expenseSliverView(expenseSelection),



*/









            budgetListView(budgetSelection, height),
            Container(width: 350.0, child: expenseListView(expenseSelection, otherHeight),),
            ],),
          
    ),

    // Floating action button for adding Budgets and Expenses
    floatingActionButton: SpeedDial(
      child: Icon(Icons.add),
      onOpen: () => print("Opening Speeddial"),
      onClose: () => print("Closing Speeddial"),
      shape: CircleBorder(),
      children: [

        // Add new expense SpeedDial button
        SpeedDialChild(
          elevation: 5,
          child: Icon(Icons.receipt_long_outlined),
          backgroundColor: myPrimaryColor,
          label: "New Expense",
          // labelStyle: TextStyle(fontSize: 18.0),

          onTap: () {print("Add new Expense - Placeholder");
            showAlertDialog(context, "addExpense", itemToEdit: expenseSelection[0]);
          },
        ),

        // Add new budget SpeedDial button
        SpeedDialChild(
          elevation: 5,
          child: Icon(Icons.bar_chart_outlined),
          backgroundColor: myPrimaryColor,
          label: "New Budget",
          // labelStyle: TextStyle(fontSize: 18.0),

          onTap: () {
            
            showAlertDialog(context, "addBudget");
          },
        ),
      ],
    ),
    );
  }
  
  // Widget that shows all budgets
  Widget budgetListView(_budgets, h) {
    var reversedList = _budgets.reversed.toList();


    return Container(
      // width: 100,
      height: h,
      // Decoration box
      padding: EdgeInsets.only(
        left: myDefaultPadding,
        right: myDefaultPadding,
        bottom: 36 + myDefaultPadding,
      ),
      decoration: BoxDecoration(
        color: myPrimaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
      ),

      // Main builder
      child:
      Container(
        child: 
      ListView.builder(
        shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
        itemCount: _budgets.length,
        itemBuilder: (BuildContext context, int index) {
          Budget data = reversedList[index];

          // Main view of a budget
          Widget card = budgetCard(data);
          return card;

        },
      )
    ),);
    
    
  }

  // Widget budgetSliverView(_budgets) {
  //   return SliverList(delegate: SliverChildBuilderDelegate((context, index) {
      
  //       return Container(child: budgetCard(initialBudgetSelection[index]),
        
  //       decoration: BoxDecoration(color: myPrimaryColor),);
  //     },
  //     childCount: _budgets.length,));
  // }


  Widget budgetCard(Budget budget) {
    // budgetCard template

    return Card(
      /*
      margin: EdgeInsets.only(
        left: myDefaultPadding,
        right: myDefaultPadding,
        bottom: 36 + myDefaultPadding,),
      */
      child: ListTile(
        leading: Icon(Icons.bar_chart_outlined),
        title: Text(budget.name),
        subtitle: Text(budget.maxAmount.toString()),
        trailing: Text(budget.currentAmount.toString()),
        onLongPress: () {this._removeBudget(budget);}
        )

    );
  }

  Widget expenseListView(_expenses, h) {
    var reversedList = _expenses.reversed.toList();
    return Container(
      height: h,
      child:
        ListView.builder(
          
          shrinkWrap: true,
          
          itemCount: _expenses.length,
          itemBuilder: (BuildContext context, int index) {
            Expense data = reversedList[index];

            // Main view of a budget
            Widget card = expenseCard(data);
            return card;
             
            

          },
        )
    );
  }

  Widget expenseSliverView(_expenses) {
    var reversedList = _expenses.reversed.toList();
    
    return SliverList(delegate: SliverChildBuilderDelegate((context, index) {
        return expenseCard(reversedList[index]);
      },
      childCount: initialExpenseSelection.length,));
    
  }

  Widget expenseCard(Expense expense) {
    // expenseCard template

    return Card(
      child: ListTile(
        
        leading: Icon(Icons.receipt_outlined),
        title: Text(expense.name),
        subtitle: Text(expense.category),
        trailing: Text(expense.amount.toString()),
        onLongPress: (){
          this._removeExpense(expense);
        },
      )
    );
  }




}

// Appbar constructor
AppBar myAppBar(title) {
  return AppBar(
    elevation: 0,
    title: Text(title),
  );
}


class SectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final double height;

  SectionHeaderDelegate(this.title, [this.height = 50]);

  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).primaryColor,
      alignment: Alignment.center,
      child: Text(title),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}