import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/common/values/app_colors.dart';
import 'package:wonder_flutter/app/common/values/styles/app_text_style.dart';
import 'package:wonder_flutter/app/data/models/adapter_models/walk_model.dart';
import 'package:wonder_flutter/app/modules/widgets/api_fetch_future_builder.dart';
import 'package:wonder_flutter/app/modules/widgets/app_bottom_navigation_bar.dart';
import 'package:wonder_flutter/app/modules/widgets/black_outlined_button.dart';
import '../controllers/event_controller.dart';

class EventView extends GetView<EventController> {
  static const double tabIconSize = 25.0;
  static const _tabViewHorizontalPadding = Constants.defaultHorizontalPadding + 20;
  static const tabTextStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w400);


  const EventView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    double wonderCardWidth = Get.width * 0.8;
    double wonderCardHeight = wonderCardWidth * 0.85;

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
                        BlackOutlinedButton(
                          onPressed: controller.onReservationButtonPressed,
                          text: '예약 내역'
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: Get.width * 0.8,
                    child: AnimatedBuilder(
                      animation: controller.colorAnimation,
                      builder: (context, child) {
                        return TabBar(
                          controller: controller.tabController,
                          indicatorSize: TabBarIndicatorSize.label,
                          labelColor: AppColors.white,
                          unselectedLabelColor: AppColors.black,
                          labelPadding: const EdgeInsets.symmetric(horizontal: 0),
                          indicator: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.elliptical(30, 20),
                                  topRight: Radius.elliptical(30, 20)
                              ),
                              color: controller.colorAnimation.value),
                          tabs: controller.eventTabs.map(
                            (eventTab) {
                              return Tab(
                                height: 35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Image.asset(
                                      eventTab.iconPath,
                                      width: tabIconSize,
                                      height: tabIconSize,
                                    ),
                                    const SizedBox(width: 2),
                                    SizedBox(
                                      height: 18.0,
                                      child: Text(eventTab.title, style: tabTextStyle)
                                    ),
                                  ],
                                )
                              );
                            }
                          ).toList()
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: AnimatedBuilder(
                      animation: controller.colorAnimation,
                      builder: (context, child) {
                        return Container(
                          decoration: BoxDecoration(
                            color: controller.colorAnimation.value,
                            borderRadius: const BorderRadius.only(
                              // topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: child,
                        );
                      },
                      child: TabBarView(
                        controller: controller.tabController,
                        children: controller.eventTabs.map(
                                (eventTab) {
                              return ApiFetchFutureBuilder<List<Walk>>(
                                  future: controller.getWalksByType(eventTab.walkType),
                                  builder: (context, data) {
                                    return Column(
                                      children: [
                                        const SizedBox(height: 20),
                                        SizedBox(
                                          height: wonderCardHeight,
                                          child: PageView.builder(
                                            itemCount: data!.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: _tabViewHorizontalPadding),
                                                child: _buildWonderCard(
                                                  title: data[index].name,
                                                  address: data[index].location,
                                                  imagePath: eventTab.eventCardPath,
                                                  width: wonderCardWidth,
                                                  onTap: controller.injectOnWonderCardPressed(data[index]),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: _tabViewHorizontalPadding,
                                              ),
                                              child: Text(
                                                eventTab.comment,
                                                textAlign: TextAlign.center,
                                                style: AppTextStyle.eventCommentStyle,
                                              ),
                                            ),
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
      bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 0),
    );
  }

  Widget _buildWonderCard({
    required String title,
    required String address,
    required String imagePath,
    required void Function() onTap,
    required double width,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyle.walkTitle,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: AppColors.middleGrey,
                          size: 15.0,
                        ),
                        Text(
                          address,
                          style: AppTextStyle.walkAddress,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
