import 'package:flutter/material.dart';
import 'package:fusalbookings/models/futsalModel.dart';
import 'package:fusalbookings/models/reviewModel.dart';
import 'package:fusalbookings/screens/nav_screens/imports/imports/review_card.dart';
import 'package:fusalbookings/services/reviewdatabase.dart';
import 'package:fusalbookings/services/sharedprefs.dart';

class FutsalReview extends StatelessWidget {
  final FutsalData futsalData;
  FutsalReview({this.futsalData});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          _addreview(futsalData.uid),
          _reviews(context, futsalData.uid),
        ],
      ),
    );
  }
}
Widget _addreview(String fid){
  String reviewText;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text('Add review'),
      TextField(
        onChanged: (val){
          reviewText = val;
        },
        keyboardType: TextInputType.multiline,
        // textInputAction: TextInputAction.done,
        minLines: 3,
        maxLines: null,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), bottomLeft: Radius.circular(20))
          ),
          hintText: 'Add review',
        ),
      ),
      Align(
        alignment: Alignment.topRight,
        child: FlatButton(
          onPressed: () async{
            SharedPrefs _prefs = SharedPrefs();
            bool isAnon = await _prefs.getisAnon();
            if (!isAnon ?? false){
              String uid = await _prefs.getuid();
              String name = await _prefs.getname();
              Review review = Review(
                userId: uid,
                userName: name,
                star: 4,
                review: reviewText,
              );
              FutsalReviewService _review = FutsalReviewService();
              await _review.setReview(fid, uid, review);
              print('done');
            }
          },
          color: Color(0XFF00ff00),
          child: Text('post'),
        ),
      )
    ],
  ); 
}

Widget _reviews(BuildContext context, String fid){
  Future<List<Review>>  _getReviews() async{
    FutsalReviewService _review = FutsalReviewService();
    return await _review.getReview(fid);
  }
  
  return FutureBuilder(
    future: _getReviews(),
    builder: (context, snapshot){
      // print(snapshot);
      if(snapshot.hasData){
        List<Review> reviews = snapshot.data;
        return Column( 
          children: reviews.map((review) {
            return ReviewCard(name: review.userName, review: review.review,);
          }).toList(),
        );
      }else{
        return Container();
      }
    },
  );
}
