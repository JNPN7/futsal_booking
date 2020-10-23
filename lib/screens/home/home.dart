import 'dart:async';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:fusalbookings/imports/constants.dart';
import 'package:fusalbookings/imports/futsal_card_home.dart';
import 'package:fusalbookings/models/futsalModel.dart';
// import 'package:fusalbookings/models/user.dart';
import 'package:fusalbookings/screens/nav_screens/futsal_profile.dart';
import 'package:fusalbookings/services/futsaldatabase.dart';
import 'package:fusalbookings/services/sharedprefs.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  // final AuthService _auth = AuthService();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin{
  Completer<GoogleMapController> _controller = Completer();

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  } 
  double _zoom = 14;
  Future test()async{
    final futsal = FutsalService();
    await futsal.test('Bhaktapur', 10);
  }
  

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // test();
    // _auth.signOut();
    return Scaffold(
      body: Stack(
        children: [
        _googlemap(context),
        _searchbar(),
        // FlatButton(
        //   onPressed: ()async{
        //     await _auth.signOut();
        //   },
        //   child: Text('hahah'),
        // )
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            height: 140,
            child: _buildFutsalList()
          )
        )
        ]
      ),
    );
  }

  Widget _googlemap(BuildContext context){
    
    Future<List<double>> getLatLng() async{
      List latLng;
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // String locationName = await prefs.get('location');
      // bool isAnon = await prefs.get('isAnon');
      SharedPrefs _prefs = SharedPrefs();
      String locationName = await _prefs.getLocation();
      bool isAnon = await _prefs.getisAnon();
      if (isAnon){
        latLng = getLatLogFromLocationName();
      }else{
        latLng = getLatLogFromLocationName(location: locationName);
      }
      return latLng;
    }
   
    return FutureBuilder(
      future: getLatLng(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          List<double> latlog = snapshot.data;
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition:
                CameraPosition(target: LatLng(latlog[0], latlog[1]), zoom: _zoom),
              onMapCreated: _onMapCreated,
              markers: {},
            ),
          );
        }else{
          return Container(
            // height: MediaQuery.of(context).size.height,
            // width: MediaQuery.of(context).size.width,
            // child: GoogleMap(
            //   mapType: MapType.normal,
            //   initialCameraPosition:
            //     CameraPosition(target: LatLng( 27.671571, 85.428877), zoom: _zoom),
            //   onMapCreated: _onMapCreated,
            //   markers: {},
            // ),
          );
        }
      },
        
    );
    // return StreamBuilder<UserData>(
    //   stream: UserService(uid : user.uid).userData,
    //   builder: (context, snapshot) {
    //     List latLng;
    //     if (snapshot.hasData){
    //       UserData userData = snapshot.data;
    //       // print(userData.name);
    //       // print(userData.phoneNo);
    //       // print(userData.uid);
    //       // print(userData.locationName);
    //       latLng =getLatLogFromLocationName(location: userData.locationName);
    //       // print(latLng[1]);
    //       return Container(
    //         height: MediaQuery.of(context).size.height,
    //         width: MediaQuery.of(context).size.width,
    //         child: GoogleMap(
    //           mapType: MapType.normal,
    //           initialCameraPosition:
    //             CameraPosition(target: LatLng(latLng[0], latLng[1]), zoom: _zoom),
    //           onMapCreated: _onMapCreated,
    //           markers: {},
    //         ),
    //       );
    //     }else if (user.isAnon){
    //       latLng = getLatLogFromLocationName();
    //       return Container(
    //         height: MediaQuery.of(context).size.height,
    //         width: MediaQuery.of(context).size.width,
    //         child: GoogleMap(
    //           mapType: MapType.normal,
    //           initialCameraPosition:
    //             CameraPosition(target: LatLng(latLng[0], latLng[1]), zoom: _zoom),
    //           onMapCreated: _onMapCreated,
    //           markers: {},
    //         ),
    //       );
    //     }else{
    //       return Container(
    //         child: Center(
    //           child: FlatButton(
    //             color: Colors.green,
    //             onPressed: (){
    //               _auth.signOut();
    //             },
    //             child: Text('There is some trouble press to sign out')
    //           ),
    //         ),
    //       );
    //     }
        
    //   }
    // );
  }

  @override
  bool get wantKeepAlive => true;
}
Widget _searchbar() {
  return Padding(
    padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
    child: Align(
      alignment: Alignment.topRight,
      child: SearchBar(
        onSearch: null,
        onItemFound: null,
        placeHolder: Text(""),
        cancellationWidget: Text("Cancel"),
        emptyWidget: Text("empty"),
        searchBarStyle:
          SearchBarStyle(borderRadius: BorderRadius.circular(10.0)),
      ),
    ),
  );
}

Future<List<FutsalData>> _getFutsalList({String location = 'Bhaktapur', int limit = 10}) async{
  final _futsal = FutsalService();
  List<FutsalData> futsalData = await _futsal.getListOfFutsalInDistrict(location, limit) ?? [];
  limit = 10 - futsalData.length;
  // print(futsalData);
  List<FutsalData> additionalFutsal = await _futsal.getListOfFutsalNotInDistrict(location, limit);
  // print(additionalFutsal);
  futsalData.addAll(additionalFutsal);
  return futsalData;
}

Widget _buildFutsalList(){
  Future<String> getLocation() async{
    SharedPrefs _prefs = SharedPrefs();
    return await _prefs.getLocation();
  }
  return FutureBuilder(
    future: getLocation(),
    builder: (context, snapshot){
      if(snapshot.hasData){
        String locationName = snapshot.data;
        return FutureBuilder(
          future: _getFutsalList(location: locationName, limit: 10),
          builder: (context, snapshot){
            if (snapshot.hasData){
              List<FutsalData> futsalData = snapshot.data;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: futsalData.length,
                itemBuilder: (BuildContext context, int index){
                  FutsalData futsal = futsalData[index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FutsalProfile(futsalUid: futsal.uid,)),
                      );
                    },
                    child: FutsalCardHome(futsalData: futsal)
                  );
                }
              );
            }else{
              return Container(); 
            }
          }
        );
      }else{
        return Container();
      }
    }
    
  );
}
    

// class Home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         Menu(),
//         Drashboard(),

//       ],
//     );
//   }
// }