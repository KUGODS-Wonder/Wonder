import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/common/util/converters.dart';
import 'package:wonder_flutter/app/common/values/app_colors.dart';
import 'package:wonder_flutter/app/data/models/walk_model.dart';

class WalkTrackController extends GetxController {
  static const Duration _checkInterval = Duration(seconds: 1);
  Completer<Set<Polyline>> getPolyLineCompleter = Completer<Set<Polyline>>();
  GoogleMapController? _mapController;
  bool isEvent = false;
  double zoomVal = Constants.initialZoomLevel;

  late Timer _timer;
  late Stopwatch _stopwatch;
  var polyLines = <Polyline>{}.obs;
  var timerStringValue = RxString('');
  var progress = 0.0.obs;

  late Duration minimumWalkTimeInMinutes;
  late Duration maximumWalkTimeInMinutes;
  late Walk targetWalk;
  late Color polylineColor;

  @override
  void onInit() {
    super.onInit();
    targetWalk = Get.arguments['walk'];
    isEvent = Get.arguments['isEvent'] ?? false;

    maximumWalkTimeInMinutes = Duration(minutes: targetWalk.distance ~/ Constants.minWalkSpeedMeterPerMinute);
    minimumWalkTimeInMinutes = Duration(minutes: targetWalk.distance ~/ Constants.maxWalkSpeedMeterPerMinute);
    timerStringValue.value = Converters.convertDurationToString(maximumWalkTimeInMinutes);

    polylineColor = isEvent ? AppColors.kPrimary100 : AppColors.kPrimary80;
  }

  @override
  void onReady() {
    super.onReady();
    _markPolyline();
    startWalk();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    var coords = targetWalk.coordinate;
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
      points: targetWalk.coordinate.map((c) => LatLng(c.lat, c.lng)).toList(),
      width: 5,
      color: polylineColor,
    ));

    getPolyLineCompleter.complete(polyLines);
  }

  void onCancelClick() {
  }

  void _onEachTimerInterval(Timer timer) {
    var elapsedTime = _stopwatch.elapsed;
    var remainingTime = maximumWalkTimeInMinutes - elapsedTime;
    if (remainingTime.inSeconds <= 0) {
      _timer.cancel();
      _stopwatch.stop();
      return;
    }
    timerStringValue.value = Converters.convertDurationToString(remainingTime);
  }

  void startWalk() {
    _timer = Timer.periodic(_checkInterval, _onEachTimerInterval);
    _stopwatch = Stopwatch();
    _stopwatch.start();
  }
}
