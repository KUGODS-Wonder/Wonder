import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/data/http_provider.dart';
import 'package:wonder_flutter/app/data/models/sign_in_data_model.dart';
import 'package:wonder_flutter/app/routes/app_pages.dart';

class GoogleSocialAuthProvider extends GetLifeCycle {
  static final HttpProvider _httpProvider = Get.find<HttpProvider>();
  late GoogleSignIn _googleSignIn;

  @override
  void onInit() {
    super.onInit();
    _googleSignIn = GoogleSignIn();
    _googleSignIn.isSignedIn().then((value) {
      if (value) {
        _googleSignIn.signOut();
      }
    });
  }

  Future<void> handleGoogleSignIn() async {
    try {
      var googleAccount = await _googleSignIn.signIn();
      var auth = await googleAccount?.authentication;
      var accessToken = auth?.accessToken;

      if (accessToken != null && googleAccount != null) {

        var isEmailUsed = await isEmailAlreadyUsed(googleAccount.email);
        String? username = googleAccount.displayName;
        String? address;

        if (!isEmailUsed) {
          var userSignUpInfo = await Get.toNamed(Routes.REGISTER_SOCIAL, arguments: {
            'email': googleAccount.email,
            'name': googleAccount.displayName,
          });

          if (userSignUpInfo is SocialAuthRequiredAdditionalFields) {
            username = userSignUpInfo.name;
            address = userSignUpInfo.address;
          } else {
            return Future.error('Google Sign In Failed. User SignUp Info is null.');
          }
        }
        var signInData = await postGoogleSignIn(accessToken, googleAccount.email, username ?? '', address ?? '');
        if (signInData != null) {
          _httpProvider.setToken(signInData.token);
          Get.offAllNamed(Routes.HOME);
        } else {
          return Future.error('Google Sign In Failed. Could not receive sign in data from server.');
        }
      } else {
        return Future.error('Google Sign In Failed. Could not receive access token from google.');
      }
    } catch (error) {
      String? errorMessage;
      if (error is String) {
        errorMessage = error;
      }
      errorMessage ??= 'Google Sign In Failed.';
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

  Future<bool> isEmailAlreadyUsed(String email) async {
    try {
      var response = await _httpProvider.httpPost(Constants.checkDupMemberUrl, {
        'email': email,
      });
      if (response.success) {
        return response.data['isRegistered'];
      } else {
        return false;
      }
    } catch (error) {
      String? errorMessage;
      if (error is String) {
        errorMessage = error;
      }
      errorMessage ??= 'Email check failed';
      return Future.error(errorMessage);
    }
  }
}

class SocialAuthRequiredAdditionalFields {
  String email;
  String name;
  String address;

  SocialAuthRequiredAdditionalFields(this.email, this.name, this.address);
}
