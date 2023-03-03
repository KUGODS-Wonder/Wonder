import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/constants.dart';

import '../models/sign_up_response_model.dart';

class SignUpResponseProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return SignUpResponse.fromJson(map);
      if (map is List)
        return map.map((item) => SignUpResponse.fromJson(item)).toList();
    };
    httpClient.baseUrl = Constants.baseUrl;
  }

  Future<Response<SignUpResponse>> postSignUpResponse(
      String email,
      String password,
      String name,
      String address,
      ) async {
    return await post(Constants.signUpUrl, {
      'email': email,
      'password': password,
      'name': name,
      'address': address,
    });
  }
}
