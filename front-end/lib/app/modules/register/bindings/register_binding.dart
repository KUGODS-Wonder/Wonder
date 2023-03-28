import 'package:get/get.dart';
import 'package:wonder_flutter/app/data/providers/sign_up_response_provider.dart';

import '../controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SignUpResponseProvider>(SignUpResponseProvider());

    Get.lazyPut<RegisterController>(
      () => RegisterController(),
    );
  }
}
