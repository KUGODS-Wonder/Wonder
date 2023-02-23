import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wonder_flutter/app/data/models/walk_model.dart';
import 'package:wonder_flutter/app/data/providers/walk_provider.dart';
import 'package:wonder_flutter/app/modules/map/controllers/swipe_page_controller_mixin.dart';

class MapController extends GetxController with GetSingleTickerProviderStateMixin,SwipePageControllerMixin {
  final WalkProvider _walkProvider = WalkProvider.to;

  static const CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  final currentIndex = (-1).obs;
  final RxList<Walk> walks = <Walk>[].obs;

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

  @override
  void onWalkChange(int index) {
    changeIndex(index);
  }
}
