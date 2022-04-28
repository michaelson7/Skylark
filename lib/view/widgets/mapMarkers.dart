import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../constants/constants.dart';

Marker mapMarkers({
  required double latitude,
  required double longitude,
  required String title,
}) {
  return Marker(
    width: 300.0,
    height: 200.0,
    point: LatLng(latitude, longitude),
    builder: (ctx) => Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on,
            color: kAccent,
            size: 50,
          ),
          Text(
            title,
            style: TextStyle(color: kAccent),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
