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
        'latitude': 127.00,
        'longitude': 37.00,
        'range': 100
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

  Future<Walk?> getWalk(int walkId, {String path = 'assets/walks.json'}) async {
    final response = jsonDecode(await rootBundle.loadString(path));
    if (response != null) {
      var lst = response.map<Walk>((json) => Walk.fromJson(json)).toList();

      for (var walk in lst) {
        if (walk.id == walkId) {
          return walk;
        }
      }
    }
    return null;
  }
}
