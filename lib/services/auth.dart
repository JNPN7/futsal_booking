import 'package:firebase_auth/firebase_auth.dart';
import 'package:fusalbookings/models/user.dart';
import 'package:fusalbookings/services/sharedprefs.dart';
import 'package:fusalbookings/services/userdatabase.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // user based in firebase user
  User _userfromFirebaseUser(FirebaseUser user){
    // chech wether sign in is anonymous or not
    bool isAnon = true;
    if (user != null){
      if (user.email != null){
        isAnon  = false;
      }
    }
    return user != null ? User(uid: user.uid, isAnon: isAnon) : null;
  }

  Stream<User> get user{
    return _auth.onAuthStateChanged
      .map((FirebaseUser user) => _userfromFirebaseUser(user));
  }

  // sign anonymously
  Future signInAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      // set sharedPreference
      SharedPrefs _prefs = SharedPrefs();
      await _prefs.setisAnon(true);
      return _userfromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password, String name, String phoneNo, String location) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      // set sharedPreference
      SharedPrefs _prefs = SharedPrefs();
      await _prefs.setisAnon(false);
      await _prefs.setUserData(user.uid, name, location, phoneNo);
      //creates new documents for new user with user id
      await UserService(uid: user.uid).setUserData(name, phoneNo, location);
      return _userfromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // signin with email and password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      User userD = _userfromFirebaseUser(user);
      UserData userData = await UserService(uid: userD.uid).getUserData();
      // set sharedPreference
      SharedPrefs _prefs = SharedPrefs();
      await _prefs.setisAnon(false);
      await _prefs.setUserData(user.uid, userData.name, userData.locationName, userData.phoneNo);
      return userD;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async{
    try{
      // remove sharedPreference
      SharedPrefs _prefs = SharedPrefs();
      await _prefs.removeData();
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}