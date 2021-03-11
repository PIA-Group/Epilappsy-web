part of 'survey_editor.dart';

final Map<String, QuestionType> questionTypes = {
  "text": QuestionType(
    label: "Text",
    type: "text",
    icon: Icon(Icons.text_fields),
  ),
  "number": QuestionType(
    label: "Number",
    type: "number",
    icon: Icon(Icons.filter_1),
  ),
  "checkbox": QuestionType(
    label: "Checkbox",
    type: "checkbox",
    icon: Icon(Icons.check_box),
  ),
  "radio": QuestionType(
    label: "Radio",
    type: "radio",
    icon: Icon(Icons.radio_button_on),
  ),
  "toggle": QuestionType(
    label: "Toggle",
    type: "toggle",
    icon: Transform.rotate(
      angle: math.pi,
      child: Icon(Icons.alt_route),
    ),
  ),
};

class QuestionTypeSelector extends StatelessWidget {
  const QuestionTypeSelector(this.newQuestion, {Key key})
      : assert(newQuestion != null),
        super(key: key);

  final Function newQuestion;

  @override
  Widget build(BuildContext context) {
    final Color activeColor =
        Theme.of(context).primaryColorLight.withOpacity(0.5);
    final Color inactiveColor = Colors.grey[200];
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List<Widget>.from(
            questionTypes.values.map(
              (QuestionType questionType) {
                Color backgroundColor = inactiveColor;
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
                  child: StatefulBuilder(
                    builder: (context, _setState) => MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (_) {
                        _setState(() => backgroundColor = activeColor);
                      },
                      onExit: (_) {
                        _setState(() => backgroundColor = inactiveColor);
                      },
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: backgroundColor),
                        onPressed: () {
                          newQuestion(questionType.type);
                        },
                        child: SingleChildScrollView(
                          physics: NeverScrollableScrollPhysics(),
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconTheme(
                                  data: IconThemeData(
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  child: questionType.icon,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  questionType.label,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class QuestionType {
  final String type;
  final String label;
  final Widget icon;

  QuestionType(
      {@required this.type, @required this.label, @required this.icon});
}
