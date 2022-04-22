import 'dart:convert';

import 'package:flutter/services.dart';

class Data {
  static Future<List<DataLatLng>> loadRoute() async {
    final response = await rootBundle.loadString('assets/route.json');
    final data = json.decode(response) as List<dynamic>;
    return data
        .map((dynamic e) => DataLatLng.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

class DataLatLng {
  const DataLatLng({
    required this.lat,
    required this.lng,
  });

  factory DataLatLng.fromJson(Map<String, dynamic> json) {
    return DataLatLng(
      lat: json['lat'] as double,
      lng: json['lng'] as double,
    );
  }

  final double lat;
  final double lng;
}
