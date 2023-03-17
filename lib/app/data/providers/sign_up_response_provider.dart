import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/data/errors/api_error.dart';
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
    try {
      var response = await httpProvider.httpPost(Constants.signUpUrl, {
        'email': email,
        'password': password,
        'name': name,
        'address': address
      });

      if (response.success) {
        return SignUpData.fromJson(response.data);
      } else {
        return Future.error(response.message);
      }
    } on ApiError catch (ae) {
      return Future.error(ae.message);
    } catch (e) {
      return Future.error('parsing signUpData failed.');
    }
  }
}
