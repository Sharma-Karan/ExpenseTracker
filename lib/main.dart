import 'package:flutter/material.dart';

import './Widgets/new_data.dart';
import './Modal/DataModal.dart';
import './Widgets/map_transactions.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expense Tracker",
      theme: ThemeData(primarySwatch: Colors.purple),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DataModal> _transactions = new List<DataModal>();
  void _newTransaction() {
    showModalBottomSheet(
        context: context,
        builder: (bctx) {
          return NewTransaction(_addNewTransaction);
        });
  }

  List<DataModal> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.txdate.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(var tx) {
    setState(() {
      _transactions.add(tx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracker"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _newTransaction(),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Card(elevation: 6, child: (Chart(_recentTransactions))),
          Card(
            child: _transactions.isEmpty
                ? Container(
                    child: Column(
                    children: <Widget>[
                      Center(
                        child: Text(
                          "No Recent transactions",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        height: 200,
                        child: Image.asset(
                          "assets/img/waiting.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                            "Press + button in lower right corner to add Transaction"),
                      ),
                    ],
                  ))
                : SingleChildScrollView(
                    child: Column(
                        children: _transactions.map((tx) {
                      return MapTransactions(tx, _deleteTransaction);
                    }).toList()),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _newTransaction(),
      ),
    );
  }
}
