part of 'surveys_list.dart';

class SurveyListItem extends StatefulWidget {
  const SurveyListItem(this.survey, {this.defaultColor, Key key})
      : assert(survey != null),
        super(key: key);
  final Survey survey;
  final Color defaultColor;

  @override
  _SurveyListItemState createState() => _SurveyListItemState();
}

class _SurveyListItemState extends State<SurveyListItem> {
  Color backgroundColor = Colors.white;
  bool hover = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color defaultColor = widget.defaultColor ??
        Theme.of(context).primaryColorLight.withOpacity(0.3);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() => hover = true);
      },
      onExit: (_) {
        setState(() => hover = false);
      },
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: hover ? defaultColor : backgroundColor),
        onPressed: () {
          SurveysList._showSurvey(context, widget.survey);
        },
        child: ListTile(
          title: Text(widget.survey.title),
          subtitle: Text("Created at ${widget.survey.timestamp}"),
          trailing: hover
              ? MyIconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    Database.deleteSurvey(widget.survey.id);
                  },
                )
              : null,
        ),
      ),
    );
  }
}
