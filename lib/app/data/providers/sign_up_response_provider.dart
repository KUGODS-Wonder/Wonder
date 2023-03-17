import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/data/http_provider.dart';
import '../models/sign_up_response_model.dart';

class SignUpResponseProvider extends GetLifeCycle {
  static HttpProvider httpProvider = Get.find<HttpProvider>();
  @override
  void onInit() {
    super.onInit();
  }
  // void onInit() {
  //   httpClient.defaultDecoder = (map) {
  //     if (map is Map<String, dynamic>) return SignUpResponse.fromJson(map);
  //     if (map is List)
  //       return map.map((item) => SignUpResponse.fromJson(item)).toList();
  //   };
  //   httpClient.baseUrl = Constants.baseUrl;
  // }

//   Future<Response<SignUpResponse>> postSignUpResponse(
//     String email,
//     String password,
//     String name,
//     String address,
//   ) async {
//     return await post(Constants.signUpUrl, {
//       'email': email,
//       'password': password,
//       'name': name,
//       'address': address,
//     });
//   }
// }
  Future<SignUpResponse> postSignUpResponse(
      String email, String password, String name, String address) async {
    var response = await httpProvider.httpPost(Constants.signUpUrl, {
      'email': email,
      'password': password,
      'name': name,
      'address': address
    });

    if (response is Map<String, dynamic>) {
      try {
        return SignUpResponse.fromJson(response);
      } catch (e) {
        return Future.error(response);
      }
    }
    return Future.error(response);
  }
}
