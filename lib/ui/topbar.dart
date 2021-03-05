import 'package:epilappsy_web/ui/my_icon_button.dart';
import 'package:epilappsy_web/utils/database.dart';
import 'package:flutter/material.dart';

class TopBar extends StatefulWidget {
  const TopBar({Key key}) : super(key: key);

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "Surveys Editor",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        FutureBuilder(
            future: Database.getName(),
            builder: (context, snap) {
              if (snap.hasData)
                return Text(snap.data);
              else
                return Container();
            }),
        SizedBox(width: 16),
        MyIconButton(
          icon: Icon(
            Icons.exit_to_app,
            color: Colors.grey,
          ),
          onPressed: Database.signOut,
        ),
      ],
    );
  }
}
