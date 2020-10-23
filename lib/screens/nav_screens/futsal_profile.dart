import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:fusalbookings/imports/loading.dart';
import 'package:fusalbookings/models/futsalModel.dart';
import 'package:fusalbookings/screens/nav_screens/imports/futsal_porfile_pic_strap.dart';
import 'package:fusalbookings/screens/nav_screens/imports/futsal_profile_detail.dart';
import 'package:fusalbookings/screens/nav_screens/imports/futsal_profile_map.dart';
import 'package:fusalbookings/screens/nav_screens/imports/futsal_profile_review.dart';
import 'package:fusalbookings/services/futsaldatabase.dart';

class FutsalProfile extends StatelessWidget {
  final String futsalUid;
  FutsalProfile({this.futsalUid});
  
  Future<FutsalData> _getFutsalData() async{
    final _futsal = FutsalService();
    return await _futsal.getFutsalData(futsalUid);   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getFutsalData(),
        builder: (context, snapshot){
          if (snapshot.hasData){
            // print(snapshot);
            FutsalData futsalData = snapshot.data;
            return Stack(
              children: [
                _content(futsalData, context),
                _backArrow(context),
              ]
            );
          }else{
            return LoadingNotFullScreen();
          }
        }
      ),
    );
  }
}

Widget _backArrow(BuildContext context){
  return Positioned(
    top: 15.0,
    child: IconButton(
      onPressed: (){
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back, 
        // color: Colors.black,
      )
    ),
  );
}

Widget _content(FutsalData futsalData, BuildContext context){
  return Column(
    children: [
      FutsalProfileMap(futsalName: futsalData.futsalName, textLocation: futsalData.locationName, location: futsalData.latlng),
      Expanded(
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: (){
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            // onVerticalDragStart: (drag){
            //   FocusScope.of(context).requestFocus(new FocusNode());
            // },
            child: Column(
              children: <Widget>[
                FutsalDetails(futsalData: futsalData),
                FutsalPicStarp(),
                SizedBox(height: 20),
                FutsalReview(futsalData: futsalData),
                SizedBox(height: 20),
                
              ]
            ),
          ),
        )
      ),
    ],
  );
}


/////////////////////////// For Sliver AppBar / Problem touch conflit ////////////////////
// class FutsalProfile extends StatelessWidget {
//   final String futsalUid;
//   FutsalProfile({this.futsalUid});
  
//   Future<FutsalData> _getFutsalData() async{
//     final _futsal = FutsalService();
//     return await _futsal.getFutsalData(futsalUid);   
//   }
//   @override
//   Widget build(BuildContext context) {
//     print(futsalUid);
//     return Scaffold(
//       body: FutureBuilder(
//         future: _getFutsalData(),
//         builder: (context, snapshot){
//           if (snapshot.hasData){
//             print(snapshot);
//             FutsalData futsalData = snapshot.data;
//             return test(context, futsalData);
//           }else{
//             return LoadingNotFullScreen();
//           }
//         }
//       ),
//     );
//   }
// }
// Widget test(BuildContext context, FutsalData futsalData){
//   return CustomScrollView(
//     slivers: <Widget>[
//       SliverAppBar(
//         title: Text('Nothing'),
//         expandedHeight: 250,
//         floating: false,
//         pinned: true,
//         flexibleSpace: FlexibleSpaceBar(
//           background: FutsalProfileMap(futsalName: futsalData.futsalName, textLocation: futsalData.locationName, location: futsalData.latlng),
//         )
//       ),
//       SliverList(
//         delegate:  SliverChildBuilderDelegate(
//           (BuildContext context, int index) {
//             return Container(
//               alignment: Alignment.center,
//               height: 100,
//               color: Colors.teal[100 * (index % 9)],
//               child: Text('grid item $index'),
//             );
//           },
//           childCount: 20,
//         ),
//       )

//     ],
//   );
// }


// }
