import 'package:get/get.dart';

import '../models/leaderboard_model.dart';

class LeaderboardModelProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return LeaderboardData.fromJson(map);
      if (map is List)
        return map.map((item) => LeaderboardData.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<LeaderboardData?> getLeaderboardModel(int id) async {
    final response = await get('leaderboardmodel/$id');
    return response.body;
  }

  Future<Response<LeaderboardData>> postLeaderboardModel(
          LeaderboardData leaderboardmodel) async =>
      await post('leaderboardmodel', leaderboardmodel);
  Future<Response> deleteLeaderboardModel(int id) async =>
      await delete('leaderboardmodel/$id');
}
