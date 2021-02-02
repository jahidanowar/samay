import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String text;
  Label({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 20.0, 5.0, 10.0),
      child: Text(
        this.text,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
