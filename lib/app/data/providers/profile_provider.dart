import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/profile_model.dart';

class ProfileProvider extends GetConnect {
  static ProfileProvider get to => Get.find();

  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Profile.fromJson(map);
      if (map is List)
        return map.map((item) => Profile.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Profile> getProfile() async {
    final response = jsonDecode(await rootBundle.loadString('assets/profile.json'));
    if (response != null) {
      return Profile.fromJson(response);
    } else {
      throw const HttpException('Failed to load profile');
    }
  }

  Future<Response<Profile>> postProfile(Profile profile) async =>
      await post('profile', profile);
  Future<Response> deleteProfile(int id) async => await delete('profile/$id');
}
