import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/leaderboard_model.dart';

class LeaderboardProvider extends GetConnect {
  static LeaderboardProvider get to => Get.find();

  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return LeaderboardData.fromJson(map);
      if (map is List)
        return map.map((item) => LeaderboardData.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<LeaderboardData> getLeaderboardData() async {
    final response = jsonDecode(await rootBundle.loadString('assets/leaderboardData.json'));
    if (response != null) {
      return LeaderboardData.fromJson(response);
    } else {
      throw const HttpException('Failed to load profile');
    }
  }

  Future<Response<LeaderboardData>> postLeaderboardModel(
          LeaderboardData leaderboardmodel) async =>
      await post('leaderboardmodel', leaderboardmodel);
  Future<Response> deleteLeaderboardModel(int id) async =>
      await delete('leaderboardmodel/$id');
}
