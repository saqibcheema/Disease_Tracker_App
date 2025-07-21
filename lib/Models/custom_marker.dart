
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class CustomMarker{
  final LatLng position;
  final Color? color;
  final String title;

  CustomMarker(

  {required this.position,  this.color=Colors.red ,    this.title=''});

}