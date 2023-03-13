import 'package:flutter/material.dart';
import 'package:wonder_flutter/app/common/values/app_colors.dart';

import 'dimens.dart';

abstract class AppTextStyle {
  /// NAME         SIZE  WEIGHT  SPACING
  /// headline1    96.0  light   -1.5
  static final TextStyle headline1 = lightStyle.copyWith(
    fontSize: Dimens.fontSize96,
    letterSpacing: -1.5,
  );

  /// NAME         SIZE  WEIGHT  SPACING
  /// headline2    60.0  light   -0.5
  static final TextStyle headline2 = lightStyle.copyWith(
    fontSize: Dimens.fontSize60,
    letterSpacing: -0.5,
  );

  /// NAME         SIZE  WEIGHT  SPACING
  /// headline3    48.0  regular  0.0
  static final TextStyle headline3 = regularStyle.copyWith(
    fontSize: Dimens.fontSize48,
    letterSpacing: 0,
  );

  /// NAME         SIZE  WEIGHT  SPACING
  /// headline4    34.0  regular  0.25
  static final TextStyle headline4 = regularStyle.copyWith(
    fontSize: Dimens.fontSize34,
    letterSpacing: 0.25,
  );

  /// NAME         SIZE  WEIGHT  SPACING
  /// headline5    24.0  regular  0.0
  static final TextStyle headline5 = regularStyle.copyWith(
    fontSize: Dimens.fontSize24,
    letterSpacing: 0,
  );

  /// NAME         SIZE  WEIGHT  SPACING
  /// headline6    20.0  medium   0.15
  static final TextStyle headline6 = mediumStyle.copyWith(
    fontSize: Dimens.fontSize20,
    letterSpacing: 0.15,
  );

  /// NAME         SIZE  WEIGHT  SPACING
  /// subtitle1    16.0  regular  0.15
  static final TextStyle subtitle1 = regularStyle.copyWith(
    fontSize: Dimens.fontSize16,
    letterSpacing: 0.15,
  );

  /// NAME         SIZE  WEIGHT  SPACING
  /// subtitle2    14.0  medium   0.1
  static final TextStyle subtitle2 = mediumStyle.copyWith(
    fontSize: Dimens.fontSize14,
    letterSpacing: 0.1,
  );

  /// NAME         SIZE  WEIGHT  SPACING
  /// body1        16.0  regular  0.5   (bodyText1)
  static final TextStyle body1 = regularStyle.copyWith(
    fontSize: Dimens.fontSize16,
    letterSpacing: 0.5,
  );

  /// NAME         SIZE  WEIGHT  SPACING
  /// body2        14.0  regular  0.25  (bodyText2)
  static final TextStyle body2 = regularStyle.copyWith(
    fontSize: Dimens.fontSize14,
    letterSpacing: 0.25,
  );

  /// NAME         SIZE  WEIGHT  SPACING
  /// button       14.0  medium   1.25
  static final TextStyle button = mediumStyle.copyWith(
    fontSize: Dimens.fontSize14,
    letterSpacing: 1.25,
  );

  /// NAME         SIZE  WEIGHT  SPACING
  /// caption      12.0  regular  0.4
  static final TextStyle caption = regularStyle.copyWith(
    fontSize: Dimens.fontSize12,
    letterSpacing: .4,
  );

  /// NAME         SIZE  WEIGHT  SPACING
  /// overline     10.0  regular  1.5
  static final TextStyle overline = regularStyle.copyWith(
    fontSize: Dimens.fontSize10,
    letterSpacing: 1.5,
  );

  static final TextStyle eventHeadline = extraBoldStyle.copyWith(
    fontSize: Dimens.fontSize34,
    color: AppColors.black,
  );

  static final TextStyle eventCommentStyle = boldStyle.copyWith(
    fontSize: 16,
    color: AppColors.white,
  );

  static final TextStyle walkTitle = semiBoldStyle.copyWith(
    fontSize: 20,
  );

  static final TextStyle profileName = semiBoldStyle.copyWith(
    fontSize: 24,
  );

  static final TextStyle walkIconItemStyle = boldStyle.copyWith(
    fontSize: 20,
    color: AppColors.middleGrey,
  );

  static final TextStyle walkAddress = lightStyle.copyWith(
    fontSize: 14,
    color: AppColors.middleGrey,
  );

  static final TextStyle walkDescription = regularStyle.copyWith(
    fontSize: 13,
    color: AppColors.middleGrey,
  );

