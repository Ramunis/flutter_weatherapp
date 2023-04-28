import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ramunisweatherapp/ramunisweatherapp/services/forecast_tileprovider.dart';

import 'package:ramunisweatherapp/ramunisweatherapp/services/location.dart';


class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 4,
  );

  late Set<TileOverlay> _tileOverlays = {};

  _initTiles() async
  {
    //
    Location location = Location();
    await location.getCurrentLocation();
    _initialPosition = CameraPosition(
      target: LatLng(location.latitude, location.longitude),
      zoom: 4,
    );
    //
      final String overlayId = DateTime.now().microsecondsSinceEpoch.toString();
      final tileOverlay =TileOverlay(
          tileOverlayId: TileOverlayId(overlayId.toString()),
      tileProvider: ForecastTileProvider(mapType: 'PR0'),
      );
      setState(() {
        _tileOverlays = {tileOverlay};
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          _initTiles();
        },
        tileOverlays: _tileOverlays,
      ),

    );
  }


}

