import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fusalbookings/models/futsalModel.dart';

class FutsalService{
  String _futsalIdKey = 'futsalId';
  String _futsalNameKey = 'futsalName';
  String _latlongKey = 'latlong';
  String _contactKey = 'contacts'; 
  String _locationNameKey = 'locationName';
  String _priceKey = 'price';
  String _cafeteriaKey = 'cafeteria';
  String _parkingKey = 'parking';

  // collection reference
  final CollectionReference futsalCollection = Firestore.instance.collection('futsalOwner');

  // get data from snapshot
  FutsalData _userdatafromsnapshot(DocumentSnapshot snapshot){
    // snapshot == null ? print('isNull') : print('isNot Null');
    // print(snapshot.data['futsalName']);
    try{ 
      return FutsalData(
        uid: snapshot.data[_futsalIdKey],
        futsalName: snapshot.data[_futsalNameKey],
        latlng: snapshot.data[_latlongKey],
        contacts: snapshot.data[_contactKey],
        locationName: snapshot.data[_locationNameKey],
        price: snapshot.data[_priceKey],
        isCafeteriaAvailable: snapshot.data[_cafeteriaKey],
        isParkingAvailable: snapshot.data[_parkingKey], 
      ); 
    }catch(e){
      print(e.toString());
      return null;
    }
  }  

  // get futsal of the district
  Future<List<FutsalData>> getListOfFutsalInDistrict(String location, int limit) async{
    try{
      return await futsalCollection
      .where(_locationNameKey, isEqualTo:'${location[0].toUpperCase()}${location.substring(1).toLowerCase()}')
      .limit(limit)
      .getDocuments().then((querySnapshot) {
        return querySnapshot.documents.map((doc) {
          return _userdatafromsnapshot(doc);
        }).toList();
      });
    }catch(e){
      print(e.toString());
      return null;
    }
  } 
  
  // get futsal not in district
  Future<List<FutsalData>> getListOfFutsalNotInDistrict(String location, int limit) async{
    try{
      return await futsalCollection
      .limit(limit)
      .getDocuments().then((querySnapshot) {
        return querySnapshot.documents
        .map((doc) {
          return _userdatafromsnapshot(doc);
        }).toList();
      });
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future getFutsalData(String uid) async{
    try{
      return await futsalCollection.document(uid).get().then((doc){
        return _userdatafromsnapshot(doc);
      }); 
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future test(String location, int limit) async{
    try{
    return await futsalCollection
      .where(_locationNameKey, isEqualTo:'${location[0].toUpperCase()}${location.substring(1).toLowerCase()}')
      .limit(1)
      .getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((doc) {
          print('???Fluttert???:  ${doc.data}');
        });
      }); 
    }catch(e){
      print(e.toString());
      return null;
    }
  } 
}