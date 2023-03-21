import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/data/http_provider.dart';
import '../models/sign_in_data_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  late GoogleSignIn _googleSignIn;

  @override
  void onInit() {
    super.onInit();
    _googleSignIn = GoogleSignIn();
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

  Future<void> handleSignIn() async {
    try {
      var x = await _googleSignIn.signIn();
      print(x);
    } catch (error) {
      print(error);
    }
  }
}
