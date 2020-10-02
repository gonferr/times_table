import 'package:flutter/material.dart';

class CardNumber extends StatelessWidget {
  final Color color;
  final int value;
  final TextStyle style;

  const CardNumber(key, {this.color, this.value, this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          value.toString(),
          style: style,
        ),
      ),
    );
  }
}
