part of 'patients.dart';

class PatientItem extends StatefulWidget {
  const PatientItem(this.patient, this.surveys, {this.defaultColor, Key key})
      : assert(patient != null),
        super(key: key);
  final Patient patient;
  final List<Survey> surveys;
  final Color defaultColor;

  @override
  _PatientItemState createState() => _PatientItemState();
}

class _PatientItemState extends State<PatientItem> {
  Color backgroundColor = Colors.white;
  bool hover = false;

  @override
  void initState() {
    super.initState();
    if (!widget.surveys
        .any((Survey survey) => survey.id == widget.patient.surveyID)) {
      widget.patient.surveyID = null;
      Database.updateDefaultSurvey(widget.patient.id, null);
    }
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
      child: Container(
        color: hover ? defaultColor : backgroundColor,
        child: ListTile(
          leading: Icon(Icons.person),
          title: Text(widget.patient.name),
          trailing: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: widget.surveys.isEmpty ? Container() : _buildDropDown(),
          ),
        ),
      ),
    );
  }

  Widget _buildDropDown() => LayoutBuilder(
        builder: (context, constraints) => ConstrainedBox(
          constraints: constraints,
          child: DropdownButton<String>(
            value: widget.patient.surveyID,
            onChanged: (String newSurveyID) {
              if (newSurveyID != widget.patient.surveyID) {
                setState(() {
                  widget.patient.surveyID = newSurveyID;
                });
                Database.updateDefaultSurvey(
                    widget.patient.id, widget.patient.surveyID);
              }
            },
            items: widget.surveys
                .map<DropdownMenuItem<String>>(
                    (Survey survey) => DropdownMenuItem<String>(
                          value: survey.id,
                          child: SizedBox(
                            width: constraints.maxWidth - 24,
                            child: Text(
                              survey.title,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ))
                .toList(),
          ),
        ),
      );
}
