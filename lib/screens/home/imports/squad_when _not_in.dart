import 'package:flutter/material.dart';
import 'package:fusalbookings/screens/nav_screens/create_squad.dart';

class SquadWhenNotIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/squad1.png'),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                onPressed: (){},
                color: Colors.lightGreen[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Text('Join Squad'),
              ),
              RaisedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateSquad()),
                  );
                },
                color: Colors.lightGreen[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Text('Create Squad'),
              )
            ],
          )
        ],
      )
    );
  }
}