  static final TextStyle rewardDescription = regularStyle.copyWith(
    fontSize: 13,
    color: AppColors.darkGrey,
  );

  static final TextStyle profileEmailStyle = mediumStyle.copyWith(
    fontSize: 16,
    color: AppColors.middleGrey,
  );

  static final TextStyle rankStyle = boldStyle.copyWith(
    fontSize: 32,
    color: AppColors.reward100,
  );

  static final TextStyle rankStatisticsStyle = boldStyle.copyWith(
    fontSize: 14,
    color: AppColors.black,
  );

  static final TextStyle profileTitlesStyle = boldStyle.copyWith(
    fontSize: 24,
    color: AppColors.black,
  );

  static final TextStyle leaderboardLocationStyle = boldStyle.copyWith(
    fontSize: 16,
    color: AppColors.lightGrey,
  );

  static final TextStyle leaderboardWeekTitleStyle = boldStyle.copyWith(
    fontSize: 15,
    color: AppColors.black,
  );

  static TextStyle leaderboardTextStyle = AppTextStyle.mediumStyle.copyWith(
    fontSize: 13.0,
    color: AppColors.middleGrey,
  );

  static TextStyle commonTitleStyle = AppTextStyle.boldStyle.copyWith(
    fontSize: 18.0,
    color: AppColors.black,
  );

  static TextStyle commonItemTitleStyle = AppTextStyle.mediumStyle.copyWith(
    fontSize: 13.0,
    color: AppColors.black,
  );

  static TextStyle commonItemDescriptionStyle = AppTextStyle.mediumStyle.copyWith(
    fontSize: 12.0,
    color: AppColors.middleGrey,
  );

  static TextStyle commonItemCaptionStyle = AppTextStyle.lightStyle.copyWith(
    fontSize: 12.0,
    color: AppColors.middleGrey,
  );

  static TextStyle commonDescriptionStyle = AppTextStyle.regularStyle.copyWith(
    fontSize: 15.0,
    color: AppColors.middleGrey,
  );

  static TextStyle commonCaptionStyle = AppTextStyle.regularStyle.copyWith(
    fontSize: 12.0,
    color: AppColors.lightGrey,
  );

  static TextStyle coloredButtonTextStyle = AppTextStyle.boldStyle.copyWith(
    fontSize: 20.0,
    color: AppColors.white,
  );

  static TextStyle leaderboardKmTextStyle = AppTextStyle.leaderboardTextStyle.copyWith(
    color: AppColors.black,
  );

  static TextStyle leaderboardLeaderTextStyle = AppTextStyle.leaderboardTextStyle.copyWith(
    color: AppColors.reward100,
  );

  static TextStyle leaderboardLocalUserTextStyle = AppTextStyle.leaderboardTextStyle.copyWith(
    color: AppColors.reward60,
  );

  static final TextStyle timerTextStyle = boldStyle.copyWith(
    fontSize: 32,
    color: AppColors.black,
  );

  static final TextStyle lightStyle = _textStyle.copyWith(
    fontWeight: FontWeight.w300,
  );

  static final TextStyle regularStyle = _textStyle.copyWith(
    fontWeight: FontWeight.w400,
  );

  static final TextStyle mediumStyle = _textStyle.copyWith(
    fontWeight: FontWeight.w500,
  );

  static final TextStyle semiBoldStyle = _textStyle.copyWith(
    fontWeight: FontWeight.w600,
  );

  static final TextStyle boldStyle = _textStyle.copyWith(
    fontWeight: FontWeight.w700,
  );

  static final TextStyle extraBoldStyle = _textStyle.copyWith(
    fontWeight: FontWeight.w800,
  );

  static final TextStyle buttonTextStyle = _textStyle.copyWith(
    fontSize: Dimens.fontSize16,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle _textStyle = TextStyle(
    color: Colors.black,
    fontFamily: 'Poppins',
  );


  static TextTheme get textTheme => TextTheme(
        displayLarge: headline1,
        displayMedium: headline2,
        displaySmall: headline3,
        headlineMedium: headline4,
        headlineSmall: headline5,
        titleLarge: headline6,
        titleMedium: subtitle1,
        titleSmall: subtitle2,
        bodyLarge: body1,
        bodyMedium: body2,
        bodySmall: caption,
        labelLarge: button,
        labelSmall: overline,
      );
}
