import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/values/app_colors.dart';
import 'package:wonder_flutter/app/common/values/styles/app_text_style.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.kPrimary100,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'WONDER',
                style: AppTextStyle.extraBoldStyle.copyWith(
                  fontSize: 48.0,
                  fontStyle: FontStyle.italic,
                  color: AppColors.white
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
