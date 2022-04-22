// ignore_for_file: cascade_invocations

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  late MapboxMapController mapController;

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  void _add() {
    mapController.clearLines();
    mapController.clearSymbols();
    // mapController.addLayer('addLayer', 'sdas', SymbolLayerProperties());

    mapController.addLine(
      const LineOptions(
        geometry: [
          LatLng(-0.959804, -80.683171),
          LatLng(-0.959032, -80.686304),
          LatLng(-0.958088, -80.690596),
          LatLng(-0.956758, -80.692827),
          LatLng(-0.955427, -80.693771),
          LatLng(-0.953711, -80.693857),
          LatLng(-0.950922, -80.695059),
        ],
        lineColor: '#ff0000',
        lineWidth: 5.0,
        // lineOpacity: 0.9,
        draggable: true,
        // lineBlur: 4,
        // lineGapWidth: 10,
        // lineOffset: 10,
        linePattern: 'line-dash',
      ),
    );

    const geojson = {
      'type': 'FeatureCollection',
      'features': [
        {
          'type': 'Feature',
          'geometry': {
            'coordinates': [
              [-77.044211, 38.852924],
              [-77.045659, 38.860158],
              [-77.044232, 38.862326],
              [-77.040879, 38.865454],
              [-77.039936, 38.867698],
              [-77.040338, 38.86943],
              [-77.04264, 38.872528],
              [-77.03696, 38.878424],
              [-77.032309, 38.87937],
              [-77.030056, 38.880945],
              [-77.027645, 38.881779],
              [-77.026946, 38.882645],
              [-77.026942, 38.885502],
              [-77.028054, 38.887449],
              [-77.02806, 38.892088],
              [-77.03364, 38.892108],
              [-77.033643, 38.899926]
            ],
            'type': 'LineString'
          }
        }
      ]
    };
    mapController.addSource(
      'line',
      const GeojsonSourceProperties(lineMetrics: true, data: geojson),
    );
    mapController.addLayer(
      'line',
      'line',
      const LineLayerProperties(
        lineRoundLimit: 10,
        lineCap: 'round',
        lineJoin: 'round',
        lineWidth: 14,
        lineGradient: [
          'interpolate',
          ['linear'],
          ['line-progress'],
          0,
          'blue',
          0.1,
          'royalblue',
          0.3,
          'cyan',
          0.5,
          'lime',
          0.7,
          'yellow',
          1,
          'red'
        ],
      ),
    );
  }

  void aimate() {
    mapController
        .animateCamera(
          // CameraUpdate.newCameraPosition(
          //   const CameraPosition(
          //     target: LatLng(51.5160895, -0.1294527),
          //     tilt: 30.0,
          //     bearing: 5,
          //     zoom: 17.0,
          //   ),
          // ),
          // CameraUpdate.bearingTo(0.0),
          CameraUpdate.tiltTo(63),
        )
        .then((result) =>
            print('mapController.animateCamera() returned $result'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Principal'),
      ),
      body: MapboxMap(
        onMapCreated: _onMapCreated,
        rotateGesturesEnabled: true,
        initialCameraPosition: const CameraPosition(
          target: LatLng(
            40.7135,
            -74.0066,
          ),
          zoom: 15.5,
          // bearing: -17.6,
          // tilt: 20.0,
        ),
        myLocationEnabled: true,
        myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
        myLocationRenderMode: MyLocationRenderMode.COMPASS,
        onUserLocationUpdated: (location) {
          log('LOCATION: ${location.position.latitude} ${location.position.longitude}');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _add();
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
