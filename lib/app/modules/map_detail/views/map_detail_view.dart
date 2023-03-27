import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wonder_flutter/app/modules/map/controllers/map_controller.dart';
import 'package:wonder_flutter/app/modules/widgets/api_fetch_future_builder.dart';
import 'package:wonder_flutter/app/modules/widgets/app_bottom_navigation_bar.dart';
import 'package:wonder_flutter/app/modules/widgets/bookmark_save_panel.dart';
import 'package:wonder_flutter/app/modules/widgets/small_walk_container.dart';
import '../controllers/map_detail_controller.dart';

class MapDetailView extends GetView<MapDetailController> {
  const MapDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    var mapWidth = min(Get.width, Get.height);
    var mapHeight = mapWidth;
    var walkContainerHeight = Get.height - mapHeight - AppBottomNavigationBar.barHeight;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            height: Get.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: mapWidth,
                  width: mapHeight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ApiFetchFutureBuilder(
                        future: controller.getPolyLineCompleter.future,
                        builder: (context, _) {
                          return GoogleMap(
                            mapType: MapType.normal,
                            polylines: controller.polyLines,
                            initialCameraPosition: MapController.initPos,
                            onMapCreated: controller.onMapCreated,
                            onCameraMove: controller.onCameraMove,
                            // myLocationButtonEnabled: true,
                            // myLocationEnabled: true,
                            mapToolbarEnabled: false,
                            zoomControlsEnabled: false,
                            tiltGesturesEnabled: false,
                            rotateGesturesEnabled: false,
                            scrollGesturesEnabled: false,
                            minMaxZoomPreference: const MinMaxZoomPreference(12, 18),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: walkContainerHeight,
                  child: Obx(() {
                      return Hero(
                        tag: 'walk-container-${Get.arguments['id']}',
                        child: SmallWalkContainer(
                          onSaveButtonPressed: controller.saveWalk,
                          onStartButtonPressed: controller.onStartButtonPressed,
                          isDetailMode: controller.isDetailMode.value,
                          isEvent: controller.isEvent,
                          eventMedalImagePath: controller.eventMedalImagePath,
                          walk: controller.targetWalk,
                          detailHeight: walkContainerHeight,
                          requiredWalkLeft: controller.getRequiredWalkLeft(),
                        ),
                      );
                    }
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BookmarkSavePanel(
              controller: controller.bookmarkSavePanelController,
              titleTextController: controller.bookmarkTitleTextController,
              descriptionTextController: controller.bookmarkDescriptionTextController,
              onButtonPressed: controller.saveThisBookmark,
            ),
          )
        ],
      ),
      bottomNavigationBar: const AppBottomNavigationBar(),
    );
  }
}
