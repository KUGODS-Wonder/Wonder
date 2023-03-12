import 'package:get/get.dart';

import '../controllers/reservation_list_controller.dart';

class ReservationListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReservationListController>(
      () => ReservationListController(),
    );
  }
}
