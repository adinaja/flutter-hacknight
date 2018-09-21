import 'package:flutter/material.dart';

class Task {
  int id;
  String text;
  bool done;

  Task({
    @required this.id,
    @required this.text,
    @required this.done
  });
}
