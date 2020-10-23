import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fusalbookings/models/reviewModel.dart';

class FutsalReviewService{
  String _userIdKey = 'userId';
  String _userNameKey = 'userName';
  String _starKey = 'star';
  String _reviewKey = 'review';

  // collection reference         
  final CollectionReference futsalCollection = Firestore.instance.collection('futsalOwner');

  // get Data from Snapshot
  Review _reviewDataFromSnapshot(DocumentSnapshot snapshot){
    try{
      return Review(
        userId: snapshot.data[_userIdKey],
        userName: snapshot.data[_userNameKey],
        star: snapshot.data[_starKey],
        review: snapshot.data[_reviewKey]
      );
    }catch(e){
      // print('*'*20);
      print(e.toString());
      return null;
    }
  }
  Future<List<Review>> getReview(String uid) async {
    try{
      return await futsalCollection.document(uid)
      .collection('review').getDocuments()
      .then((querySnapshot) {
        return querySnapshot.documents
        .map((doc) {
          return _reviewDataFromSnapshot(doc);
        }).toList();
      });
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future setReview(String fid, String uid, Review review) async{
    try{
      return await futsalCollection.document(fid)
      .collection('review').document(uid)
      .setData({
        _userIdKey: review.userId,
        _userNameKey: review.userName,
        _starKey: review.star,
        _reviewKey: review.review
      });
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}