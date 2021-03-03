import 'package:epilappsy_web/data/survey.dart';
import 'package:epilappsy_web/popup_dialog.dart';
import 'package:epilappsy_web/surveys/survey_editor.dart';
import 'package:epilappsy_web/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SurveysList extends StatefulWidget {
  const SurveysList({Key key}) : super(key: key);

  @override
  _SurveysListState createState() => _SurveysListState();
}

class _SurveysListState extends State<SurveysList> {
  @override
  Widget build(BuildContext context) {
    final Color _itemBackgroundColor =
        Theme.of(context).primaryColorLight.withOpacity(0.3);
    return StreamBuilder(
      stream: Database.mySurveys(),
      builder: (context, AsyncSnapshot<List<Survey>> snap) => snap
                  .connectionState !=
              ConnectionState.active
          ? Container()
          : ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: snap.data.length,
              itemBuilder: (context, index) {
                final Survey survey = snap.data[index];
                Color backgroundColor = Colors.white;
                return StatefulBuilder(
                  builder: (BuildContext buildContext, _setState) =>
                      MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (_) {
                      _setState(() => backgroundColor = _itemBackgroundColor);
                    },
                    onExit: (_) {
                      _setState(() => backgroundColor = Colors.transparent);
                    },
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: backgroundColor),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => PopupDialog(
                            title: Text(
                              survey.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            content: SurveyEditor(survey),
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(survey.name),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
