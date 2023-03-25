import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wonder_flutter/app/data/http_provider.dart';
import 'package:wonder_flutter/app/data/providers/google_social_auth_provider.dart';
import 'package:wonder_flutter/app/routes/app_pages.dart';
import '../../../data/providers/sign_in_response_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

Future<void> getGoogleLogin() {
  return http.get(Uri.parse('http://ku-wonder.shop/login/getGoogleAuthUrl'));
}

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailFormFieldKey = GlobalKey<FormFieldState>();
  final passwordFormFieldKey = GlobalKey<FormFieldState>();
  final _signInProvider = Get.find<SignInResponseProvider>();
  final _httProvider = Get.find<HttpProvider>();
  final _googleSignInProvider = Get.find<GoogleSocialAuthProvider>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void onGooglePressed() async {
    _googleSignInProvider.handleGoogleSignIn();
    // try {
    //   getGoogleLogin(); //구글 로그인창 요청
    //   var res = await _googleSignInProvider
    //       .postGoogleSignInResponse()
    //       .catchError((error) {
    //     if (error is String) {
    //       Get.snackbar('로그인 실패', error);
    //     }
    //     return null;
    //   });
    //   if (res != null) {
    //     if (res.alreadyRegistered == false) {
    //       _httProvider.setToken(res.googleToken);
    //       Get.to(GoogleRegisterView());
    //     }
    //     _httProvider.setToken(res.googleToken);
    //     Get.offAllNamed(Routes.HOME);
    //   }
    // } on Exception catch (_) {
    //   Get.snackbar('로그인 실패', '서버와 연결 실패');
    // }
  }

  void onSubmitPressed() async {
    if (formKey.currentState!.validate()) {
      try {
        var res = await _signInProvider
            .postSignInResponse(emailController.text, passwordController.text)
            .catchError((error) {
          if (error is String) {
            Get.snackbar('로그인 실패', error);
          }
          return null;
        });
        if (res != null) {
          // 토큰을 현재 HttpProvider 인스턴스에 저장.
          _httProvider.setToken(res.token);
          // Home 화면으로 이동.
          Get.offAllNamed(Routes.HOME);
        }
      } on Exception catch (_) {
        Get.snackbar('로그인 실패', '서버와 연결 실패');
      }
    }
  }

  void navigateToRegister() {
    Get.toNamed(Routes.REGISTER);
  }
}
