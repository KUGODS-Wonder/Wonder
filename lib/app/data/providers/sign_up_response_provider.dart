import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/data/http_provider.dart';
import '../models/sign_up_data_model.dart';

class SignUpResponseProvider extends GetLifeCycle {
  static HttpProvider httpProvider = Get.find<HttpProvider>();
  @override
  void onInit() {
    super.onInit();
  }

  Future<SignUpData?> postSignUpResponse(
      String email, String password, String name, String address) async {
    var response = await httpProvider.httpPost(Constants.signUpUrl, {
      'email': email,
      'password': password,
      'name': name,
      'address': address
    });

    if (response.success) {
      try {
        return SignUpData.fromJson(response.data);
      } catch (e) {
        return Future.error('parsing signUpData failed.');
      }
    }
    return Future.error(response.message);
  }
}
