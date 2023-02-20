import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/util/exports.dart';
import 'package:wonder_flutter/app/routes/app_pages.dart';

import '../controllers/map_controller.dart';

class MapView extends GetView<MapController> {
  const MapView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: AppColors.kPrimary100,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildWalkCard(),
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

  Widget _buildWalkCard() {
    return Container(
      height: 280,
      width: 300,
      padding: const EdgeInsets.all(25.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Walk',
                  style: AppTextStyle.walkTitle,
                ),
                Text(
                  'Address',
                  style: AppTextStyle.walkAddress,
                ),
                const SizedBox(height: 5.0),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '2.5 km',
                  style: AppTextStyle.walkDescription,
                ),
                Text(
                  '20분 소요',
                  style: AppTextStyle.walkDescription,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
