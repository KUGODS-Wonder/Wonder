import 'package:flutter/material.dart';
import 'package:wonder_flutter/app/common/values/app_colors.dart';
import 'package:wonder_flutter/app/data/enums/walk_type_enum.dart';

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
    '도시락 배달 봉사': const WalkThemeStyleModel(
      color: AppColors.kPrimary80,
      iconPath: 'assets/images/elderly_icon.png',
      eventCardPath: 'assets/images/event_cards/help_elderly_event_card.jpg',
      title: '도시락 배달 봉사',
      comment: '“OO복지 센터를 도와 거동이 힘든 어르신들께 도시락도 전달하고 산책도  같이 해봐요!”',
      associatedMedalImagePath: 'assets/images/medals/medal_elderly.png',
      walkType: WalkType.elderlyDeliverWalk,
    ),
    '유기견 산책': const WalkThemeStyleModel(
      color: AppColors.kPrimary80,
      iconPath: 'assets/images/dog_icon.png',
      eventCardPath: 'assets/images/event_cards/walk_dog_event_card.jpg',
      title: '유기견들과 산책',
      comment: '“OO유기견 센터를 도와서 성북구의 강아지들과 함께 산책하고 특수 보상도 가져가세요!”',
      associatedMedalImagePath: 'assets/images/medals/medal_dog.png',
      walkType: WalkType.dogWalk,
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
  final String title;
  final String comment;
  final String? associatedMedalImagePath;
  final WalkType walkType;

  const WalkThemeStyleModel({
    required this.color,
    required this.iconPath,
    this.eventCardPath = defaultEventCardPath,
    this.title = '',
    this.comment = '',
    this.walkType = WalkType.walk,
    this.associatedMedalImagePath,
  });
}