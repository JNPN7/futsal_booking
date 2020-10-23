import 'package:flutter/material.dart';
import 'package:fusalbookings/models/futsalModel.dart';

class FutsalCardHome extends StatelessWidget {
  final FutsalData futsalData;
  FutsalCardHome({this.futsalData});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(10, 0, 5.0, 5.0),
      color: Colors.green[100],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: <Widget>[
            _futsalImage(),
            SizedBox(width: 10,),
            _futsalDescription(futsalData.price, futsalData.futsalName, futsalData.locationName)
          ],
        ),
      ),
    );
  }
}

Widget _futsalImage(){
  return CircleAvatar(
    radius: 50.0,
    // child: Image(
    //   image: NetworkImage(''),
    //   fit: BoxFit.cover,
    // ),
  );
}

Widget _futsalDescription(String price, String futsalName, String location){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          color: Colors.yellow,
        ),
        child: Text(
          'Rs. $price',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      Container(
        width: 90.0,
        child: Text(
          futsalName,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ),
      _buildRatingStars(5),
      Container(
        width: 120.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          location,
        ),
      )
    ],
  );
}

Text _buildRatingStars(int rating) {
  String stars = '';
  for (int i = 0; i < rating; i++) {
    stars += '⭐';
  }
  return Text(stars);
}
// Stack(
// children: <Widget>[
//   Container(
//     margin: EdgeInsets.fromLTRB(10, 5.0, 5.0, 5.0),
//     height: 140.0,
//     width: 250.0,
//     decoration: BoxDecoration(
//         color: Theme.of(context).primaryColor,
//         borderRadius: BorderRadius.circular(20.0)),
//     child: Padding(
//       padding: EdgeInsets.fromLTRB(130.0, 5.0, 5.0, 5.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(7.0),
//               color: Colors.yellow,
//             ),
//             child: Text(
//               '\Rs. ${futsal.price}',
//               style: TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           Container(
//             width: 90.0,
//             child: Text(
//               futsal.name,
//               style: TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.w500,
//               ),
//               overflow: TextOverflow.ellipsis,
//               maxLines: 2,
//             ),
//           ),
//           _buildRatingStars(futsal.ratings),
//           Container(
//             width: 120.0,
//             decoration: BoxDecoration(
//               color: Theme.of(context).primaryColor,
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             alignment: Alignment.center, // text to center
//             child: Text(
//               futsal.textLocation,
//             ),
//           )
//         ],
//       ),
//     ),
//   ),
//   Positioned(
//     top: 10.0,
//     left: 15.0,
//     child: ClipRRect(
//       borderRadius: BorderRadius.circular(20.0),
//       child: Image(
//         height: 120.0,
//         width: 110.0,
//         image: NetworkImage(futsal.imageUrl),
//         fit: BoxFit.cover,
//       ),
//     ),
//   )
// ],
// ),