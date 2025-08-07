import 'package:flutter/material.dart';

class OperatorButton extends StatelessWidget {
  final String Operator;
  final Color? color;
  final double ? fontSize;
  final fontweight;
  final VoidCallback onclick;

  const OperatorButton({super.key, required this.Operator,required this.color,this.fontSize,this.fontweight, required this.onclick });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(0),
          fixedSize: Size(80, 80),
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 2,
        ),
        onPressed: onclick,
        child: Text(
          Operator,
          style: TextStyle(
            color: Colors.black,
            fontSize: fontSize,
            fontWeight: fontweight,
          ),
        ),
      ),
    );
  }
}
