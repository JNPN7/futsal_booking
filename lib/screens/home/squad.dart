import 'package:flutter/material.dart';
import 'package:fusalbookings/imports/loading.dart';
import 'package:fusalbookings/screens/home/imports/squad_wrapper.dart';
import 'package:fusalbookings/services/sharedprefs.dart';
import 'package:fusalbookings/services/userdatabase.dart';
import 'package:provider/provider.dart';
// import 'imports/squad_when _not_in.dart';

class SquadPage extends StatefulWidget {

  
  @override
  _SquadPageState createState() => _SquadPageState();
}

class _SquadPageState extends State<SquadPage> with AutomaticKeepAliveClientMixin{

  // get userId
  Future<String> getUserTeamId() async{
    SharedPrefs _prefs = SharedPrefs();
    return await _prefs.getuid();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: getUserTeamId(),
      builder: (context, snapshot) {
        // StreamProvider.value(
        // value: UserService(uid: ).userTeamId;
        if (snapshot.hasData){
          String uid = snapshot.data;
          return StreamProvider.value(
            value: UserService(uid: uid).userTeamId,
            child: SquadWrapper(),
          );
        }else{
          return Loading();
        }
      },
    ); 
  }

  @override
  bool get wantKeepAlive => true;
}