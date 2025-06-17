import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Mapa extends StatefulWidget {
  const Mapa({super.key});

  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(-22.9472, -47.3168),
          initialZoom: 9.2,
        ),

        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: "com.testeget",
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(-22.9472, -47.3168),
                width: 80,
                height: 80,
                child: Icon(Icons.location_pin),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
