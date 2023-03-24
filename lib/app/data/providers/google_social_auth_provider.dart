import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/data/http_provider.dart';
import 'package:wonder_flutter/app/data/models/sign_in_data_model.dart';

class GoogleSocialAuthProvider extends GetLifeCycle {
  static final HttpProvider _httpProvider = Get.find<HttpProvider>();
  late GoogleSignIn _googleSignIn;

  @override
  void onInit() {
    super.onInit();
    _googleSignIn = GoogleSignIn();
  }

  Future<void> handleGoogleSignIn() async {
    try {
      var googleAccount = await _googleSignIn.signIn();
      var auth = await googleAccount?.authentication;
      var accessToken = auth?.accessToken;

      // print(auth?.accessToken);

      if (accessToken != null && googleAccount != null) {
        // TODO: 추가로 ADDRESS를 받는 로직과, display name이 null 일때 이름도 받는 로직 필요.
        postGoogleSignIn(accessToken, googleAccount.email,
            googleAccount.displayName ?? 'NO NAME', 'address');
      } else {
        return Future.error('Google Sign In Failed');
      }
    } catch (error) {
      String? errorMessage;
      if (error is String) {
        errorMessage = error;
      }
      errorMessage ??= 'Google Sign In Failed';
      return Future.error(errorMessage);
    }
  }

  Future<SignInData?> postGoogleSignIn(
      String accessToken, String email, String name, String address) async {
    String? errorMessage;

    _httpProvider.setHeader('GOOGLE-TOKEN', accessToken);
    var response = await _httpProvider.httpPost(Constants.googleSignInUrl, {
      'email': email,
      'name': name,
      'address': address,
    });

    if (response.success) {
      try {
        _httpProvider.removeHeader('GOOGLE-TOKEN');
        return SignInData.fromJson(response.data);
      } catch (e) {
        errorMessage = 'parsing signInData failed.';
      }
    }
    errorMessage = response.message;
    _httpProvider.removeHeader('GOOGLE-TOKEN');
    return Future.error(errorMessage);
  }
}
