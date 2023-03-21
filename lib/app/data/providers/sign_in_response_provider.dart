import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/data/http_provider.dart';
import '../models/sign_in_data_model.dart';

class SignInResponseProvider extends GetLifeCycle {
  static HttpProvider httpProvider = Get.find<HttpProvider>();

  @override
  void onInit() {
    super.onInit();
  }

  Future<SignInData?> postSignInResponse(
    String email,
    String password,
  ) async {
    var response = await httpProvider.httpPost(Constants.signInUrl, {
      'email': email,
      'password': password,
    });

    if (response.success) {
      try {
        return SignInData.fromJson(response.data);
      } catch (e) {
        return Future.error('parsing signInData failed.');
      }
    }
    return Future.error(response.message);
  }
}

class GoogleSignInResponseProvider extends GetLifeCycle {
  static HttpProvider httpProvider = Get.find<HttpProvider>();

  @override
  void onInit() {
    super.onInit();
  }

  Future<GoogleSignInData?> postGoogleSignInResponse() async {
    var response = await httpProvider.httpPost(Constants.googleSignInUrl, {});
    if (response.success) {
      try {
        return GoogleSignInData.fromJson(response.data);
      } catch (e) {
        return Future.error('parsing signInData failed.');
      }
    }
    return Future.error(response.message);
  }
}
