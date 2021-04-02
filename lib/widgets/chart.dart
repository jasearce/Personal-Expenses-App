import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  // El widget Chart recibira la lista de transacciones realizadas recientemente
  // para poder hacer el seguimiento de las transacciones realizadas.

  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  // Con el getter groupedTransactionValues, obtengo un mapa con el dia y
  // la cantidad de transacciones realizadas en ese dia. Para ello, se utiliza
  // el constructor List.generate() para generar una lista con los 7 dias de
  // la semana y con el index creamos cada uno de los dias mediante
  // DateTime.now(). El indice 0 seria el dia actual, el indice 1 seria el dia
  // anterior y asi sucesivamente.
  // Finalmente, se compara si el dia, el mes y el año de la transaccion es
  // igual a la fecha actual para agregar el valor de la transaccion total para
  // dicho dia.

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      print(DateFormat.E().format(weekDay) + ': ' + '$totalSum');

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((transactionData) {
            return Expanded(
              child: ChartBar(
                transactionData['day'],
                transactionData['amount'],
                totalSpending == 0.0
                    ? 0.0
                    : (transactionData['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
