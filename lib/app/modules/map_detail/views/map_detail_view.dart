import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wonder_flutter/app/modules/map/controllers/map_controller.dart';
import 'package:wonder_flutter/app/modules/widgets/small_walk_container.dart';
import '../controllers/map_detail_controller.dart';

class MapDetailView extends GetView<MapDetailController> {
  const MapDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: min(Get.width, Get.height),
              width: min(Get.width, Get.height),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: GoogleMap(
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
                    scrollGesturesEnabled: false,
                    minMaxZoomPreference: const MinMaxZoomPreference(12, 18),
                  )
                ),
              ),
            ),
            const SizedBox(height: 10),
            Hero(
              tag: 'walk-container-${Get.arguments['id']}',
              child: SmallWalkContainer(
                onSaveButtonPressed: () {},
                onStartButtonPressed: () {},
                walk: controller.targetWalk,
              ),
            )
          ],
        ),
      ),
    );
  }
}
