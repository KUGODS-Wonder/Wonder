import 'package:wonder_flutter/app/data/providers/profile_provider.dart';
import 'package:wonder_flutter/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ProfileProvider>(ProfileProvider());
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
