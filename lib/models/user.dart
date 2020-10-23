class User{
  final String uid;
  final bool isAnon;
  User({this.uid, this.isAnon});
}

class UserData{
  final String uid;
  String name;
  String phoneNo;
  String locationName;
  String teamId;
  UserData({this.uid, this.name, this.phoneNo, this.locationName, this.teamId});
}