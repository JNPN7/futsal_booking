import 'package:flutter/material.dart';
import 'package:fusalbookings/imports/constants.dart';
import 'package:fusalbookings/imports/loading.dart';
import 'package:fusalbookings/screens/autheticate/imports/signin_background.dart';
import 'package:fusalbookings/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey =  GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  String error = '';
  String location = '';
  String email;
  String password;
  String name;
  String phoneNo;
  bool loading = false;


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          children: <Widget>[
            signInBackground('Hello,', 'Sign Up!'), //decoration text for sign in
            SizedBox(height: 50,),
            signInForm(widget.toggleView),
          ],
        ),
      ),
    );
  }
 
  //sign in form
  Widget signInForm(Function toggleView){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 250, left: 30, right: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: name,
                textCapitalization: TextCapitalization.sentences,
                decoration: inputDecoration.copyWith(labelText: 'Name'),
                validator: (val) => val.isEmpty ? 'Please enter Name' : null,
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
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: inputDecoration.copyWith(labelText: 'Phone no'),
                validator: (val) { 
                  final isDigitsOnly = int.tryParse(val);
                  if(isDigitsOnly != null && val.length == 10){
                    return null;
                  }else{
                    return 'Please enter Valid Phone no';
                  }
                },
                onChanged: (val) {
                  setState(() {
                    phoneNo = val;
                  });
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: inputDecoration.copyWith(labelText: 'Email'),
                validator: (val) => val.isEmpty ? 'Please enter email' : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                decoration: inputDecoration.copyWith(labelText: 'Password'),
                validator: (val) => (val.length < 6) ? 'Password is weak. Must be more than 6 charecter' : null,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 200,
                child: RaisedButton(
                  color: Color(0XFF00ff00),
                  onPressed: () async{
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true);
                      dynamic result =  await _auth.registerWithEmailAndPassword(email, password, name, phoneNo, location);
                      if(result == null){
                        setState(() {
                          error = 'Please enter valid email';
                          loading = false;
                        });
                      }
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('Sign Up'),
                ),
              ),
              SizedBox(height: 5,),
              Text(error, style: TextStyle(color: Colors.red),),
              SizedBox(height: 10,),
              Text("Already have an Account?"),
              GestureDetector(
                onTap: (){
                  toggleView();
                },
                child: Text('Log In', 
                  style:TextStyle(color: Colors.lightGreen, decoration: TextDecoration.underline,)
                ),
              ),
              SizedBox(height: 10,)
            ],
          ),
        ),
      ),
    );
  }
}