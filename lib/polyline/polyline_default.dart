import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mapitas/data/data.dart';

class PolylineDefault extends StatefulWidget {
  const PolylineDefault({Key? key}) : super(key: key);

  @override
  State<PolylineDefault> createState() => _PolylineDefaultState();
}

class _PolylineDefaultState extends State<PolylineDefault> {
  late MapboxMapController mapController;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _addPolyline() async {
    log('==================================================');
    final route = await Data.loadRoute();
    final geometry = route.map((e) => LatLng(e.lat, e.lng)).toList();
    final geometry2 = route
        .map((e) => [
              e.lng,
              e.lat,
            ])
        .toList();

    await mapController.clearLines();
    await mapController.clearSymbols();
    await mapController.removeSource('line');
    await mapController.removeLayer('line');

    final geojson = {
      'type': 'FeatureCollection',
      'features': [
        {
          'type': 'Feature',
          'geometry': {'coordinates': geometry2, 'type': 'LineString'}
        }
      ]
    };

    await mapController.addSource(
      'line',
      GeojsonSourceProperties(
        lineMetrics: true,
        data: geojson,
      ),
    );
    await mapController.addLayer(
      'line',
      'line',
      LineLayerProperties(
        lineColor: '#000000',
        lineWidth: 5,
        lineRoundLimit: 10,
        lineCap: 'butt',
        // lineJoin: 'round',
        // lineGapWidth: 50,
        // lineGapWidth: 10,
        lineDasharray: [10, 5, 10, 10, 5, 10, 10, 5, 10],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Principal'),
      ),
      body: MapboxMap(
        onMapCreated: (controller) {
          mapController = controller;
          _addPolyline();
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(-0.941711, -80.732402),
          zoom: 16,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addPolyline();
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
