import 'package:get/get.dart';

import '../controllers/map_controller.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MapController>(MapController());
  }
}
