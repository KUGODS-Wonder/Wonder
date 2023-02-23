import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wonder_flutter/app/common/util/exports.dart';
import 'package:wonder_flutter/app/modules/widgets/rotation_3d.dart';
import 'package:wonder_flutter/app/modules/widgets/small_walk_container.dart';
import 'package:wonder_flutter/app/routes/app_pages.dart';

import '../controllers/map_controller.dart';

class MapView extends GetView<MapController> {
  const MapView({Key? key}) : super(key: key);
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
                  onTap: controller.onMapTap,
                  markers: Set<Marker>.of(controller.markers),
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
                _buildWalkContainers(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 90,
        child: BottomNavigationBar(
          iconSize: 30,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'Bookmarks',
            ),
          ],
          currentIndex: 1,
          selectedItemColor: AppColors.middleGrey,
          unselectedItemColor: AppColors.middleGrey,
          unselectedFontSize: 13.0,
          selectedFontSize: 13.0,
          onTap: (index) {
            if (index == 0) {
              Get.offNamed(Routes.HOME);
            } else if (index == 2) {
              Get.offAllNamed(Routes.SPLASH);
            }
          },
        ),
      ),
    );
  }

  Widget _buildWalkContainers() {
    return Obx(() {
      if (controller.walks.isNotEmpty) {
        // return SmallWalkContainer(walk: controller.currentWalk);
        return Listener(
          onPointerUp: controller.onHandlePointerUp,
          child: NotificationListener(
            onNotification: controller.onHandleScrollNotifications,
            child: SizedBox(
              //Wrap list in a container to control height and padding
              height: controller.cardHeight,
              //Use a ListView.builder, calls buildItemRenderer() lazily, whenever it need to display a listItem
              child: PageView.builder(
                //Use bounce-style scroll physics, feels better with this demo
                physics: const BouncingScrollPhysics(),
                controller: controller.pageController,
                itemCount: controller.walks.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  return Obx(() {
                      return Rotation3d(
                        rotationY: controller.currentRotation,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 7.5, right: 7.5, top: 10.0),
                          child: Hero(
                            tag: 'walk-container-${controller.walks[i].id}',
                            child: SmallWalkContainer(
                              onSaveButtonPressed: () {},
                              onStartButtonPressed: controller.onStartButtonPressed,
                              walk: controller.walks[i],
                            ),
                          ),
                        ),
                      );
                    }
                  );
                },
              ),
            ),
          ),
        );
        // WalkCardsWidget(walks: controller.walks, onWalkChange: (walk) {
        //   printInfo(info: 'onCityChange ${walk.name}}');
        // });
      } else {
        return const SizedBox(height: 1);
      }
    });
  }
}
