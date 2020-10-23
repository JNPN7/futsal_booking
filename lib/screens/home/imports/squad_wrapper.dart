import 'package:flutter/material.dart';
import 'package:fusalbookings/screens/home/imports/squad_when%20_not_in.dart';
import 'package:fusalbookings/screens/home/imports/squad_when_in.dart';
import 'package:provider/provider.dart';

class SquadWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final teamId = Provider.of<String>(context);
    if (teamId == null){
      return SquadWhenNotIn();
    }else{
      return SquadWhenIn();
    }
  }
}