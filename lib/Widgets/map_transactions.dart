import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MapTransactions extends StatelessWidget {
  var tx;
  final Function deleteTx;
  MapTransactions(this.tx, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      elevation: 6,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Flexible(
            fit: FlexFit.tight,
            child: Text(tx.amount.toString()),
          ),
        ),
        title: Text(
          '${tx.title}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '${DateFormat.yMMMd().format(tx.txdate)}',
          style: TextStyle(color: Colors.grey),
        ),
        trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () => deleteTx(tx.id)),
      ),
    );
  }
}
