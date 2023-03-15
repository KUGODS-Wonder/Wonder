import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../data/providers/sign_in_response_provider.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  final formKey = GlobalKey<FormState>();
  final emailFormFieldKey = GlobalKey<FormFieldState>();
  final passwordFormFieldKey = GlobalKey<FormFieldState>();
  final count = 0.obs;
  //final _provider = SignInResponseProvider();
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
      var x = (await SignInResponseProvider().postSignInResponse(
              emailController.text, passwordController.text))
          .body!;
      var isRegistered = x.success;
      if (isRegistered == true) //회원가입되어 있는 사람
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

// class Authcontroller {
//   TextEditingController addressController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   Future loginUser() async {
//     final _url = 'http://ku-wonder.shop/api/v1/auth/signin';
//     var response = await http.post(Uri.parse(_url),
//         body: jsonEncode({
//           "username": addressController.text,
//           "password": passwordController.text,
//         }));
//     if (response.statusCode == 200) {
//       var loginArr = json.decode(response.body);
//       print(loginArr['token']);
//     } else {
//       print(response.body);
//     }
//   }
// }

