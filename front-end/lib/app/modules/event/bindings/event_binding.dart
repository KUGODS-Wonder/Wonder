import 'package:get/get.dart';
import 'package:wonder_flutter/app/data/providers/walk_provider.dart';

import '../controllers/event_controller.dart';

class EventBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(WalkProvider());
    Get.put<EventController>(EventController());
  }
}
