import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/data/errors/api_error.dart';
import 'package:wonder_flutter/app/data/http_provider.dart';
import 'package:wonder_flutter/app/data/models/sign_in_data_model.dart';
import 'package:wonder_flutter/app/data/models/social_auth_required_fields_model.dart';
import 'package:wonder_flutter/app/routes/app_pages.dart';

class GoogleSocialAuthProvider extends GetLifeCycle {
  static final HttpProvider _httpProvider = Get.find<HttpProvider>();
  late GoogleSignIn _googleSignIn;

  @override
  void onInit() {
    super.onInit();
    _googleSignIn = GoogleSignIn(
      scopes: [
      'email',
      ],
      serverClientId: Constants.googleServerClientId,
    );
    _googleSignIn.isSignedIn().then((value) {
      if (value) {
        _googleSignIn.signOut();
      }
    });
  }

  Future<SignInData?> handleGoogleSignIn() async {
    String? errorMessage;
    try {
      var googleAccount = await _googleSignIn.signIn();
      var auth = await googleAccount?.authentication;
      // var accessToken = auth?.accessToken;
      var idToken = auth?.idToken;

      if (idToken != null && googleAccount != null) {

        var isEmailUsed = await isEmailAlreadyUsed(googleAccount.email);
        String? username = googleAccount.displayName;
        String? address;

        if (!isEmailUsed) {
          var userSignUpInfo = await Get.toNamed(Routes.REGISTER_SOCIAL, arguments: {
            'email': googleAccount.email,
            'name': googleAccount.displayName,
          });

          if (userSignUpInfo is SocialAuthRequiredFields) {
            username = userSignUpInfo.name;
            address = userSignUpInfo.address;
          } else {
            return Future.error('Google Sign In Failed. User SignUp Info is null.');
          }
        }
        return postGoogleSignIn(idToken, googleAccount.email, username ?? 'EMPTY', address ?? 'EMPTY');
      } else {
        return Future.error('Google Sign In Failed. Could not receive access token from google.');
      }
    } on ApiError catch (e) {
      errorMessage = e.message;
    } catch (error) {
      if (error is String) {
        errorMessage = error;
      }
      errorMessage ??= 'Google Sign In Failed.';
    }

    return Future.error(errorMessage);
  }

  Future<SignInData?> postGoogleSignIn(
      String idToken, String email, String name, String address) async {
    String? errorMessage;

    try {
      _httpProvider.setHeader('GOOGLE-TOKEN', idToken);
      var response = await _httpProvider.httpPost(Constants.googleSignInUrl, {
        'email': email,
        'name': name,
        'address': address
      });

      if (response.success) {
        return SignInData.fromJson(response.data);
      }

      errorMessage = response.message;

    } on ApiError catch (e) {
      errorMessage = e.message;
    } catch (error) {
      if (error is String) {
        errorMessage = error;
      }
      errorMessage ??= 'Google Sign In Failed.';
    } finally {
      _httpProvider.removeHeader('GOOGLE-TOKEN');
    }

    return Future.error(errorMessage);
  }

  Future<bool> isEmailAlreadyUsed(String email) async {
    try {
      var response = await _httpProvider.httpPost(Constants.checkDupMemberUrl, {
        'email': email,
      });
      if (response.success) {
        return response.data['registered'];
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
