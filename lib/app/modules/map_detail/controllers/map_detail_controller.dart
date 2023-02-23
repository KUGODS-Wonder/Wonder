import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/data/models/walk_model.dart';

class MapDetailController extends GetxController {

  GoogleMapController? _mapController;
  double zoomVal = Constants.initialZoomLevel;

  late Walk targetWalk;

  @override
  void onInit() {
    targetWalk = Get.arguments['walk'];
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void onCameraMove(CameraPosition position) {
    zoomVal = position.zoom;
  }
}
