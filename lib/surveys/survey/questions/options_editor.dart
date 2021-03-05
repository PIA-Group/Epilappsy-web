import 'package:epilappsy_web/data/question.dart';
import 'package:epilappsy_web/ui/my_icon_button.dart';
import 'package:epilappsy_web/ui/my_text_form_field.dart';
import 'package:flutter/material.dart';

class OptionsEditor extends StatefulWidget {
  const OptionsEditor(this.question, {Key key}) : super(key: key);

  final OptionsQuestion question;

  @override
  _OptionsEditorState createState() => _OptionsEditorState();
}

class _OptionsEditorState extends State<OptionsEditor> {
  List<Map<String, dynamic>> _options = [];
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _options = List<Map<String, dynamic>>.from(
      widget.question.options.map((String option) {
        final TextEditingController controller =
            TextEditingController(text: option);
        final FocusNode focusNode = FocusNode()
          ..addListener(
            () => _updateText(controller, option),
          );
        return {
          "controller": controller,
          "focus": focusNode,
        };
      }),
    );
  }

  void _updateText(TextEditingController controller, String defaultText) {
    final String text = controller.text.trim();
    if (text.isEmpty) {
      controller.text = defaultText;
    }
  }

  @override
  void dispose() {
    widget.question.options = List<String>.from(
      _options.map(
        (Map<String, dynamic> options) {
          final TextEditingController controller = options["controller"];
          return controller.text.trim();
        },
      ),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Form newOption = Form(
      key: key,
      child: MyTextFormField(
        hintText: "Write an option",
        validator: (String text) {
          if (text.trim().isEmpty) return "Option can't be empty";
          return null;
        },
        onFieldSubmitted: (String text) {
          if (key.currentState.validate()) {
            controller.clear();
            _newOption(text.trim());
          }
        },
        controller: controller,
        focusNode: focusNode,
      ),
    );
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8, top: 16, bottom: 8),
            child: Text(
              "Options:",
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List<Widget>.from(
                _options.map(
                  (Map<String, dynamic> option) {
                    final TextEditingController controller =
                        option["controller"];
                    final FocusNode focusNode = option["focus"];
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: MyTextFormField(
                                  controller: controller,
                                  focusNode: focusNode,
                                  hintText: "Write an option"),
                            ),
                            SizedBox(width: 8),
                            MyIconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.red[300],
                                size: 20,
                              ),
                              onPressed: () => _deleteOption(option),
                              size: 32,
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                      ],
                    );
                  },
                ),
              )..add(newOption),
            ),
          ),
        ],
      ),
    );
  }

  void _deleteOption(Map<String, dynamic> option) {
    setState(() {
      _options.remove(option);
    });
  }

  void _newOption(String option) {
    setState(() {
      _options.add(
        {
          "controller": TextEditingController(text: option),
          "focus": FocusNode(),
        },
      );
    });
    focusNode.requestFocus();
  }
}
