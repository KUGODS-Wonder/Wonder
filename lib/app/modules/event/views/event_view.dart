import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/common/values/app_colors.dart';
import 'package:wonder_flutter/app/common/values/styles/app_text_style.dart';
import 'package:wonder_flutter/app/data/models/walk_model.dart';
import 'package:wonder_flutter/app/modules/widgets/api_fetch_future_builder.dart';
import 'package:wonder_flutter/app/modules/widgets/app_bottom_navigation_bar.dart';

import '../controllers/event_controller.dart';

class EventView extends GetView<EventController> {
  static double tabIconSize = 25.0;
  static const tabTextStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w400);


  const EventView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.05),
            Container(
              height: Get.height * 0.2,
              padding: const EdgeInsets.symmetric(horizontal: Constants.defaultHorizontalPadding),
              child: Text(
                '걸어서 기쁨을\n나눠봐요.',
                style: AppTextStyle.eventHeadline,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Constants.defaultHorizontalPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Wonderful Walk',
                          style: AppTextStyle.profileTitlesStyle,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: Get.width * 0.8,
                    child: TabBar(
                      controller: controller.tabController,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelColor: AppColors.white,
                      unselectedLabelColor: AppColors.black,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 0),
                      indicator: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)
                          ),
                          color: AppColors.reward80),
                      tabs: controller.eventTabs.map(
                        (eventTab) {
                          return Tab(
                            height: 35,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  eventTab.iconPath,
                                  width: tabIconSize,
                                  height: tabIconSize,
                                ),
                                const SizedBox(width: 5),
                                Text(eventTab.title, style: tabTextStyle),
                              ],
                            )
                          );
                        }
                      ).toList()
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.reward80,
                        borderRadius: BorderRadius.only(
                          // topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: TabBarView(
                        controller: controller.tabController,
                        children: controller.eventTabs.map(
                          (eventTab) {
                            return ApiFetchFutureBuilder<List<Walk>>(
                              future: controller.fetchWalksByEventWalkType(eventTab.walkType),
                              builder: (context, data) {
                                return Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      height: Get.height * 0.35,
                                      child: PageView.builder(

                                        itemCount: data!.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 45.0),
                                            child: _buildWonderCard(
                                              title: data[index].name!,
                                              address: data[index].location!,
                                              imagePath: eventTab.eventCardPath,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: Constants.defaultHorizontalPadding),
                                      child: Text(
                                        eventTab.comment,
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle.eventCommentStyle,
                                      ),
                                    ),
                                  ],
                                );
                              }
                            );
                          }
                        ).toList(),
                      ),
                    ),
                  )
                ],
              )
            )
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(currentIndex: 0),
    );
  }

  Widget _buildWonderCard({
    required String title,
    required String address,
    required String imagePath,
  }) {
    return Container(
      width: Get.width * 0.8,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.fitWidth,
            ),
          ),
          Text(
            title,
            style: AppTextStyle.walkTitle,
          ),
          Text(
            address,
            style: AppTextStyle.walkAddress,
          ),
        ],
      ),
    );
  }
}
