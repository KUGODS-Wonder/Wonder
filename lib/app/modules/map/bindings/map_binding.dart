import 'package:get/get.dart';
import 'package:wonder_flutter/app/modules/map/controllers/walk_cards_controller.dart';

import '../controllers/map_controller.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MapController>(MapController());
    Get.put<WalkCardsController>(WalkCardsController());
  }
}
