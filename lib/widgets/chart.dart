import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './chart_bar.dart';

import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get transactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (DateFormat.yMMMd().format(recentTransactions[i].date) ==
            DateFormat.yMMMd().format(weekDay)) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double dayPercentage(amount) {
    final totalSpending =
        transactionValues.fold(0.0, (sum, item) => sum + item['amount']);

    return totalSpending == 0.0 ? 0.0 : amount / totalSpending;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...transactionValues.map((tr) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                      tr['day'], tr['amount'], dayPercentage(tr['amount'])),
                );
              }).toList()
            ],
          ),
        ));
  }
}
