import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wonder_flutter/app/data/models/sign_in_response_model.dart';
import '../../../data/providers/sign_in_response_provider.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailFormFieldKey = GlobalKey<FormFieldState>();
  final passwordFormFieldKey = GlobalKey<FormFieldState>();
  final count = 0.obs;
  final _provider = Get.find<SignInResponseProvider>();
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
      var z = await _provider.postSignInResponse(emailController.text, passwordController.text);
      SignInResponse x = z.body!;
      var isRegistered = x.errorCode;
      if (isRegistered == 0) //회원가입되어 있는 사람
          {
        //다음페이지로 변경해야 됨
      } else {
        Get.snackbar('Snackbar', '로그인 실패');
      }
      //x.signInData.token;
    }
  }

//snackbar로 error 메시지

  void navigateToRegister() {
    Get.toNamed('/register');
  }

  void increment() => count.value++;
}