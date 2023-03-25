import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wonder_flutter/app/modules/register/controllers/address_control_mixin.dart';

class RegisterSocialController extends GetxController with AddressControlMixin {
  final formKey = GlobalKey<FormState>();
  final nicknameFormFieldKey = GlobalKey<FormFieldState>();
  final nicknameTextController = TextEditingController();
  final isCheckBoxChecked = false.obs;

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

  String? validateNickname(String? value) {
    if (value == null || value.isEmpty) {
      return '닉네임을 입력해주세요';
    }
    return null;
  }

  Future<bool> onPop() {
    Get.back();
    return Future.value(false);
  }
}
