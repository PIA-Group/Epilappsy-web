part of 'survey_editor.dart';

class QuestionDivider extends StatefulWidget {
  const QuestionDivider(
      {@required this.index,
      @required this.newQuestion,
      this.visible = false,
      Key key})
      : assert(index != null),
        assert(newQuestion != null),
        super(key: key);

  final int index;
  final Function newQuestion;
  final bool visible;

  @override
  _QuestionDividerState createState() => _QuestionDividerState();
}

class _QuestionDividerState extends State<QuestionDivider> {
  bool showing = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          showing = true;
        });
      },
      onExit: (_) {
        setState(() {
          showing = false;
        });
      },
      child: SizedBox(
        height: 28,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Divider(),
            showing || widget.visible
                ? MaterialButton(
                    color: Theme.of(context).primaryColor,
                    shape: CircleBorder(),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () => widget.newQuestion(widget.index),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
