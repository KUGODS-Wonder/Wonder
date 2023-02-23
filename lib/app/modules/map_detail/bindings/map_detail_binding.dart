import 'package:get/get.dart';

import '../controllers/map_detail_controller.dart';

class MapDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapDetailController>(
      () => MapDetailController(),
    );
  }
}
