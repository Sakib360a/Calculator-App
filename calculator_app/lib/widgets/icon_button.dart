import 'package:flutter/material.dart';


class Icon_Button extends StatelessWidget {
  final Color? color;
  final VoidCallback onclick;
  const Icon_Button({
    super.key,
    this.color, required this.onclick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.only(right: 2),
          fixedSize: Size(80, 80),
          backgroundColor: this.color,
          elevation: 2,
        ),
        onPressed: onclick,
        child: Icon(
          Icons.backspace_rounded, size: 30,color: Color(0xFFFF0000),)
      ),
    );
  }
}