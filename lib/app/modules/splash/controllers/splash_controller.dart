import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/modules/middlewares/location_permission_guard.dart';
import 'package:wonder_flutter/app/routes/app_pages.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();

    await Future.delayed(Constants.splashTime);

    // 임시로 맵으로 이동 시킴
    recursiveLocationCheck();

    // 차후에 로그인 구현되면 아래 코드로 이동 시킬 예정
    //
    // var storage = Get.find<SharedPreferences>();
    // try {
    //   if (storage.getString(StorageConstants.token) != null) {
    //     Get.toNamed(Routes.HOME);
    //   } else {
    //     Get.toNamed(Routes.AUTH);
    //   }
    // } catch (e) {
    //   Get.toNamed(Routes.AUTH);
    // }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void recursiveLocationCheck() async {
    if (await LocationPermissionGuard.checkLocationPermissions()) {
      Get.offNamed(Routes.MAP);
    } else {
      recursiveLocationCheck();
    }
  }
}
