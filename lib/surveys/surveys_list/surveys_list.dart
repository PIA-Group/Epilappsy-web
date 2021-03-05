import 'package:epilappsy_web/data/survey.dart';
import 'package:epilappsy_web/data/survey_questions.dart';
import 'package:epilappsy_web/surveys/survey/survey_title_editor.dart';
import 'package:epilappsy_web/ui/my_icon_button.dart';
import 'package:epilappsy_web/ui/popup_dialog.dart';
import 'package:epilappsy_web/surveys/survey/survey_editor.dart';
import 'package:epilappsy_web/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

part 'survey_list_item.dart';

class SurveysList extends StatefulWidget {
  const SurveysList({Key key}) : super(key: key);

  @override
  _SurveysListState createState() => _SurveysListState();

  static void _showSurvey(BuildContext context, Survey survey) async {
    final SurveyQuestions surveyQuestions = SurveyQuestions(
        id: survey.id,
        questions: await Database.getSurveyQuestions(survey.id),
        parent: survey,
        order: survey.order);
    showDialog(
      context: context,
      builder: (context) => PopupDialog(
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 64),
          child: SurveyTitleEditor(survey),
        ),
        content: SurveyEditor(surveyQuestions),
      ),
    );
  }
}

class _SurveysListState extends State<SurveysList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          child: Row(
            children: [
              Text(
                "My Surveys:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              MaterialButton(
                shape: CircleBorder(),
                child: Icon(Icons.add, color: Colors.white),
                color: Theme.of(context).primaryColor,
                onPressed: _newSurvey,
              )
            ],
          ),
        ),
        Expanded(
          child: _buildList(),
        ),
      ],
    );
  }

  Widget _buildList() => StreamBuilder(
        stream: Database.mySurveys(),
        builder: (context, AsyncSnapshot<List<Survey>> snap) =>
            snap.connectionState != ConnectionState.active
                ? Container()
                : ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: snap.data.length,
                    itemBuilder: (context, index) =>
                        SurveyListItem(snap.data[index]),
                  ),
      );

  Future<void> _newSurvey() async =>
      SurveysList._showSurvey(context, await Database.newSurvey());
}
