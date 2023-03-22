import 'package:get/get.dart';

import '../controllers/walk_track_controller.dart';

class WalkTrackBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<WalkTrackController>(WalkTrackController());
  }
}
