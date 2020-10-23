import 'package:flutter/material.dart';
import 'package:fusalbookings/imports/constants.dart';
import 'package:fusalbookings/imports/loading.dart';
import 'package:fusalbookings/models/user.dart';
import 'package:fusalbookings/screens/autheticate/imports/signin_background.dart';
import 'package:fusalbookings/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey =  GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  String email;
  String password;
  String error = '';
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
            signInBackground('Welcome Back,', 'Log In!'), //decoration text for sign in
            SizedBox(height: 50,),
            signInForm(widget.toggleView),
          ],
        ),
      ),
    );
  }
 
  //sign in form
  Widget signInForm(Function toogleView){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 300, left: 30, right: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: inputDecoration.copyWith(labelText: 'Email'),
                validator: (val) => val.isEmpty ? 'Please enter your email' : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                decoration: inputDecoration.copyWith(labelText: 'Password'),
                validator: (val) => val.isEmpty ? 'Please enter your password' : null,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height: 30),
              SizedBox(
                width: 200,
                child: RaisedButton(
                  color: Color(0XFF00ff00),
                  onPressed: () async{
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if (result == null){
                        print("Couldn't Sign in");
                        setState(() {
                          error = 'Please enter valid credentials';
                          loading = false;
                        });
                      }
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('Log In'),
                ),
              ),
              SizedBox(height: 5,),
              Text(error, style: TextStyle(color: Colors.red),),
              SizedBox(height: 75,),
              Text("Don't have an Account?"),
              InkWell(
                onTap: (){
                  toogleView();
                },
                child: Text(
                  'Create Account', 
                  style:TextStyle(color: Colors.lightGreen, decoration: TextDecoration.underline,)
                ),
              ),
              SizedBox(height: 5,),
              Text("Or"),
              SizedBox(height: 5,),
              GestureDetector(
                onTap: () async{
                  setState(() => loading = true);
                  User result = await _auth.signInAnon();
                  if (result == null){
                    print('couldnt signin');
                    setState(() {
                      error = 'Error while sign in anonymous';
                      loading = false;
                    });
                  }else{
                    // print(result);
                  }
                },
                child: Text(
                  'Browse anonymously', 
                  style:TextStyle(color: Colors.lightGreen, decoration: TextDecoration.underline,)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}