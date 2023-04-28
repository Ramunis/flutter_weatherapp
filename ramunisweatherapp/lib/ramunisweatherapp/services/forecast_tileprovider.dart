import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ForecastTileProvider implements TileProvider{
  late final String mapType;

  ForecastTileProvider(
  {
   required this.mapType,
  });

  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    Uint8List tileBytes = Uint8List(0);

    try {
      final url =
          "http://maps.openweathermap.org/maps/2.0/weather/Pro/$zoom/$x/$y?appid=a0fff5baeda20538ce0c29c3b57c2209";

        final uri = Uri.parse(url);
        final ByteData imageData = await NetworkAssetBundle(uri).load("");
        tileBytes = imageData.buffer.asUint8List();
      }
    catch (e) {
      print(e.toString());
    }

    return Tile(256,256,tileBytes);
  }
}