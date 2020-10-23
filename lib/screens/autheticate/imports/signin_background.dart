import 'package:flutter/material.dart';

// Login / Register decoration
Widget signInBackground(String firstText, String secondText){
  return Stack(
    children: <Widget>[
      Image(
        image: AssetImage('assets/images/signIn.png'),
        height: 250,
      ),
      Positioned(
        top: 50,
        left: 30,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              firstText, 
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            Text(
              secondText,
              style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),
            )
          ],
        ),
      )
    ],
  );
}