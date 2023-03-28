import 'package:get/get.dart';
import 'package:wonder_flutter/app/data/providers/google_social_auth_provider.dart';
import 'package:wonder_flutter/app/data/providers/sign_in_response_provider.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SignInResponseProvider>(SignInResponseProvider());
    Get.put<GoogleSocialAuthProvider>(GoogleSocialAuthProvider());
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}
