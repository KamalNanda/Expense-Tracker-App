import 'package:flutter/material.dart';
import './Cards/add_transaction.dart';
import './Utils/transaction.dart';
import './transaction_list.dart';
import './Cards/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.purple[300],
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                  subtitle1: const TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactionsList = [
    // Transaction(
    //     id: '1',
    //     title: 'Metro Card Recharge',
    //     amount: 100,
    //     date: DateTime.now()),
    // Transaction(
    //   id: '2',
    //   title: 'Breakfast',
    //   amount: 105,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: '3',
    //   title: 'Movie Ticket',
    //   amount: 502,
    //   date: DateTime.now(),
    // )
  ];
  List<Transaction> get _recentTransactions {
    return transactionsList.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void addTransaction(String title, int amount, DateTime _selectedDate) {
    final newTransaction = Transaction(
        id: '${transactionsList.length + 1}',
        title: title,
        amount: amount,
        date: _selectedDate);
    setState(() {
      transactionsList.add(newTransaction);
    });
  }

  void deleteTransactions(String id) {
    setState(() {
      transactionsList.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  void _showModal(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: AddTransaction(addTransaction),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expense Tracker',
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => _showModal(context),
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Card(
            //     color: Theme.of(context).primaryColor,
            //     elevation: 5,
            //     child: Container(
            //       padding: const EdgeInsets.all(15),
            //       child: const Text(
            //         'CHART',
            //         style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 16,
            //             fontWeight: FontWeight.bold),
            //       ),
            //       width: double.infinity,
            //     )),
            Chart(_recentTransactions),
            TransactionList(transactionsList, deleteTransactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showModal(context),
      ),
    );
  }
}
