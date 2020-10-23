import 'package:flutter/material.dart';
import 'package:fusalbookings/services/auth.dart';
// import 'package:fusalbookings/screens/home.dart';
import 'package:fusalbookings/wrapper.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
