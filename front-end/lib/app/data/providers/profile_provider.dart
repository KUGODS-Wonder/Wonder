import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/data/errors/api_error.dart';
import 'package:wonder_flutter/app/data/models/profile_data_model.dart';

import '../http_provider.dart';
import '../models/adapter_models/profile_model.dart';

class ProfileProvider extends GetConnect {
  static ProfileProvider get to => Get.find();
  static final HttpProvider _httpProvider = Get.find<HttpProvider>();

  @override
  void onInit() {
  }

  Future<Profile> getProfile() async {
    String? errorMessage;

    try {
      var response = await _httpProvider.httpGet(Constants.profileUrl);
      if (response.success) {
        var profileData = ProfileData.fromJson(response.data);
        var profile = Profile.fromData(profileData);

        return profile;
      } else {
        errorMessage = response.message.isNotEmpty ? response.message : null;
      }
    } on ApiError catch (ae) {
      errorMessage = ae.message;
    } catch (e) {
      errorMessage = 'Failed to load profile';
    }

    return Future.error(errorMessage ?? 'Failed to load profile');
  }
}
