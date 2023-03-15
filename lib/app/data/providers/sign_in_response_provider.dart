import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/constants.dart';

import '../models/sign_in_response_model.dart';

class SignInResponseProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return SignInResponse.fromJson(map);
      if (map is List)
        return map.map((item) => SignInResponse.fromJson(item)).toList();
    };
    httpClient.baseUrl = Constants.baseUrl;
  }

  Future<Response<SignInResponse>> postSignInResponse(
      String email, String password) async {
    return await post(Constants.signInUrl, {
      'email': email,
      'password': password,
    });
  }
}
