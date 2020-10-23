import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fusalbookings/models/user.dart';

class UserService{
  final uid;
  UserService({this.uid});
  String _nameKey =  'name';
  String _locationNameKey = 'locationName"';
  String _contactKey = 'contacts';
  String _teamIdKey = 'teamId';

  //collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

  // get userData object form snapshot
  UserData _userFromSnapshot(DocumentSnapshot snapshot){
    try{
      return UserData(
        uid: uid,
        name: snapshot.data[_nameKey] ?? '',
        locationName: snapshot.data[_locationNameKey] ?? '',
        phoneNo: snapshot.data[_contactKey] ?? '',
        teamId: snapshot.data[_teamIdKey]
      );
    }catch(e){
      print(e.toString());
      return null;
    }  
  } 

  Stream<UserData> get userData{
    return userCollection.document(uid).snapshots().map(_userFromSnapshot);
  }

  String _userTeamId(DocumentSnapshot snapshot){
    try{
      return snapshot.data[_teamIdKey];
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Stream<String> get userTeamId{
    return userCollection.document(uid).snapshots().map(_userTeamId);
  }

  // get userData
  Future<UserData> getUserData(){
    try{
      return userCollection.document(uid).get().then((doc) {
        return _userFromSnapshot(doc);
      }); 
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // set UserData
  Future setUserData(String name, String phoneNo, String location) async{
    try{
      return await userCollection.document(uid).setData({
        _nameKey: name,
        _contactKey: phoneNo,
        _locationNameKey: location,
        _teamIdKey: null
      });
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // update teamId
  Future updateTeamId(String teamId) async{
    return await userCollection.document(uid).updateData({
      _teamIdKey: teamId
    }).catchError((e){
      print(e.toString());
      return null;
    });
  }
}