import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/values/app_colors.dart';
import 'package:wonder_flutter/app/modules/middlewares/location_permission_guard.dart';
import 'package:wonder_flutter/app/routes/app_pages.dart';


class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  bool _isNavigating = false;

  AppBottomNavigationBar({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: BottomNavigationBar(
        iconSize: 30,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_rounded),
            label: 'Wonder',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: AppColors.middleGrey,
        unselectedItemColor: AppColors.middleGrey,
        unselectedFontSize: 13.0,
        selectedFontSize: 13.0,
        onTap: onTap,
      ),
    );
  }

  void onTap(int index) async {
    if (index == currentIndex || _isNavigating) {
      return;
    }

    _isNavigating = true;

    if (index == 0) {
      Get.offNamed(Routes.EVENT);
    } else if (index == 1) {
      if (await LocationPermissionGuard.checkLocationPermissions()) {
        Get.offNamed(Routes.MAP);
      }
    }else if (index == 2) {
      Get.offAllNamed(Routes.HOME);
    }

    _isNavigating = false;
  }
}

