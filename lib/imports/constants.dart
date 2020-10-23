
import 'package:flutter/material.dart';

// TextFieldForm decoration
const inputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.green, width: 2),
  )
);


// get loation to latlog
List<Map<String, dynamic>> locationToLatLog = [
  {'location': 'bhaktapur', 'latlog': [27.671571, 85.428877]},
  {'location': 'kathmandu', 'latlog': [27.715450, 85.335556]},
  {'location': 'lalitpur', 'latlog': [27.676578, 85.322150]},
];

List getLatLogFromLocationName({String location = ''}){
  for(Map<String, dynamic> toLatLog in locationToLatLog){
    if (location.toLowerCase() == toLatLog['location'].toLowerCase()){
      return toLatLog['latlog'];
    }
  }
  return locationToLatLog[0]['latlog'];
}
