import 'package:expensetracker/Utils/transaction.dart';
import 'package:flutter/material.dart';
import '../Utils/transaction.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;
  Chart(this.transactions);

  List<Map<String, Object>> get groupTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(
          days: index,
        ),
      );
      int totalSum = 0;
      for (int i = 0; i < transactions.length; i++) {
        if (transactions[i].date.day == weekDay.day &&
            transactions[i].date.month == weekDay.month &&
            transactions[i].date.year == weekDay.year) {
          totalSum = totalSum + transactions[i].amount;
        }
      }
      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    });
  }

  double get maxSpending {
    return groupTransactionValues.fold(0.0, (sum, element) {
      return sum + (element['amount'] as int);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransactionValues.map((txn) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                (txn['day'] as String),
                (txn['amount'] as int),
                maxSpending == 0.0 ? 0.0 : (txn['amount'] as int) / maxSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
// Text('${txn['day']}: ${txn['amount'].toString()}');