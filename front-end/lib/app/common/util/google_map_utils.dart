import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/data/models/coordinate_model.dart';

abstract class GoogleMapUtils {


  static Future<LatLng> getScreenLatLng(GoogleMapController controller, {int? x, int? y}) async {
    ScreenCoordinate screenCoordinate = ScreenCoordinate(x: x ?? 0, y: y ?? 0);
    return controller.getLatLng(screenCoordinate);
  }

  static double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 - cos((lat2 - lat1) * p)/2 +
        cos(lat1 * p) * cos(lat2 * p) *
            (1 - cos((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  static calculateDistanceFromLatLng(LatLng destLatLng, LatLng currentLatLng) {
    return calculateDistance(currentLatLng.latitude, currentLatLng.longitude, destLatLng.latitude, destLatLng.longitude);
  }

  static Duration calculateMaxWalkTimeInMinutes(int meters) {
    return Duration(minutes: meters ~/ Constants.minWalkSpeedMeterPerMinute);
  }

  static Duration calculateMinWalkTimeInMinutes(int meters) {
    return Duration(minutes: meters ~/ Constants.maxWalkSpeedMeterPerMinute);
  }

  static double calculateTotalDistance(List<LatLng> points) {
    double totalDistance = 0;
    for (int i = 0; i < points.length - 1; i++) {
      totalDistance += calculateDistance(points[i].latitude, points[i].longitude, points[i + 1].latitude, points[i + 1].longitude);
    }
    return totalDistance;
  }

  static double calculateTotalDistanceByCoordinate(List<Coordinate> points) {
    var lst = points.map((e) => LatLng(e.lat, e.lng)).toList();
    return calculateTotalDistance(lst);
  }

}