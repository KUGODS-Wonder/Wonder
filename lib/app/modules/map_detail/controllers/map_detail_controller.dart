import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/common/util/exports.dart';
import 'package:wonder_flutter/app/data/models/walk_model.dart';

class MapDetailController extends GetxController {
  static const Duration _waitTime = Duration(milliseconds: 300);
  GoogleMapController? _mapController;
  double zoomVal = Constants.initialZoomLevel;
  Completer<Set<Polyline>> getPolyLineCompleter = Completer<Set<Polyline>>();

  var isDetailMode = false.obs;

  late Walk targetWalk;
  var polyLines = <Polyline>{}.obs;

  @override
  void onInit() {
    targetWalk = Get.arguments['walk'];
    super.onInit();
  }

  @override
  void onReady() async {
    await Future.delayed(_waitTime).then((value) {
      isDetailMode.value = true;
    });

    polyLines.clear();
    polyLines.add(Polyline(
      polylineId: PolylineId(targetWalk.id.toString()),
      visible: true,
      points: targetWalk.coordinate!.map((c) => LatLng(c.lat, c.lng)).toList(),
      width: 5,
      color: AppColors.kPrimary100,
    ));

    getPolyLineCompleter.complete(polyLines);
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    var coords = targetWalk.coordinate!;
    var midLat = (coords.first.lat + coords.last.lat) / 2;
    var midLng = (coords.first.lng + coords.last.lng) / 2;

    _mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(midLat, midLng),
          zoom: zoomVal,
        ),
      )
    );
  }

  void onCameraMove(CameraPosition position) {
    zoomVal = position.zoom;
  }
}
