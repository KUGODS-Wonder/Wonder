import 'package:flutter/material.dart';

class ColoredButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? color;
  final Size? fixedSize;
  final Widget child;

  const ColoredButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.color,
    this.fixedSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: color ?? Theme.of(context).primaryColor,
          fixedSize: fixedSize,
          side: BorderSide(color: color ?? Theme.of(context).primaryColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: child
    );
  }
}
