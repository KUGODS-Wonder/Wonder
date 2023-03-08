import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventController extends GetxController with GetSingleTickerProviderStateMixin {
  late final TabController tabController;
  final List<EventTab> eventTabs = [
    EventTab(
        title: '도시락 배달 봉사',
        comment: '“OO복지 센터를 도와 거동이 힘든 어르신들께 도시락도 전달하고 산책도  같이 해봐요!”',
        iconPath: 'assets/images/elderly_icon.png',
    ),
    EventTab(
        title: '유기견들과 산책',
        comment: '“OO유기견 센터를 도와서 성북구의 강아지들과 함께 산책하고 특수 보상도 가져가세요!”',
        iconPath: 'assets/images/dog_icon.png',
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
  final String iconPath;

  EventTab({
    required this.title,
    required this.comment,
    required this.iconPath,
  });
}