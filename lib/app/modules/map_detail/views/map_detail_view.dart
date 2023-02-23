import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wonder_flutter/app/modules/map/controllers/map_controller.dart';
import '../controllers/map_detail_controller.dart';

class MapDetailView extends GetView<MapDetailController> {
  const MapDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(() {
            return GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: MapController.initPos,
              onMapCreated: controller.onMapCreated,
              onCameraMove: controller.onCameraMove,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              mapToolbarEnabled: false,
              zoomControlsEnabled: false,
              tiltGesturesEnabled: false,
              rotateGesturesEnabled: false,
              minMaxZoomPreference: const MinMaxZoomPreference(12, 18),
            );
          }
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // _buildWalkContainers(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
