import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/data/enums/walk_type_enum.dart';
import 'package:wonder_flutter/app/data/errors/api_error.dart';
import 'package:wonder_flutter/app/data/http_provider.dart';
import 'package:wonder_flutter/app/data/models/walk_data_model.dart';

import '../models/adapter_models/walk_model.dart';

class WalkProvider extends GetConnect {
  static WalkProvider get to => Get.find();

  static HttpProvider httpProvider = Get.find<HttpProvider>();

  @override
  void onInit() {
  }

  Future<List<Walk>> getWalks(double lat, double lng, double radius) async {

    try {
      var response = await httpProvider.httpGet(Constants.walkUrl, body: {
        'latitude': lat,
        'longitude': lng,
        'range': radius
      });
      if (response.success) {
        var walkDataList = response.data.map<WalkData>(
                (json) => WalkData.fromJson(json)).toList();
        var walkList = walkDataList.map<Walk>((data) => Walk.fromData(data)).toList();

        return walkList;
      } else {
        return Future.error(response.message);
      }
    } on ApiError catch (ae) {
      return Future.error(ae.message);
    } catch (e) {
      return Future.error('parsing walkData failed.');
    }
  }

  Future<List<Walk>> getWalksLocal({String path = 'assets/walks.json'}) async {
    final response = jsonDecode(await rootBundle.loadString(path));
    if (response != null) {
      return response.map<Walk>((json) => Walk.fromJson(json)).toList();
    }
    return <Walk>[];
  }

  Future<List<Walk>> getWalksByType(WalkType walkEnum) async {

    if (walkEnum == WalkType.elderlyDeliverWalk) {
      return getWalksLocal(path: 'assets/elderly_deliver_walks.json');
    } else {
      return getWalksLocal(path: 'assets/dog_walks.json');
    }
  }

  Future<Walk?> getWalk(int walkId, {double lat = 127.0, double lng = 37.0, String path = 'assets/walks.json'}) async {
    try {
      var response = await httpProvider.httpGet('${Constants.walkUrl}/$walkId', body: {
        'latitude': lat,
        'longitude': lng
      });
      if (response.success) {
        var walkData = WalkData.fromJson(response.data);
        var walk = Walk.fromData(walkData);

        return walk;
      } else {
        return Future.error(response.message);
      }
    } on ApiError catch (ae) {
      return Future.error(ae.message);
    } catch (e) {
      return Future.error('parsing walkData failed.');
    }
  }

  Future<bool> informServerWalkCompleted(int walkId, int seconds) async {
    try {
      var response = await httpProvider.httpPost(Constants.walkCompletionUrl, {
        'walkId': walkId,
        'timeRecord': seconds,
      });
      if (response.success) {
        return true;
      } else {
        return Future.error(response.message);
      }
    } on ApiError catch (ae) {
      return Future.error(ae.message);
    } catch (e) {
      return Future.error('failed to communicate with server.');
    }
  }
}
