import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/util/utils.dart';
import 'package:wonder_flutter/app/common/values/app_colors.dart';
import 'package:wonder_flutter/app/common/values/styles/app_text_style.dart';
import 'package:wonder_flutter/app/common/values/styles/app_walk_theme_style.dart';
import 'package:wonder_flutter/app/data/models/adapter_models/walk_model.dart';
import 'package:wonder_flutter/app/modules/widgets/api_fetch_future_builder.dart';
import 'package:wonder_flutter/app/modules/widgets/walk_tag.dart';


class SmallWalkContainer extends StatelessWidget {
  static const Duration _animateDuration = Duration(milliseconds: 300);
  final Walk walk;
  final Function() onStartButtonPressed;
  final Function() onSaveButtonPressed;
  final Future<int> requiredWalkLeft;
  final WalkThemeStyleModel themeStyle;
  final bool isDetailMode;
  final bool isEvent;
  final String? eventMedalImagePath;
  final double detailHeight;

  SmallWalkContainer({
    Key? key,
    required this.walk,
    required this.requiredWalkLeft,
    required this.onStartButtonPressed,
    required this.onSaveButtonPressed,
    this.isDetailMode = false,
    this.isEvent = false,
    this.eventMedalImagePath,
    this.detailHeight = 280,
  }) : themeStyle = AppWalkThemeStyle.getStyle(walk.theme), super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: isDetailMode ? detailHeight : 280,
      width: isDetailMode ? Get.width : 300,
      duration: _animateDuration,
      padding: EdgeInsets.symmetric(
          vertical: isDetailMode ? 0.0: 25.0,
          horizontal: 25.0
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(isDetailMode ? 0 : 30),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  walk.name,
                  style: AppTextStyle.walkTitle,
                ),
                Text(
                  walk.location,
                  style: AppTextStyle.walkAddress,
                ),
                const SizedBox(height: 5.0),
                SizedBox(
                  height: 18.0,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: walk.tags.length,
                    itemBuilder: (context, index) {
                      return WalkTag(tag: walk.tags[index]);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 8.0);
                    }
                  ),
                ),
                const SizedBox(height: 5.0),
                SizedBox(
                  width: Get.width,
                  height: 130.0 + (isEvent ? 65.0 : 0.0),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      _buildIconItem(
                          'assets/images/increase.png',
                          isDetailMode: isDetailMode,
                          left: 0.0,
                          top: 0.0,
                          background: AppColors.faintGrey,
                          child: Stack(
                            children: [
                              AnimatedPositioned(
                                left: isDetailMode ? 63.0 : 14.0,
                                top: isDetailMode ? 20.0 : 57.0,
                                duration: _animateDuration,
                                child: const Icon(Icons.add_rounded, color: AppColors.middleGrey, size: 14.0)
                              ),
                              AnimatedPositioned(
                                duration: _animateDuration,
                                left: isDetailMode ? 80.0 : 30.0,
                                top: isDetailMode ? 12.0 : 50.0,
                                child: Text(
                                  '${walk.ratingUp}',
                                  style: AppTextStyle.walkIconItemStyle,
                                ),
                              ),
                            ],
                          )
                      ),
                      Positioned(
                        top: 7.0,
                        left: 140.0,
                        right: 0.0,
                        // width: 200.0,
                        child: AnimatedOpacity(
                          opacity: isDetailMode ? 1.0 : 0.0,
                          duration: _animateDuration,
                          child: Text(
                            '이 산책로를 완주하면 ${walk.ratingUp}의 보상이 있습니다!',
                            style: AppTextStyle.rewardDescription,
                          ),
                        ),
                      ),
                      _buildIconItem(
                          'assets/images/fireworks.png',
                          isDetailMode: isDetailMode,
                          left: 80.0,
                          detailLeft: 0.0,
                          top: 0.0,
                          detailTop: 70.0,
                          background: AppColors.reward60,
                          child: Stack(
                            children: [
                              AnimatedPositioned(
                                left: isDetailMode ? 58.0 : 9.0,
                                top: isDetailMode ? 18.0 : 55.0,
                                duration: _animateDuration,
                                child: Image.asset(
                                  'assets/images/walking_person.png',
                                  width: 20.0,
                                  height: 20.0
                                ),
                              ),
                              AnimatedPositioned(
                                left: isDetailMode ? 75.0 : 26.0,
                                top: isDetailMode ? 20.0 : 57.0,
                                duration: _animateDuration,
                                child: const Icon(Icons.close_rounded, color: AppColors.reward100, size: 14.0)),
                              AnimatedPositioned(
                                left: isDetailMode ? 90.0 : 41.0,
                                top: isDetailMode ? 12.0 : 50.0,
                                duration: _animateDuration,
                                child: ApiFetchFutureBuilder<int>(
                                  future: requiredWalkLeft,
                                  builder: (context, requiredWalksLeft) {
                                    return Text(
                                      '${requiredWalksLeft ?? '?'}',
                                      style: AppTextStyle.walkIconItemStyle.copyWith(
                                        color: AppColors.reward100,
                                      ),
                                    );
                                  }
                                ),
                              ),
                            ],
                          )
                      ),
                      Positioned(
                        top: 77.0,
                        left: 140.0,
                        right: 0.0,
                        child: AnimatedOpacity(
                          opacity: isDetailMode ? 1.0 : 0.0,
                          duration: _animateDuration,
                          child: ApiFetchFutureBuilder(
                            future: requiredWalkLeft,
                            builder: (context, requiredWalksLeft) {
                              return Text(
                                '이 산책로를 앞으로 총 ${requiredWalksLeft ?? '?'}번 걸으면 랭크 업!',
                                style: AppTextStyle.rewardDescription,
                              );
                            }
                          ),
                        ),
                      ),
                      isEvent ? _buildIconItem(
                        eventMedalImagePath ?? 'assets/images/medals/medal.png',
                        isDetailMode: isDetailMode,
                        left: 160.0,
                        // detailLeft: 0.0,
                        detailLeft: 50.0,
                        top: 0.0,
                        detailTop: 140.0,
                        isOnlyIcon: true,
                        background: AppColors.defaultWalkColor,
                        child: const SizedBox.shrink(),
                      ) : const SizedBox.shrink(),
                      isEvent ? Positioned(
                        top: 147.0,
                        // left: 88.0,
                        left: 140.0,
                        right: 0.0,
                        child: AnimatedOpacity(
                          opacity: isDetailMode ? 1.0 : 0.0,
                          duration: _animateDuration,
                          child: Text(
                            '특수 보상이 있습니다.',
                            style: AppTextStyle.rewardDescription.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ) : const SizedBox.shrink(),
                    ]
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              width: 150.0,
              height: 40.0,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration: _animateDuration,
                          decoration: BoxDecoration(
                            color: themeStyle.color,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          width: isDetailMode ? 120.0 : 0.0,
                          height: 20.0,
                          child: Text(
                            walk.theme,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.semiBoldStyle.copyWith(
                              fontSize: 15.0
                            )
                          ),
                        ),
                        const SizedBox(width: 20.0)
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      AppWalkThemeStyle.getStyle(walk.theme).iconPath,
                      width: 40.0,
                      height: 40.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Utils.convertDistanceToKm(walk.distance),
                  style: AppTextStyle.walkDescription,
                ),
                Text(
                  '${walk.time} 분 소요',
                  style: AppTextStyle.walkDescription,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                isEvent ? const SizedBox.shrink() :
                _buildButton(
                  onPressed: onSaveButtonPressed,
                  color: AppColors.white,
                  outlineColor: AppColors.kPrimary100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.bookmark_rounded,
                        color: AppColors.kPrimary100,
                        size: 16.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Text(
                          '저장',
                          style: AppTextStyle.boldStyle.copyWith(
                            color: AppColors.kPrimary100,
                            fontSize: 16.0,
                          ),
                        ),
                      )
                    ]
                  )
                ),
                const SizedBox(width: 10.0),
                _buildButton(
                  onPressed: onStartButtonPressed,
                  color: AppColors.kPrimary100,
                  child: Text(
                    isEvent ? '신청' : '시작',
                    style: AppTextStyle.coloredButtonTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconItem(String path, {
    required Color background,
    required bool isDetailMode,
    required double left,
    double? detailLeft,
    required double top,
    double? detailTop,
    bool isOnlyIcon = false,
    Widget? child}) {
    double width = isOnlyIcon ? 65.0 : (isDetailMode ? 115.0 : 65.0);
    double height = isOnlyIcon ? 55.0 : (isDetailMode ? 55.0 : 75.0);

    return AnimatedPositioned(
      duration: _animateDuration,
      left: isDetailMode ? (detailLeft ?? left) : left,
      top: isDetailMode ? (detailTop ?? top) : top,
      child: AnimatedContainer(
        duration: _animateDuration,
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 15.0,
              top: 10.0,
              child: Image.asset(path, width: 36.0, height: 36.0),
            ),
            SizedBox(
                height: isDetailMode ? 55.0 : 75.0,
                width: isDetailMode ? 115.0 : 65.0,
              child: child ?? const SizedBox.shrink()
            )
          ],
        ),
      ),
    );
  }


  Widget _buildButton({
      required Widget child,
      required Color color,
      required Function() onPressed,
      Color? outlineColor
    }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: color,
        fixedSize: const Size(80.0, 35.0),
        side: BorderSide(color: outlineColor ?? color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: child
    );
  }
}
