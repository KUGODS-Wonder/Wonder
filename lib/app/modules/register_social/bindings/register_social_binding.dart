import 'package:get/get.dart';

import '../controllers/register_social_controller.dart';

class RegisterSocialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterSocialController>(
      () => RegisterSocialController(),
    );
  }
}
