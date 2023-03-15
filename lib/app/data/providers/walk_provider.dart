import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

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

  Future<List<Walk>> getWalks() async {
    // final response = await get('samplewalk/');
    final response = jsonDecode(await rootBundle.loadString('assets/walks.json'));
    if (response != null) {
      return response.map<Walk>((json) => Walk.fromJson(json)).toList();
    }
    return <Walk>[];
  }
}
