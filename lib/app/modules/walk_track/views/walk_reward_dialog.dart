import 'package:flutter/material.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/common/values/app_colors.dart';
import 'package:wonder_flutter/app/common/values/styles/app_medal_style.dart';
import 'package:wonder_flutter/app/common/values/styles/app_text_style.dart';
import 'package:wonder_flutter/app/data/models/profile_model.dart';

class WalkRewardDialog extends StatelessWidget {
  final MedalStyleModel _medalStyle;
  final Medal medal;
  final int ratingUpAmount;

  WalkRewardDialog({
    Key? key,
    required this.medal,
    required this.ratingUpAmount,
  }) : _medalStyle = AppMedalStyle.getStyle(medal.title), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: Constants.defaultHorizontalPadding,
        vertical: 24.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '휴! 고생하셨습니다!',
              style: AppTextStyle.boldStyle.copyWith(
                fontSize: 16.0,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundColor: AppColors.extraLightGrey,
                  child: Image.asset(
                    _medalStyle.imagePath,
                    width: 50.0,
                    height: 50.0,
                  ),
                ),
                const SizedBox(width: 5.0),
                SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/increase.png', width: 50.0, height: 50.0),
                      const SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add_rounded, color: AppColors.middleGrey, size: 18.0),
                          Text(
                            '$ratingUpAmount',
                            style: AppTextStyle.walkIconItemStyle.copyWith(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
