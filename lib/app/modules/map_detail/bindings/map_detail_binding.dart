import 'package:get/get.dart';
import 'package:wonder_flutter/app/data/providers/reservation_provider.dart';

import '../controllers/map_detail_controller.dart';

class MapDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapDetailController>(
          () => MapDetailController(),
    );

    Get.lazyPut<ReservationProvider>(
          () => ReservationProvider(),
    );
  }
}
