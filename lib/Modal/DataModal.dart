import 'package:flutter/material.dart';

class DataModal {
  @required
  String id;
  @required
  String title;
  @required
  double amount;
  @required
  DateTime txdate;
  DataModal({this.id, this.title, this.amount, this.txdate});
}
