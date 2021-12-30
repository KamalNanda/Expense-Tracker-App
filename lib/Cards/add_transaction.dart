import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  final Function addTransaction;
  AddTransaction(this.addTransaction, {Key? key}) : super(key: key);
  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now().add(Duration(days: 2));
  void _submitForm() {
    final title = _titleController.text;
    final amount = int.parse(_amountController.text);
    if (title.isEmpty ||
        amount <= 0 ||
        _selectedDate == DateTime.now().add(Duration(days: 2))) {
      return;
    }
    widget.addTransaction(title, amount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) return;
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Enter Title'),
                controller: _titleController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Enter Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitForm,
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    // Text(_selectedDate == null ? 'No Date Chosen' : DateFormat.yMd(_selectedDate)),
                    _selectedDate.day ==
                            DateTime.now().add(Duration(days: 2)).day
                        ? Text('No Date Chosen')
                        : Text(
                            'Picked Date : ${DateFormat.yMd().format(_selectedDate)}'),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: _showDatePicker,
                    )
                  ],
                ),
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                color: Theme.of(context).primaryColor,
                child: const Text('ADD TRANSACTION',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                onPressed: _submitForm,
              )
            ],
          ),
        ));
    ;
  }
}
