import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wonder_flutter/app/data/models/social_auth_required_fields_model.dart';
import 'package:wonder_flutter/app/modules/register/controllers/address_control_mixin.dart';

class RegisterSocialController extends GetxController with AddressControlMixin {
  final formKey = GlobalKey<FormState>();
  final nicknameFormFieldKey = GlobalKey<FormFieldState>();
  final checkBoxFormFieldKey = GlobalKey<FormFieldState>();
  final nicknameTextController = TextEditingController();
  final isCheckBoxChecked = false.obs;

  late String email;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments['email'] == null) {
      throw Exception('email is null. Are you trying to navigate to this page from pages other than register page?');
    }
    email = Get.arguments['email'];
  }

  @override
  void onReady() {
    super.onReady();
    nicknameTextController.text = Get.arguments['name'];
  }

  @override
  void onClose() {
    nicknameTextController.dispose();
    super.onClose();
  }

  String? validateNickname(String? value) {
    if (value == null || value.isEmpty) {
      return '닉네임을 입력해주세요';
    }
    return null;
  }

  String? validateCheckBox(bool? value) {
    if (value == null || value == false) {
      return '약관에 동의해주세요';
    }
    return null;
  }

  Future<bool> onPop() async {
    Get.back();
    return false;
  }

  void submitRegister() {
    if (formKey.currentState!.validate()) {
      Get.back(result: SocialAuthRequiredFields(
          email, nicknameTextController.text, selectedAddressItem.value));
    }
  }

  void onSubmitPressed() {

  }

  void onTapTermsAndService() {

  }
}
