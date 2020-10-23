import 'package:flutter/material.dart';
import 'package:fusalbookings/services/auth.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = AuthService();
    return Scaffold(
      appBar: AppBar(
        actions: [
          RaisedButton(
            onPressed: () => _auth.signOut(),
            child: Text('logOut'),
          )
        ],
      ),
      
    );
  }
}