import 'dart:async';

import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/common/util/google_map_utils.dart';

mixin LocationTrackerMixin on GetxController {
  static const _checkDistanceDuration = Duration(seconds: 1);
  double? destLat;
  double? destLng;
  void Function()? onDestinationReached;
  bool isDestReached = false;
  Timer? _timer;
  LocationData? currentLocation;

  @override
  void onReady() {
    super.onReady();

    Location location = Location();
    location.getLocation().then((value) => currentLocation = value);
    location.onLocationChanged.listen((LocationData currentLocation) {
      this.currentLocation = currentLocation;
      onLocationChanged(currentLocation);
    });
  }

  @override
  void onClose() {
    _stopCheckDistanceLeftService();
    super.onClose();
  }

  void onLocationChanged(LocationData currentLocation);

  void startCheckDistanceLeftService({
    required double lat,
    required double lng,
    required void Function() onDestinationReached,
  }) {
    destLat = lat;
    destLng = lng;
    this.onDestinationReached = onDestinationReached;
    isDestReached = false;
    if (_timer != null) {
      return;
    }
    _timer = Timer.periodic(_checkDistanceDuration, _checkDistance);
  }

  void _checkDistance(Timer timer) {
    if (destLat == null || destLng == null) {
      throw Exception('Destination is not set');
    }
    if (currentLocation == null || isDestReached) {
      return;
    }

    var distance = GoogleMapUtils.calculateDistance(destLat!, destLng!, currentLocation!.latitude!, currentLocation!.longitude!);
    // print('distance: $distance');
    if (distance <= Constants.distanceErrorMargin) {
      isDestReached = true;
      onDestinationReached!();
    }
  }

  void _stopCheckDistanceLeftService() {
    _timer?.cancel();
  }
}