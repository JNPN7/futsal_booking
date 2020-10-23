import 'package:flutter/material.dart';
import 'package:fusalbookings/models/user.dart';
import 'package:fusalbookings/screens/autheticate/authenticate.dart';
import 'package:fusalbookings/screens/bottom_navigation.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null){
      return Authenticate();
    }else{
      return BNB();
    }
  }
}