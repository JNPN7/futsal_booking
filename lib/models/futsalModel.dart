class FutsalData{
  String uid;
  String futsalName;
  Map< String, dynamic> latlng;
  String locationName;
  String price;
  bool isParkingAvailable;
  bool isCafeteriaAvailable;
  Map<String, dynamic> contacts;
  FutsalData({this.uid, this.futsalName, this.latlng, this.locationName, this.price, this.isParkingAvailable, this.isCafeteriaAvailable, this.contacts});
}