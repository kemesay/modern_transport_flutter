import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const LatLng _pGoogleplex = LatLng(34.053087282290115, -118.24541581368243);
  @override
  Widget build(BuildContext content) {
    return const Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _pGoogleplex,
          zoom: 13,
        ),
      ),
    );
  }
}
