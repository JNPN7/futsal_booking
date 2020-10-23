import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FutsalProfileMap extends StatefulWidget {
  final String futsalName;
  final String textLocation;
  final Map<String, dynamic> location;
  FutsalProfileMap({this.futsalName, this.textLocation, this.location});
  
  @override
  _FutsalProfileMapState createState() => _FutsalProfileMapState();
}

class _FutsalProfileMapState extends State<FutsalProfileMap>{
  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .35,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: 40, offset: Offset.zero,spreadRadius: -10)]
      ),
      child:  ClipRRect(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        ),
        child: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.location['latitude'], widget.location['longitude']),
                zoom: 16.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('SFD'),
                  position: LatLng(widget.location['latitude'], widget.location['longitude']),
                  infoWindow: InfoWindow(title: widget.futsalName),
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
                )
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(widget.futsalName, style: TextStyle(fontSize: size.width * .1, color: Colors.green[900])),
                  Text(widget.textLocation, style: TextStyle(fontSize: size.width * .05, color: Colors.indigo))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}