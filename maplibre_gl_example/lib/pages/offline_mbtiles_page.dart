import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:maplibre_gl_example/page.dart';
import 'package:maplibre_gl_example/utils/file_utils.dart';

class OfflineMbtilesPage extends ExamplePage {
  const OfflineMbtilesPage({super.key})
      : super(const Icon(Icons.offline_pin), 'Offline MBTiles');

  @override
  Widget build(BuildContext context) {
    return const OfflineMBTilesBody();
  }
}

class OfflineMBTilesBody extends StatefulWidget {
  const OfflineMBTilesBody({super.key});

  @override
  State<OfflineMBTilesBody> createState() => _OfflineMBTilesBodyState();
}

class _OfflineMBTilesBodyState extends State<OfflineMBTilesBody> {
  late MapLibreMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MapLibreMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(0, 0), // Default location
            zoom: 1.0,
          ),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width * .05,
          bottom: MediaQuery.of(context).size.height * .05,
          child: Column(
            children: [
              FloatingActionButton(
                onPressed: () {
                  mapController.animateCamera(CameraUpdate.zoomIn());
                },
                heroTag: 'zoom-in',
                backgroundColor: Colors.white.withOpacity(0.5),
                child: const Icon(Icons.add),
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                onPressed: () {
                  mapController.animateCamera(CameraUpdate.zoomOut());
                },
                heroTag: 'zoom-out',
                backgroundColor: Colors.white.withOpacity(0.5),
                child: const Icon(Icons.remove),
              ),
            ],
          ),
        ),
      ],
    );
  }

   _onMapCreated(MapLibreMapController controller) async {
    mapController = controller;
    // Get the file path
    final filePath = await getMBTilesFilePath();

    // Add the MBTiles source
    mapController.addSource(
      'mbtiles-source',
      RasterSourceProperties(
        tiles: ['file://$filePath'],
        tileSize: 256,
      ),
    );

    // Add a raster layer
    mapController.addLayer(
      'mbtiles-layer',
      'mbtiles-source',
      const RasterLayerProperties(),
    );
  }
}