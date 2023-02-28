import 'package:flutter/cupertino.dart';
import 'package:wonder_flutter/app/common/storage/storage.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin{

  static const Duration _circularAnimationDuration = Duration(milliseconds: 500);

  late AnimationController circularAnimationController;
  late Tween<double> _tween;
  late Animation<double> _tweenAnim;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    await fetchProfile();
    _initializeCircularAnimation();
  }

  void onEditProfileClick() {
    Get.back();
  }

  void onFaqsClick() {
    Get.back();
  }

  void onLogoutClick() {
    Storage.clearStorage();
  }


  Future fetchProfile() async {
    await Future.delayed(const Duration(seconds: 1));
    _initializeCircularAnimation();
  }

  void _initializeCircularAnimation() {
    circularAnimationController = AnimationController(
      vsync: this,
      duration: _circularAnimationDuration,
    );
    _tween = Tween<double>(begin: 0, end: 1);
    _tweenAnim = _tween.animate(CurvedAnimation(parent: circularAnimationController, curve: Curves.easeIn));
  }
}
