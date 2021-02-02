import 'package:flutter/material.dart';

class Btn extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback onPressed;

  Btn({@required this.onPressed,  @required this.text, @required this.color});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: this.onPressed,
      child: Text(
        this.text,
        style: TextStyle(color: Colors.white),
      ),
      color: this.color,
    );
  }
}
