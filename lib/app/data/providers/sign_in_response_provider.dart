import 'dart:convert';

import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:http/http.dart' as http;

import '../models/sign_in_response_model.dart';

class SignInResponseProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return SignInResponse.fromJson(map);
      if (map is List) {
        return map.map((item) => SignInResponse.fromJson(item)).toList();
      }
    };
    httpClient.baseUrl = Constants.baseUrl + Constants.signInUrl;
    httpClient.defaultContentType = 'application/json';
  }

  Future<Response<SignInResponse>> postSignInResponse(
      String email, String password) async {

    var res = await http.post(
      Uri.https(Constants.baseUrl, Constants.signInUrl), body: jsonEncode({
      'email': email,
      'password': password,
    }),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    var ret = SignInResponse.fromJson(jsonDecode(res.body));
    return await post(
      httpClient.baseUrl,
      {
      'email': email,
      'password': password,
      },
      decoder: (data) => SignInResponse.fromJson(jsonDecode(data)),
      contentType: httpClient.defaultContentType
    );
  }
}