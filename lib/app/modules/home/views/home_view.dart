import 'package:flutter/material.dart';
import 'package:wonder_flutter/app/common/util/utils.dart';
import 'package:wonder_flutter/app/common/values/app_colors.dart';
import 'package:wonder_flutter/app/common/values/styles/app_text_style.dart';
import 'package:wonder_flutter/app/modules/home/controllers/home_controller.dart';
import 'package:wonder_flutter/app/modules/widgets/app_bottom_navigation_bar.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: FutureBuilder(
          future: controller.initFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error!.toString()),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }

            return Stack(
              children: [
                const SizedBox(height: 60),
                Align(
                  alignment: Alignment.topLeft,
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
                            child: Column(
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
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(currentIndex: 0)
    );
  }


  Widget _buildRankCircle(double length) {
    return Container(
      width: length,
      height: length,
      alignment: Alignment.centerLeft,
      child: Stack(
        children: [
          _buildAnimatedCircle(170, AppColors.lightReward100),
          _buildAnimatedCircle(160, AppColors.lightReward90),
          Center(
            child: Text(
              controller.profile.rank.toUpperCase(),
              style: AppTextStyle.rankStyle,
            ),
          )
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
}
