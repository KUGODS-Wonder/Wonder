import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailFormFieldKey = GlobalKey<FormFieldState>();
  final passwordFormFieldKey = GlobalKey<FormFieldState>();
  final passwordConfirmFormFieldKey = GlobalKey<FormFieldState>();

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final passwordConfirmTextController = TextEditingController();

  final count = 0.obs;
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

  String? validateEmail(String? value) {
    if (value == null) {
      return '이메일을 입력해주세요';
    }
    if (!GetUtils.isEmail(value)) {
      return '올바른 이메일 주소를 입력해주세요';
    }
    return null;
  }

  void onSubmitPressed() {
    if (formKey.currentState!.validate()) {
      print('회원가입');
      // 문제 없으니 회원가입 정보를 서버로 보내는 로직 여기에 넣기
    }
  }

  void increment() => count.value++;
}
