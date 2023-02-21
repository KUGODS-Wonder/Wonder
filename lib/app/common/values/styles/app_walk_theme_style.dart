import 'package:flutter/material.dart';
import 'package:wonder_flutter/app/common/values/app_colors.dart';

abstract class AppWalkThemeStyle {
  static const defaultWalkThemeStyle = WalkThemeStyleModel(
    color: AppColors.defaultWalkColor,
    path: 'assets/images/walk_theme_default.png',
  );

  static final Map<String, WalkThemeStyleModel> _dict = {
    '일반 테마': defaultWalkThemeStyle,
    '동네 맛집 투어': const WalkThemeStyleModel(
      color: AppColors.foodTourColor,
      path: 'assets/images/walk_theme_food_tour.png',
    ),
  };

  static WalkThemeStyleModel getStyle(String theme) {
    return _dict[theme] ?? defaultWalkThemeStyle;
  }
}

class WalkThemeStyleModel {
  final Color color;
  final String path;

  const WalkThemeStyleModel({required this.color, required this.path});
}