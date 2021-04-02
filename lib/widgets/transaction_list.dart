import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> inputTransactions;

  TransactionList(this.inputTransactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: inputTransactions.isEmpty
          ? Column(
              children: [
                Text(
                  "No Transactions Added Yet!",
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/image/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (buildContext, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 10,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            '\$${inputTransactions[index].amount.toStringAsFixed(2)}',
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      inputTransactions[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(inputTransactions[index].date),
                    ),
                  ),
                );
              },
              itemCount: inputTransactions.length,
            ),
    );
  }
}
