import 'package:flutter/material.dart';
class NumberButton extends StatelessWidget {
  final String Number;
  final Color? color;
  final fontweight;
  final double? fontSize;
  final VoidCallback onclick;
  const NumberButton({
    super.key,
    required this.Number,
    this.color,
    this.fontweight,
    this.fontSize,
    required this.onclick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(2),
          fixedSize: Size(80, 80),
          backgroundColor: this.color,
          elevation: 2,
        ),
        onPressed: onclick,
        child: Text(
          this.Number,
          style: TextStyle(
            color: Colors.black,
            fontSize: this.fontSize,
            fontWeight: this.fontweight,
          ),
        ),
      ),
    );
  }
}