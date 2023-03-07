import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventController extends GetxController with GetSingleTickerProviderStateMixin {
  static double tabIconSize = 30.0;
  late final TabController tabController;
  final List<EventTab> eventTabs = [
    EventTab(
        title: '유기견들과 산책',
        comment: '“OO유기견 센터를 도와서 성북구의 강아지들과 함께 산책하고 특수 보상도 가져가세요!”',
        icon: Image.asset(
          'assets/images/dog_icon.png',
          width: tabIconSize,
          height: tabIconSize,
        )
    ),
    EventTab(
        title: '도시락 배달 봉사',
        comment: '“OO유기견 센터를 도와서 성북구의 강아지들과 함께 산책하고 특수 보상도 가져가세요!”',
        icon: Image.asset(
          'assets/images/dog_icon.png',
          width: tabIconSize,
          height: tabIconSize,
        )
    ),
  ];

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(vsync: this, length: eventTabs.length);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class EventTab {
  final String title;
  final String comment;
  final Widget icon;

  EventTab({
    required this.title,
    required this.comment,
    required this.icon
  });
}