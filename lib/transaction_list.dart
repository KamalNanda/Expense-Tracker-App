import 'package:flutter/material.dart';
import './Cards/transaction.dart';
import './Utils/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionsList;
  final Function deleteTransactions;
  const TransactionList(this.transactionsList, this.deleteTransactions,
      {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transactionsList.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No Transactions added yet!',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 300,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemCount: transactionsList.length,
              itemBuilder: (ctx, index) {
                return TransactionCard(
                    transactionsList[index], deleteTransactions);
              },
            ),
    );
  }
}
