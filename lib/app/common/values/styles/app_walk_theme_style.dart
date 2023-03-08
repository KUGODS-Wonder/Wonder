import 'package:flutter/material.dart';
import 'package:wonder_flutter/app/common/values/app_colors.dart';

abstract class AppWalkThemeStyle {
  static const defaultWalkThemeStyle = WalkThemeStyleModel(
    color: AppColors.defaultWalkColor,
    iconPath: 'assets/images/walk_theme_default.png',
  );

  static final Map<String, WalkThemeStyleModel> _dict = {
    '일반 테마': defaultWalkThemeStyle,
    '동네 맛집 투어': const WalkThemeStyleModel(
      color: AppColors.foodTourColor,
      iconPath: 'assets/images/walk_theme_food_tour.png',
    ),
    '도시락 전달': const WalkThemeStyleModel(
      color: AppColors.kPrimary80,
      iconPath: 'assets/images/elderly_icon.png',
      eventCardPath: 'assets/images/event_cards/help_elderly_event_card.png',
    ),
    '유기견 산책': const WalkThemeStyleModel(
      color: AppColors.kPrimary80,
      iconPath: 'assets/images/dog_icon.png',
      eventCardPath: 'assets/images/event_cards/walk_dog_event_card.png',
    ),
  };

  static WalkThemeStyleModel getStyle(String theme) {
    return _dict[theme] ?? defaultWalkThemeStyle;
  }
}

class WalkThemeStyleModel {
  static const defaultEventCardPath = 'assets/images/default_event_card.png';

  final Color color;
  final String iconPath;
  final String eventCardPath;

  const WalkThemeStyleModel({
    required this.color,
    required this.iconPath,
    this.eventCardPath = defaultEventCardPath,
  });
}