import 'package:flutter/material.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/common/util/utils.dart';
import 'package:wonder_flutter/app/common/values/app_colors.dart';
import 'package:wonder_flutter/app/common/values/styles/app_medal_style.dart';
import 'package:wonder_flutter/app/common/values/styles/app_text_style.dart';
import 'package:wonder_flutter/app/modules/home/controllers/home_controller.dart';
import 'package:wonder_flutter/app/modules/widgets/api_fetch_future_builder.dart';
import 'package:wonder_flutter/app/modules/widgets/app_bottom_navigation_bar.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: false,
        left: false,
        right: false,
        child: ApiFetchFutureBuilder(
          future: controller.initFuture,
          builder: (context, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Constants.defaultHorizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 28.0,
                        child: Text(
                          controller.profile.nickname,
                          style: AppTextStyle.profileName,
                        ),
                      ),
                      Text(
                        controller.profile.email,
                        style: AppTextStyle.profileEmailStyle,
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          _buildRankCircle(170.0),
                          const SizedBox(width: 10.0),
                          SizedBox(
                            height: 170.0,
                            child: _buildProfileStatistics(),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15.0),
                const Divider(
                  height: 1.0,
                  thickness: 1.0,
                  color: AppColors.extraLightGrey,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Constants.defaultHorizontalPadding),
                  child: _buildMedalSection(),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: Constants.defaultHorizontalPadding),
                    color: AppColors.reward60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10.0),
                        Text(
                          '${controller.leaderboard.location} 리더보드',
                          // '${controller.leaderboard.location} ${controller.leaderboard.month}월 ${controller.leaderboard.week}주차',
                          style: AppTextStyle.leaderboardWeekTitleStyle,
                        ),
                        const SizedBox(height: 10.0),
                        Expanded(
                          child: ListView.separated(
                            itemCount: controller.leaderboardDisplayRanks.length,
                            itemBuilder: (context, index) {
                              var isMe = false;
                              var isLeader = false;
                              if (index == 0) {
                                isMe = true;
                              } else if (index == 1) {
                                isLeader = true;
                              }
                              return _buildLeaderboardTile(index, isMe, isLeader);
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 5.0);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(currentIndex: 2)
    );
  }


  Widget _buildRankCircle(double length) {
    return Container(
      width: length,
      height: length,
      alignment: Alignment.centerLeft,
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              width: length - 3,
              height: length - 3,
              child: const CircularProgressIndicator(
                value: 1.0,
                strokeWidth: 10,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.faintGrey),
              ),
            ),
          ),
          _buildAnimatedCircle(170, AppColors.lightReward100),
          _buildAnimatedCircle(160, AppColors.lightReward90),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20.0),
                Text(
                  controller.profile.rank.toUpperCase(),
                  style: AppTextStyle.rankStyle,
                ),
                SizedBox(
                  height: 20.0,
                  child: Text(
                    '${controller.profile.currentRating}/${controller.profile.ratingToNextRank}',
                    style: AppTextStyle.boldStyle.copyWith(
                      fontSize: 16.0,
                      color: AppColors.reward80,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildAnimatedCircle(double length, Color color) {
    return AnimatedBuilder(
      animation: controller.circularAnimation,
      builder: (context, child) {
        return Center(
          child: SizedBox(
            width: length,
            height: length,
            child: CircularProgressIndicator(
              value: controller.circularAnimation.value,
              strokeWidth: 5,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        );
      }
    );
  }

  Widget _buildProfileStatistics() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Utils.convertHoursToString(controller.profile.hoursWalked),
              style: AppTextStyle.rankStatisticsStyle,
            ),
            Text(
                '총 걸은 시간',
                style: AppTextStyle.walkDescription
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Utils.convertDistanceToKm(controller.profile.totalDistanceWalked),
              style: AppTextStyle.rankStatisticsStyle,
            ),
            Text(
                '총 걸은 거리',
                style: AppTextStyle.walkDescription
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMedalSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 32.0,
          child: Text(
            'Medals',
            style: AppTextStyle.profileTitlesStyle,
          ),
        ),
        SizedBox(
          height: 30.0,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: controller.profile.medal.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: controller.showMedalDetails(index),
                child: Image.asset(
                  AppMedalStyle.getStyle(controller.profile.medal[index].title).imagePath,
                  width: 30.0,
                  height: 30.0,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.0,
                  child: Text(
                    'Leaderboard',
                    style: AppTextStyle.profileTitlesStyle,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                  child: Text(
                    controller.leaderboard.location,
                    style: AppTextStyle.leaderboardLocationStyle,
                  ),
                ),
                const SizedBox(height: 10.0)
              ],
            ),
            OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.kPrimary60,
                  fixedSize: const Size(156.0, 48.0),
                  side: const BorderSide(color: AppColors.kPrimary60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/fire.png',
                      width: 25.0,
                      height: 25.0,
                    ),
                    const SizedBox(width: 5.0),
                    Text(
                      '금주의 핫한 산책로',
                      style: AppTextStyle.boldStyle.copyWith(
                        color: AppColors.kPrimary100,
                        fontSize: 12.0,
                      ),
                    )
                  ],
                )
            )
          ],
        ),
      ],
    );
  }


  Widget _buildLeaderboardTile(int index, bool isMe, bool isLeader) {
    var textStyle = isMe ? AppTextStyle.leaderboardLocalUserTextStyle :
    (isLeader ? AppTextStyle.leaderboardLeaderTextStyle :
    AppTextStyle.leaderboardTextStyle);
    var rank = controller.leaderboardDisplayRanks[index];
    
    return Container(
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: isMe ? AppColors.reward100 : AppColors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '#${isMe ? controller.leaderboard.myRank : index}',
            style: textStyle.copyWith(
              fontStyle: FontStyle.italic
            ),
          ),
          const SizedBox(width: 5.0),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      rank.nickname,
                      style: textStyle,
                    ),
                    isLeader ? 
                      Image.asset(
                        'assets/images/trophy.png',
                        width: 18.0,
                        height: 18.0,
                      )
                      : const SizedBox.shrink(),
                  ],
                ),
                Text(
                  '${Utils.convertDistanceToKm(rank.distance)}',
                  style: textStyle,
                ),
              ],
            )
          )
        ],
      ),
    );
  }
}
