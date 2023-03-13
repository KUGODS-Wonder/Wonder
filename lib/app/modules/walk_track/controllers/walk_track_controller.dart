import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/common/values/app_colors.dart';
import 'package:wonder_flutter/app/data/models/walk_model.dart';

class WalkTrackController extends GetxController {

  Completer<Set<Polyline>> getPolyLineCompleter = Completer<Set<Polyline>>();
  GoogleMapController? _mapController;
  bool isEvent = false;
  double zoomVal = Constants.initialZoomLevel;
  var polyLines = <Polyline>{}.obs;

  late Walk targetWalk;
  late Color polylineColor;

  @override
  void onInit() {
    super.onInit();
    targetWalk = Get.arguments['walk'];
    isEvent = Get.arguments['isEvent'] ?? false;

    polylineColor = isEvent ? AppColors.kPrimary100 : AppColors.kPrimary80;
  }

  @override
  void onReady() {
    super.onReady();
    _markPolyline();
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

  void _markPolyline() {
    polyLines.clear();
    polyLines.add(Polyline(
      polylineId: PolylineId(targetWalk.id.toString()),
      visible: true,
      points: targetWalk.coordinate!.map((c) => LatLng(c.lat, c.lng)).toList(),
      width: 5,
      color: polylineColor,
    ));

    getPolyLineCompleter.complete(polyLines);
  }

  void onCancelClick() {
  }
}
