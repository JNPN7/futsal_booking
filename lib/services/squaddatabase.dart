import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fusalbookings/models/squadModel.dart';
import 'package:fusalbookings/services/sharedprefs.dart';
import 'package:fusalbookings/services/userdatabase.dart';

class SquadService{
  String _squadNameKey = 'squadName';
  String _locationKey = 'location';
  String _adminKey = 'admin';
  String _membersKey = 'members';

  // collection reference         
  final CollectionReference squadCollection = Firestore.instance.collection('squad');

  // Create new squad
  Future createSquad(String name, String location, String uid) async{
    List<Squad> squadExist = await getSquadByName(name);
    if (squadExist.isEmpty){
      await squadCollection.document().setData({
      _squadNameKey: name,
      _locationKey: location,
      _adminKey: uid,
      _membersKey: [uid]
      }).whenComplete(() async{
        List<Squad> squad = await getSquadByName(name);
        SharedPrefs _prefs = SharedPrefs();
        await _prefs.setTeamId(squad[0].squadId);
        print(await _prefs.getTeamId());
        String uid =  await _prefs.getuid();
        UserService _user = UserService(uid: uid);
        await _user.updateTeamId(squad[0].squadId);
      })
      .catchError((e){
        print(e.toString());
        return e;
      });
    }else{
      return 'squadExist';
    }
  }

  // get squad object form snapshot
  Squad _squadDataFromSnapshot(DocumentSnapshot snapshot){
    try{
      return Squad(
        squadId: snapshot.documentID,
        squadName: snapshot.data[_squadNameKey],
        location: snapshot.data[_locationKey],
        members: snapshot.data[_membersKey],
        admin: snapshot.data[_adminKey],
      );
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  // get Squad by name and check weither it exists of not  --Future<List<Squad>>--
  Future<List<Squad>> getSquadByName(String name) async{
    return await squadCollection
    .where(_squadNameKey, isEqualTo: name)
    .getDocuments().then((querySnapshot) {
      return querySnapshot.documents.map((doc){
        return _squadDataFromSnapshot(doc);
      }).toList();
    }).catchError((e){
      print(e.toString());
      return null;
    });
  }

  // get Squad by Id
  Future<Squad> getSquadById(String squadId) async{
    return await squadCollection.document(squadId).get().then((doc) {
      return _squadDataFromSnapshot(doc);
    });
  }

  // getOut from Squad
  Future getOutfromSquad(String squadId, String uid) async{
    Squad squad = await getSquadById(squadId);
    print(squad.members);
    await squadCollection.document(squadId).updateData({
      // _membersKey: squad.members.remove(uid),
    }).whenComplete(() async{
      SharedPrefs _prefs = SharedPrefs();
      await _prefs.setTeamId(null);
      UserService _user = UserService(uid: uid);
      await _user.updateTeamId(null);
    });
  }
}