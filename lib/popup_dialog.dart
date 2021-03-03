import 'package:flutter/material.dart';

class PopupDialog extends StatelessWidget {
  const PopupDialog({this.title, @required this.content, Key key})
      : super(key: key);
  final Widget title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(36),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 1280,
          ),
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 40),
                  Expanded(child: Center(child: this.title) ?? Container()),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      borderRadius: BorderRadius.circular(40),
                      child: Icon(
                        Icons.close,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: this.content,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
