import 'package:get/get.dart';
import 'package:wonder_flutter/app/data/providers/reservation_provider.dart';

import '../controllers/reservation_list_controller.dart';

class ReservationListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReservationListController>(
      () => ReservationListController(),
    );
    Get.lazyPut<ReservationProvider>(
          () => ReservationProvider(),
    );
  }
}
