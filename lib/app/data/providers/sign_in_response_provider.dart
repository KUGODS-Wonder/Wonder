import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/data/http_provider.dart';
import '../models/sign_in_response_model.dart';

class SignInResponseProvider extends GetLifeCycle {

  static HttpProvider httpProvider = Get.find<HttpProvider>();

  @override
  void onInit() {
    super.onInit();
  }

  Future<SignInResponse> postSignInResponse(
      String email, String password) async {
    var response = await httpProvider.httpPost(Constants.signInUrl, {
      'email': email,
      'password': password,
    });

    if (response is Map<String, dynamic>) {
      try {
        return SignInResponse.fromJson(response);
      } catch (e) {
        return Future.error(response);
      }
    }
    return Future.error(response);
  }
}