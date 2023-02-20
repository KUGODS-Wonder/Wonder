import 'package:flutter/material.dart';
import 'package:wonder_flutter/app/common/util/exports.dart';

abstract class AppWalkTagStyle {

  static const defaultWalkTagStyle = WalkTagStyleModel(
      backgroundColor: AppColors.kPrimary60,
      fontColor: AppColors.kPrimary100
  );

  static final Map<String, WalkTagStyleModel> _dict = {
    '칼로리 소모': const WalkTagStyleModel(
      backgroundColor: AppColors.kPrimary60,
      fontColor: AppColors.kPrimary100
    ),
    '반려견 산책': const WalkTagStyleModel(
      backgroundColor: AppColors.reward60,
      fontColor: AppColors.reward100
    ),
  };

  static WalkTagStyleModel getStyle(String tag) {
    return _dict[tag] ?? defaultWalkTagStyle;
  }
}

class WalkTagStyleModel {
  final Color backgroundColor;
  final Color fontColor;

  const WalkTagStyleModel({required this.backgroundColor, required this.fontColor});
}