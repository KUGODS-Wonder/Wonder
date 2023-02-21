import 'package:get/get.dart';
import 'package:wonder_flutter/app/data/models/walk_model.dart';
import 'package:wonder_flutter/app/modules/map/controllers/map_controller.dart';

class WalkCardsController extends GetxController {

  final _mapController = Get.find<MapController>();
  final currentIndex = (-1).obs;

  @override
  void onInit() async {
    super.onInit();
    _mapController.walks.listen(onWalksChange);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onWalksChange(List<Walk> walks) {

  }
}
