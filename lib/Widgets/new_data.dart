import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Modal/DataModal.dart';

///AppBar and floating Action Button Widgets and New Transaction adding
class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);
  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  DateTime pickedDate = DateTime.now();
  final title = TextEditingController();
  final amount = TextEditingController();

  void _saveData() {
    final txtitle = (title.text).toString();
    final txamount = double.parse(amount.text);

    if (title == null && txamount <= 0 && pickedDate == null) {
      Text("Please enter details");
      return;
    }
    widget.addTx(DataModal(
        title: txtitle,
        amount: txamount,
        id: pickedDate.toString(),
        txdate: pickedDate));

    Navigator.of(context).pop();
  }

  void datepicker(BuildContext ctx) {
    showDatePicker(
            context: ctx,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now().add(Duration(days: 1)))
        .then((date) {
      if (date == null) return;
      setState(() {
        pickedDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: TextField(
            decoration: InputDecoration(
              labelText: "Title",
            ),
            controller: title,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: TextField(
            decoration: InputDecoration(
              labelText: "Amount",
            ),
            keyboardType: TextInputType.number,
            controller: amount,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text("Date:"),
            Text('${DateFormat.yMMMd().format(pickedDate)}',
                style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                )),
            OutlineButton(
              child: Text("Pick Date"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () => datepicker(context),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: RaisedButton(
            onPressed: _saveData,
            child: Text(
              "Save Data",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
