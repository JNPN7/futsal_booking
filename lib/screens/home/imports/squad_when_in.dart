import 'package:flutter/material.dart';
import 'package:fusalbookings/services/sharedprefs.dart';
import 'package:fusalbookings/services/squaddatabase.dart';

class SquadWhenIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            color: Colors.white,
            onPressed: ()async{
              SquadService _squad = SquadService();
              SharedPrefs _prefs = SharedPrefs();
              String squadId = await _prefs.getTeamId();
              String uid = await _prefs.getuid();
              await _squad.getOutfromSquad(squadId, uid);
            },
            child: Text('getOut'),
          ),
        ],
      ),
    );
  }
}