import 'package:flutter/material.dart';
import 'package:wonder_flutter/app/common/util/exports.dart';

class BlackOutlinedButton extends StatelessWidget {
  static final _textStyle = AppTextStyle.boldStyle.copyWith(
    color: Colors.black,
    fontSize: 15,
  );
  final void Function() onPressed;
  final String text;

  const BlackOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        side: const BorderSide(color: Colors.black),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(text, style: _textStyle)
    );
  }
}
