import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wonder_flutter/app/data/enums/walk_type_enum.dart';

import '../models/walk_model.dart';

class WalkProvider extends GetConnect {
  static WalkProvider get to => Get.find();

  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Walk.fromJson(map);
      if (map is List) {
        return map.map((item) => Walk.fromJson(item)).toList();
      }
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<List<Walk>> getWalks({String path = 'assets/walks.json'}) async {
    // final response = await get('samplewalk/');
    final response = jsonDecode(await rootBundle.loadString(path));
    if (response != null) {
      return response.map<Walk>((json) => Walk.fromJson(json)).toList();
    }
    return <Walk>[];
  }

  Future<List<Walk>> getWalksByType(WalkType walkEnum) async {

    if (walkEnum == WalkType.elderlyDeliverWalk) {
      return getWalks(path: 'assets/elderly_deliver_walks.json');
    } else if (walkEnum == WalkType.dogWalk) {
      return getWalks(path: 'assets/dog_walks.json');
    } else {
      return getWalks();
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
