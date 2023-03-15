import 'package:get/get.dart';
import 'package:wonder_flutter/app/data/providers/bookmark_provider.dart';

import '../controllers/map_controller.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BookmarkProvider>(BookmarkProvider());
    Get.put<MapController>(MapController());
  }
}
