import 'package:get/get.dart';

import '../models/profile_model.dart';

class ProfileProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Profile.fromJson(map);
      if (map is List)
        return map.map((item) => Profile.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Profile?> getProfile(int id) async {
    final response = await get('profile/$id');
    return response.body;
  }

  Future<Response<Profile>> postProfile(Profile profile) async =>
      await post('profile', profile);
  Future<Response> deleteProfile(int id) async => await delete('profile/$id');
}
