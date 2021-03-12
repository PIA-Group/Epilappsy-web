import 'package:epilappsy_web/data/question.dart';
import 'package:epilappsy_web/ui/my_icon_button.dart';
import 'package:epilappsy_web/ui/my_text_form_field.dart';
import 'package:flutter/material.dart';

class TagEditor extends StatefulWidget {
  const TagEditor(this.question, {Key key}) : super(key: key);
  final Question question;

  @override
  _TagEditorState createState() => _TagEditorState();
}

class _TagEditorState extends State<TagEditor> {
  bool tagShowing;
  TextEditingController _controller;
  FocusNode _focusNode = FocusNode();
  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    tagShowing = widget.question.tag != null;
    _controller = TextEditingController(text: widget.question.tag ?? "");

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) _updateText();
    });
  }

  void _updateText() {
    if (_formKey.currentState.validate()) {
      widget.question.tag = _controller.text.trim();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(
        milliseconds: 150,
      ),
      constraints: BoxConstraints(maxWidth: tagShowing ? 200 : 40),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyIconButton(
            icon: Icon(Icons.tag),
            onPressed: () {
              setState(() {
                tagShowing = !tagShowing;
              });
            },
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) => constraints.maxWidth == 0
                  ? Container()
                  : Form(
                      key: _formKey,
                      child: MyTextFormField(
                          controller: _controller,
                          focusNode: _focusNode,
                          validator: _validate,
                          hintText: "someTag"),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  String _validate(String text) {
    final String trimmed = text.trim();
    if (trimmed.isNotEmpty) {
      final letters = RegExp(r'^[a-zA-Z]+$');
      if (!letters.hasMatch(trimmed)) return "Only letters allowed";
      _controller.text = _controller.text.toLowerCase();
    }
    return null;
  }
}
