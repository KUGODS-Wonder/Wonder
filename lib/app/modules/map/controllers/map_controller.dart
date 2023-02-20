import 'package:get/get.dart';
import 'package:wonder_flutter/app/data/providers/walk_provider.dart';

class MapController extends GetxController {
final WalkProvider _walkProvider = WalkProvider.to;

  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    var walks = await _walkProvider.getWalks();

    printInfo(info: walks.toString());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
