import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/common/util/converters.dart';
import 'package:wonder_flutter/app/common/values/app_colors.dart';
import 'package:wonder_flutter/app/data/models/profile_model.dart';
import 'package:wonder_flutter/app/data/models/walk_model.dart';
import 'package:wonder_flutter/app/modules/walk_track/views/walk_reward_dialog.dart';
import 'package:wonder_flutter/app/routes/app_pages.dart';

class WalkTrackController extends GetxController {
  static const Duration _checkInterval = Duration(seconds: 1);
  Completer<Set<Polyline>> getPolyLineCompleter = Completer<Set<Polyline>>();
  GoogleMapController? _mapController;
  bool isEvent = false;
  double zoomVal = Constants.initialZoomLevel;
  bool _isChecking = false;

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
    _stopWalk();
  }

  void _onEachTimerInterval(Timer timer) async {
    var elapsedTime = _stopwatch.elapsed;
    var remainingTime = maximumWalkTimeInMinutes - elapsedTime;
    timerStringValue.value = Converters.convertDurationToString(remainingTime);
    if (remainingTime.inSeconds <= 0) {
      _onWalkFailed();
      return;
    }

    bool isCompleted = await isWalkCompleted();
    if (isCompleted) {
      _onWalkCompleted();
      return;
    }
  }

  void startWalk() {
    _timer = Timer.periodic(_checkInterval, _onEachTimerInterval);
    _stopwatch = Stopwatch();
    _stopwatch.start();
  }

  void _stopWalk() {
    _timer.cancel();
    _stopwatch.stop();
  }

  Future<bool> isWalkCompleted() async {
    if (_isChecking) return false;

    _isChecking = true;
    if (_stopwatch.elapsed >= Duration(seconds: 5)) {
      Future.delayed(Duration(seconds: 1));
      _isChecking = false;
      return true;
    } else {
      _isChecking = false;
      return false;
    }
  }

  void _onWalkCompleted() async {
    _stopWalk();

    await Get.dialog(WalkRewardDialog(
      medal: Medal(
        title: '완벽한 한주',
          description: "2023년 2월 2주차에 매일 운동을 하셨습니다!",
          date: DateTime.tryParse("2023-02-07")!,
          comments: "정말 성실하시네요!"
      ),
      ratingUpAmount: 46,
    ));
    Get.offAllNamed(Routes.HOME);
  }

  void _onWalkFailed() async {
    _stopWalk();
    Get.offAllNamed(Routes.HOME);
  }
}
