import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField(
      {@required this.controller,
      this.focusNode,
      this.validator,
      this.hintText,
      this.limit,
      this.suffixIcon,
      this.obscure = false,
      this.onFieldSubmitted,
      Key key})
      : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final FocusNode focusNode;
  final Function validator;
  final Function onFieldSubmitted;
  final int limit;
  final Widget suffixIcon;
  final bool obscure;

  @override
  Widget build(BuildContext context) => TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 16,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.red[300],
            ),
            borderRadius: const BorderRadius.all(
              const Radius.circular(20.0),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.red[300],
            ),
            borderRadius: const BorderRadius.all(
              const Radius.circular(20.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.grey[300],
            ),
            borderRadius: const BorderRadius.all(
              const Radius.circular(20.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Theme.of(context).primaryColorLight,
            ),
            borderRadius: const BorderRadius.all(
              const Radius.circular(20.0),
            ),
          ),
          suffixIcon: suffixIcon,
        ),
        controller: controller,
        focusNode: focusNode,
        obscureText: obscure,
        style: TextStyle(fontSize: 18),
        validator: validator,
        onFieldSubmitted: this.onFieldSubmitted,
        inputFormatters: limit == null
            ? []
            : [
                new LengthLimitingTextInputFormatter(limit),
              ],
      );
}
