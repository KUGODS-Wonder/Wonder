import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/data/errors/api_error.dart';
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
    try {
      var response = await httpProvider.httpPost(Constants.signInUrl, {
        'email': email,
        'password': password,
      });
      if (response.success) {
        return SignInData.fromJson(response.data);
      } else {
        return Future.error(response.message);
      }
    } on ApiError catch (ae) {
      return Future.error(ae.message);
    } catch (e) {
      return Future.error('parsing signInData failed.');
    }
  }
}