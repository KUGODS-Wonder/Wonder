import 'package:get/get.dart';
import 'package:wonder_flutter/app/data/models/adapter_models/profile_model.dart';
import 'package:wonder_flutter/app/data/providers/profile_provider.dart';

class ProfileStateProvider extends GetLifeCycle {
  static ProfileStateProvider get to => Get.find();

  Profile? _profile;

  Future<Profile> get profile async {
    _profile ??= await ProfileProvider.to.getProfile();
    return _profile!;
  }

  Future<Profile> refreshProfile() async {
    _profile = await ProfileProvider.to.getProfile();
    return _profile!;
  }

  @override
  void onInit() {
    super.onInit();
    Get.put(ProfileProvider());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}