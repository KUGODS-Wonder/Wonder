import 'package:flutter/material.dart';
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

            return Column(
              children: [
                const SizedBox(height: 60),
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.profile.nickname,
                        style: AppTextStyle.profileName,
                      ),
                      Text(
                        controller.profile.email,
                        style: AppTextStyle.profileEmailStyle,
                      ),
                      _buildRankCircle(),
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


  Widget _buildRankCircle() {
    return Container(
      width: 170,
      height: 170,
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
