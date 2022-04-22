import 'package:flutter/material.dart';

class Principal extends StatelessWidget {
  const Principal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GooogleMaps VS Mapbox'),
      ),
      body: ListView(
        children: const [
          ListTile(
            title: Text('polyline'),
          )
        ],
      ),
    );
  }
}
