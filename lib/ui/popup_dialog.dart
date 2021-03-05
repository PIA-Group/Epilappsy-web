import 'package:epilappsy_web/ui/my_icon_button.dart';
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
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 1280,
              maxHeight: MediaQuery.of(context).size.height,
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
                    MyIconButton(
                      icon: Icon(
                        Icons.close,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Expanded(
                  child: this.content,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
