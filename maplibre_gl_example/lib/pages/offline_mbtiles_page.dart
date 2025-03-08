import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:maplibre_gl_example/page.dart';
import 'package:maplibre_gl_example/utils/util.dart';

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
  String? mbtilesPath;

  @override
  void initState() {
    _initializeMBTiles();
    super.initState();
  }

  Future<void> _initializeMBTiles() async {
    mbtilesPath = await getExternalMBTilesPath();
    setState(() {}); // Refresh the widget after the file is copied
  }

  @override
  Widget build(BuildContext context) {
    return mbtilesPath == null
        ? const Center(child: CircularProgressIndicator())
        : Stack(
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

    if (mbtilesPath == null) return;

    // Add the MBTiles source with correct format
    await mapController.addSource(
      'mbtiles-source',
      RasterSourceProperties(
        tiles: ['mbtiles://${mbtilesPath!}'], // Ensure correct format
        tileSize: 256,
        // Bounds in [west, south, east, north] format
        bounds: [-88.583380, 28.808359, -85.353901, 30.215336],
      ),
    );

    // Add a raster layer
    await mapController.addLayer(
      'mbtiles-source', // Source ID
      'mbtiles-layer', // Layer ID
      const RasterLayerProperties(),
    );

    // Animate to the center of the bounds with an appropriate zoom level
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        const CameraPosition(
          target: LatLng(29.51185, -86.96864), // Center of Gulf of Mexico area
          zoom: 9, // Start with a zoom level within minzoom and maxzoom range
        ),
      ),
    );
  }
}

