import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_platform_interface/location_platform_interface.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/common/util/converters.dart';
import 'package:wonder_flutter/app/common/util/google_map_utils.dart';
import 'package:wonder_flutter/app/common/util/utils.dart';
import 'package:wonder_flutter/app/common/values/app_colors.dart';
import 'package:wonder_flutter/app/data/models/adapter_models/profile_model.dart';
import 'package:wonder_flutter/app/data/models/adapter_models/walk_model.dart';
import 'package:wonder_flutter/app/modules/walk_track/controllers/location_tracker_mixin.dart';
import 'package:wonder_flutter/app/modules/walk_track/views/walk_reward_dialog.dart';
import 'package:wonder_flutter/app/routes/app_pages.dart';

class WalkTrackController extends GetxController with LocationTrackerMixin{
  static const Duration _checkInterval = Duration(seconds: 1);
  Completer<Set<Polyline>> getPolyLineCompleter = Completer<Set<Polyline>>();
  GoogleMapController? _mapController;
  bool isEvent = false;
  double zoomVal = Constants.initialZoomLevel;

  Timer? _timer;
  Stopwatch? _stopwatch;
  var polyLines = <Polyline>{}.obs;
  var timerStringValue = RxString('');
  var progress = 0.0.obs;

  late Duration minimumWalkTimeInMinutes;
  late Duration maximumWalkTimeInMinutes;
  late Walk targetWalk;
  late Color polylineColor;
  late LatLng _startLocation;
  late LatLng _destLocation;

  @override
  void onInit() {
    super.onInit();
    targetWalk = Get.arguments['walk'];
    isEvent = Get.arguments['isEvent'] ?? false;

    _startLocation = LatLng(targetWalk.coordinate.first.lat, targetWalk.coordinate.first.lng);
    _destLocation = LatLng(targetWalk.coordinate.last.lat, targetWalk.coordinate.last.lng);
    maximumWalkTimeInMinutes = GoogleMapUtils.calculateMaxWalkTimeInMinutes(targetWalk.distance);
    minimumWalkTimeInMinutes = GoogleMapUtils.calculateMinWalkTimeInMinutes(targetWalk.distance);
    timerStringValue.value = Converters.convertDurationToString(maximumWalkTimeInMinutes);

    polylineColor = isEvent ? AppColors.kPrimary100 : AppColors.kPrimary80;
  }

  @override
  void onReady() {
    super.onReady();
    _markPolyline();
    beginCheckingStartLocationReached();
  }

  @override
  void onClose() {
    _stopWalk();
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

  void beginCheckingStartLocationReached() {
    Utils.showDialog('출발지에 도착하면 자동으로 시작합니다.', title: '주의');
    startCheckDistanceLeftService(
        lat: _startLocation.latitude,
        lng: _startLocation.longitude,
        onDestinationReached: startWalk
    );
  }

  void _onEachTimerInterval(Timer timer) async {
    var elapsedTime = _stopwatch!.elapsed;
    var remainingTime = maximumWalkTimeInMinutes - elapsedTime;
    timerStringValue.value = Converters.convertDurationToString(remainingTime);
    if (remainingTime.inSeconds <= 0) {
      _onWalkFailed();
      return;
    }
  }

  void startWalk() {
    _timer = Timer.periodic(_checkInterval, _onEachTimerInterval);
    _stopwatch = Stopwatch();
    _stopwatch!.start();
    startCheckDistanceLeftService(
      lat: _destLocation.latitude,
      lng: _destLocation.longitude,
      onDestinationReached: _onWalkCompleted
    );
  }

  void _stopWalk() {
    _timer?.cancel();
    _stopwatch?.stop();
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

  @override
  void onLocationChanged(LocationData currentLocation) {  }

  void askUserWantToExit() async {
    await Utils.showChoiceDialog('정말 취소하시겠습니까?', title: '주의', onConfirm: () {
      Get.offAllNamed(Routes.HOME);
    });
  }
}
