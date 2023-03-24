import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/values/app_colors.dart';
import 'package:wonder_flutter/app/modules/middlewares/location_permission_guard.dart';
import 'package:wonder_flutter/app/routes/app_pages.dart';


class AppBottomNavigationBar extends StatefulWidget {
  static double barHeight = 90 + (GetPlatform.isIOS ? 15 : 0);
  // current Index 는 똑같은 화면으로 중복해서 navigation 하지 않기 위해 필요.
  // 오픈한 페이지의 index 를 저장해서 사용자가 클릭한 index 와 같으면 무시한다.
  final int currentIndex;
  // 만약 bottom navigation bar 에 포함되지 않은 화면에 있을 경우 true.
  final bool isNotMainScreen;

  const AppBottomNavigationBar({
    Key? key,
    this.currentIndex = -1,
  }) : isNotMainScreen = currentIndex == -1, super(key: key);

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  bool _isNavigating = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppBottomNavigationBar.barHeight,
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
        currentIndex: widget.isNotMainScreen ? 0 : widget.currentIndex,
        selectedItemColor: AppColors.middleGrey,
        unselectedItemColor: AppColors.middleGrey,
        unselectedFontSize: 13.0,
        selectedFontSize: 13.0,
        onTap: onTap,
      ),
    );
  }

  void onTap(int index) async {
    if (index == widget.currentIndex || _isNavigating) {
      return;
    }

    var targetRoute = '';

    _isNavigating = true;

    if (index == 0) {
      targetRoute = Routes.EVENT;
    } else if (index == 1) {
      if (await LocationPermissionGuard.checkLocationPermissions()) {
        targetRoute = Routes.MAP;
      }
    } else if (index == 2) {
      targetRoute = Routes.HOME;
    }

    if (targetRoute.isEmpty) {
      _isNavigating = false;
      return;
    }

    Get.until((route) => route.isFirst);
    if (Get.currentRoute != targetRoute) {
      Get.offAllNamed(targetRoute);
    }

    _isNavigating = false;
  }
}

