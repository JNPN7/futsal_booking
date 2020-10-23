import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs{
  String _uidKey = 'uid';
  String _nameKey = 'name';
  String _locationKey = 'location';
  String _phoneNoKey = 'phoneNo';
  String _isAnonKey = 'isAnon';
  String _teamidKey = 'teamId';

  Future<void> setisAnon(bool isAnon) async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool(this._isAnonKey, isAnon);
  }

  Future<void> setUserData(String uid, String name, String location, String phoneNo) async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(this._uidKey, uid);
    await _prefs.setString(this._nameKey, name);
    await _prefs.setString(this._locationKey, location);
    await _prefs.setString(this._phoneNoKey, phoneNo);
  }

  Future<void> removeData() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.remove(this._isAnonKey);
    await _prefs.remove(this._uidKey);
    await _prefs.remove(this._nameKey);
    await _prefs.remove(this._locationKey);
    await _prefs.remove(this._phoneNoKey);
  }

  Future<String> getLocation() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(this._locationKey) ?? 'Bhaktapur';
  }

  Future<bool> getisAnon() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool(this._isAnonKey) ?? true;
  }

  Future<String> getuid() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(this._uidKey) ?? null;
  }

  Future<String> getname() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(this._nameKey) ?? null;
  }

  Future<void> setTeamId(String teamId) async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString(this._teamidKey, teamId);
    
  }

  Future<String> getTeamId() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(this._teamidKey) ?? null;
  }
}
// static String uid;
// static String name;
// static String location;
// static String phoneNo;
// static bool isAnon;