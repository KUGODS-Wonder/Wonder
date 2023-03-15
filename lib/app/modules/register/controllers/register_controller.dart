import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/providers/sign_up_response_provider.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailFormFieldKey = GlobalKey<FormFieldState>();
  final nicknameFormFieldKey = GlobalKey<FormFieldState>();
  final passwordFormFieldKey = GlobalKey<FormFieldState>();
  final addressFormFieldKey = GlobalKey<FormFieldState>();
  final passwordConfirmFormFieldKey = GlobalKey<FormFieldState>();

  final addressTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final nicknameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final passwordConfirmTextController = TextEditingController();
  final _provider = SignUpResponseProvider();
  final count = 0.obs;
  final RxInt selected = 0.obs;
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
    if (value == null || value.length == 0) {
      return '이메일을 입력해주세요';
    }
    if (!GetUtils.isEmail(value)) {
      return '올바른 이메일 주소를 입력해주세요';
    }
    return null;
  }

  String? validateNickname(String? value) {
    if (value == null || value.length == 0) {
      return '닉네임을 입력해주세요';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.length == 0) {
      return '비밀번호를 입력해주세요';
    } else if (value.length < 8 || value.length > 20) {
      return '비밀번호는 8자리에서 20자리로 작성해주세요';
    }
    return null;
  }

  String? validateAdress(String? value) {
    if (value == null || value.length == 0) {
      return '주소를 입력해주세요';
    }
    return null;
  }

  String? validatePasswordConfirm(String? value) {
    if (value == null || value.length == 0) {
      return '비밀번호를 다시 입력해주세요';
    } else if (value != passwordTextController.text) {
      return '비밀번호와 일치하지 않습니다';
    }
    return null;
  }

  void onSubmitPressed() async {
    if (formKey.currentState!.validate()) {
      final x = (await _provider.postSignUpResponse(
              emailTextController.text,
              passwordTextController.text,
              nicknameTextController.text,
              addressTextController.text))
          .body!;
      final isRegisterSuccess = x.success; //성공 여부
      if (isRegisterSuccess == true) //회원가입 성공
      {
      } else {
        Get.snackbar('Snackbar', '회원가입 실패');
      }
      //x.signInData.token;
    }
  }

  void increment() => count.value++;
}
