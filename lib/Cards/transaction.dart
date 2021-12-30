import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class TransactionCard extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var transaction;
  final Function deleteTransactions;
  TransactionCard(this.transaction, this.deleteTransactions, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text('Rs ${transaction.amount}'),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        subtitle: Text(
          DateFormat.yMMMMd().format(transaction.date),
          style:
              TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600),
        ),
        trailing: IconButton(
            onPressed: () {
              deleteTransactions(transaction.id);
            },
            icon: Icon(Icons.delete),
            color: Colors.red),
      ),
    );
  }
}
