import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/providers/sign_up_response_provider.dart';
import 'package:wonder_flutter/app/data/http_provider.dart';
import 'package:wonder_flutter/app/routes/app_pages.dart';
import '../../../data/providers/nickname_check_provider.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailFormFieldKey = GlobalKey<FormFieldState>();
  final nicknameFormFieldKey = GlobalKey<FormFieldState>();
  final passwordFormFieldKey = GlobalKey<FormFieldState>();
  final passwordConfirmFormFieldKey = GlobalKey<FormFieldState>();
  final _addressController = Get.put(AddressController());

  final _nicknameCheckProvider = Get.put(NicknameCheckProvider());
  final _signUpProvider = Get.find<SignUpResponseProvider>();
  final _httProvider = Get.find<HttpProvider>();
  final emailTextController = TextEditingController();
  final nicknameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final passwordConfirmTextController = TextEditingController();
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

  String? validatePasswordConfirm(String? value) {
    if (value == null || value.length == 0) {
      return '비밀번호를 다시 입력해주세요';
    } else if (value != passwordTextController.text) {
      return '비밀번호와 일치하지 않습니다';
    }
    return null;
  }

  void onCheckPressed() async {
    if (nicknameFormFieldKey.currentState!.validate()) {
      try {
        var res = await _nicknameCheckProvider
            .getNickNameCheckResponse(nicknameTextController.text)
            .catchError((error) {
          if (error is String) {
            Get.snackbar('닉네임 중복 확인 실패', error);
          }
          return null;
        });

        if (res != null) {
          if (res.duplicated) {
            Get.snackbar('닉네임 중복', '다른 닉네임을 입력해주세요');
          } else {
            Get.snackbar('닉네임 사용 가능', '이 닉네임은 사용가능합니다'); //수정
          }
        }
      } on Exception catch (_) {
        Get.snackbar('닉네임 중복 확인 실패', '서버와 연결 실패');
      }
    }
  }

  void onSubmitPressed() async {
    if (formKey.currentState!.validate()) {
      try {
        var res = await _signUpProvider
            .postSignUpResponse(
                emailTextController.text,
                passwordTextController.text,
                nicknameTextController.text,
                _addressController.selected.value)
            .catchError((error) {
          if (error is String) {
            Get.snackbar('회원가입 실패', error);
          }
          return null;
        });

        if (res != null) {
          _httProvider.setToken(res.token);
          Get.offAllNamed(Routes.HOME);
        }
      } on Exception catch (_) {
        Get.snackbar('회원가입 실패', '서버와 연결 실패');
      }
    }
  }

  void increment() => count.value++;
}

class AddressController extends GetxController {
  final selected = "강동구".obs;
  final listType = [
    '강동구',
    '송파구',
    '강남구',
    '서초구',
    '관악구',
    '동작구',
    '금천구',
    '영등포구',
    '구로구',
    '양천구',
    '강서구',
    '은평구',
    '마포구',
    '서대문구',
    '종로구',
    '용산구',
    '중구',
    '성동구',
    '동대문구',
    '성북구',
    '강북구',
    '도봉구',
    '노원구',
    '중랑구',
    '광진구'
  ];
  void setSelected(String value) {
    selected.value = value;
  }
}
