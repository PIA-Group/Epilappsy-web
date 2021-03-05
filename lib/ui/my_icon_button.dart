import 'package:flutter/material.dart';
import 'dart:math';

class MyIconButton extends StatelessWidget {
  const MyIconButton(
      {@required this.icon, @required this.onPressed, this.size = 40, Key key})
      : assert(icon != null),
        assert(onPressed != null),
        assert(size != null && size is double),
        super(key: key);
  final Widget icon;
  final Function onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(size),
        child: icon,
      ),
    );
  }
}
