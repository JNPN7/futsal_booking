import 'package:flutter/material.dart';
import 'package:fusalbookings/models/futsalModel.dart';

class FutsalDetails extends StatelessWidget {
  final FutsalData futsalData;
  // final String contacts;
  FutsalDetails({this.futsalData});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: <Widget>[
          _ratingRate(context, futsalData.price, size),
          SizedBox(height: 20),
          _bookingsAndDetails(context, futsalData, size),
        ],
      ),
    );
  }
}

Widget _ratingRate(BuildContext context, String price, Size size){
  Future<Widget> _popUpRate(){
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Price', style: TextStyle(fontSize: size.width * .09)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Cost per match: $price', style: TextStyle(fontSize: size.width * .055))
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              textColor: Theme.of(context).primaryColor,
              child: const Text('Okay, got it!'),
            ),
          ],
        );
      }
    );
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
       RaisedButton(
        onPressed: () => _popUpRate(),
        color: Colors.green,
        child: Text('Price', style: TextStyle(fontSize: size.width * .047)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
      )
    ],
  );
}

Widget _bookingsAndDetails(BuildContext context, FutsalData futsalData, Size size){
  Widget secondaryContacts(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Secondary:', style: TextStyle(fontSize: size.width * .06)),
        Text('  ${futsalData.contacts['secondaryName']}', style: TextStyle(fontSize: size.width * .059)),
        Text('  ${futsalData.contacts['secondaryPhoneNo']}', style: TextStyle(fontSize: size.width * .059)),
      ]
    );
  }
  Future<Widget> _popUpContact(){
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Contacts' ,style: TextStyle(fontSize: size.width * .09)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Primary:', style: TextStyle(fontSize: size.width * .06)),
              Text('  ${futsalData.contacts['primaryName']}', style: TextStyle(fontSize: size.width * .059)),
              Text('  ${futsalData.contacts['primaryPhoneNo']}', style: TextStyle(fontSize: size.width * .059)),
              SizedBox(height: 10,),
              futsalData.contacts['secondaryName'] != null ? 
                secondaryContacts() : Container(),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              textColor: Theme.of(context).primaryColor,
              child: const Text('Okay, got it!'),
            ),
          ],
        );
      }
    );
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _availablity('Parking Availablity' , true, size),
          SizedBox(height: 10),
          _availablity('Cafeteria' , false, size),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RaisedButton(
            onPressed: (){
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => FutsalBookPage(futsalData: futsalData,)),
              // );
            },
            color: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ), 
            child: Text('Bookings', style: TextStyle(fontSize: size.width * .047)),
          ),
          RaisedButton.icon(
            // textColor: Colors.green,
            color: Colors.green,
            onPressed: () => _popUpContact(),
            icon: Icon(Icons.phone), 
            label: Text('Contacts', style: TextStyle(fontSize: size.width * .047)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),           
          )
        ],
      )
    ],
  );
}

Widget _availablity(String text, bool isPresent, Size size){
  return Row(
    children: <Widget>[
      Text(text, style: TextStyle(fontSize: size.width * .04)),
      Container(
        margin: EdgeInsets.only(left: 15),
        width: 15,
        height: 15,
        decoration: BoxDecoration(
          color: isPresent ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(15)
        ),
      )
    ],
  );
}

