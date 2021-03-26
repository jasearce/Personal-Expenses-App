import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTrans;

  NewTransaction(this.addNewTrans);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitTransaction() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      print("Invalid data!");
      return;
    }

    widget.addNewTrans(
      enteredTitle,
      enteredAmount,
    );

    Navigator.of(context).pop();

    print("Entered title: " + enteredTitle);
    print("Entered amount: " + enteredAmount.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Title",
              ),
              controller: titleController, // fetch data del TextField
              onSubmitted: (_) =>
                  submitTransaction(), // con "_" anuncio a dart que el valor pasado por parametro no sera utilizado
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Amount",
              ),
              controller: amountController, // fetch data del TextField
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) =>
                  submitTransaction(), // con "_" anuncio a dart que el valor pasado por parametro no sera utilizado
            ),
            FlatButton(
              child: Text(
                "Add Transaction",
              ),
              textColor: Colors.purple,
              onPressed: submitTransaction,
            ),
          ],
        ),
      ),
    );
  }
}
