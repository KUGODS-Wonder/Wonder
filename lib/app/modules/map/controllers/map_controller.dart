import 'package:get/get.dart';
import 'package:wonder_flutter/app/data/models/walk_model.dart';
import 'package:wonder_flutter/app/data/providers/walk_provider.dart';

class MapController extends GetxController {
final WalkProvider _walkProvider = WalkProvider.to;

  final currentIndex = (-1).obs;
  RxList<Walk> walks = <Walk>[].obs;

  Walk get currentWalk => walks[currentIndex.value];

  @override
  void onInit() async {
    super.onInit();
    fetchWalks();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void fetchWalks() async {
    walks.clear();
    walks.addAll(await _walkProvider.getWalks());
    changeIndex(walks.isEmpty ? -1 : 0);
  }

  void changeIndex(int index) {
    if (index < walks.length) {
      currentIndex.value = index;
    }
  }
}
