import 'package:flutter/material.dart';
import 'package:fusalbookings/imports/constants.dart';
import 'package:fusalbookings/imports/loading.dart';
import 'package:fusalbookings/services/sharedprefs.dart';
import 'package:fusalbookings/services/squaddatabase.dart';

class CreateSquad extends StatefulWidget {

  @override
  _CreateSquadState createState() => _CreateSquadState();
}

class _CreateSquadState extends State<CreateSquad> {
  final _formKey =  GlobalKey<FormState>();

  String error = '';
  String location = '';
  String name;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Create your squad'),
      ),
      backgroundColor: Colors.lightGreen,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Image.asset('assets/images/squad_create.png'),
              SizedBox(height: 20,),
              createForm(),
            ],
          ),
        ),
      )
    );
  }

  Widget createForm(){
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              initialValue: name,
              textCapitalization: TextCapitalization.sentences,
              decoration: inputDecoration.copyWith(labelText: 'Squad Name'),
              validator: (val) => val.isEmpty ? 'Please enter your Squad Name' : null,
              onChanged: (val) {
                setState(() {
                  name = val;
                });
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              initialValue: location,
              textCapitalization: TextCapitalization.sentences,
              decoration: inputDecoration.copyWith(labelText: 'District'),
              validator: (val) => val.isEmpty ? 'Please enter District' : null,
              onChanged: (val) {
                setState(() {
                  location = val;
                });
              },
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 200,
              child: RaisedButton(
                color: Color(0XFF00ff00),
                onPressed: () async{
                  SharedPrefs _prefs = SharedPrefs();
                  bool isAnon = await _prefs.getisAnon();
                  if(!isAnon){
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true);
                      SquadService _squad = SquadService();
                      String _uid = await _prefs.getuid();
                      dynamic result =  await _squad.createSquad(name, location, _uid);
                      if(result == 'squadExist'){
                        setState(() {
                          error = 'Squad already Exist';
                          loading = false;
                        });
                      }else if(result != null){
                        setState(() {
                          loading = false;
                        });
                      }else{
                        Navigator.pop(
                          context,
                        );
                      }
                    }
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('Create Squad'),
              ),
            ),
            SizedBox(height: 5,),
            Text(error, style: TextStyle(color: Colors.red),),
          ],
        ),
      ),
    );
  }
}