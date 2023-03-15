import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wonder_flutter/app/data/http_provider.dart';
import 'package:wonder_flutter/app/routes/app_pages.dart';
import '../../../data/providers/sign_in_response_provider.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailFormFieldKey = GlobalKey<FormFieldState>();
  final passwordFormFieldKey = GlobalKey<FormFieldState>();
  final count = 0.obs;
  final _signInProvider = Get.find<SignInResponseProvider>();
  final _httProvider = Get.find<HttpProvider>();
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
    super.onClose();
  }

  void onGooglePressed() async {
    //Get.
    //구글 로그인창 요청
  }

  void onSubmitPressed() async {
    if (formKey.currentState!.validate()) {
      try{
        var res = await _signInProvider.postSignInResponse(emailController.text, passwordController.text);
        if (res.success) {
          // 토큰을 현재 HttpProvider 인스턴스에 저장.
          _httProvider.setToken(res.signInData!.token);
          // Home 화면으로 이동.
          Get.offAllNamed(Routes.HOME);
        } else {
          Get.snackbar('로그인 실패', res.message);
        }
      } on Exception catch (_) {
        Get.snackbar('로그인 실패', '서버와 연결 실패');
      }
    }
  }

//snackbar로 error 메시지

  void navigateToRegister() {
    Get.toNamed('/register');
  }

  void increment() => count.value++;
}