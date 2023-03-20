import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/values/styles/app_walk_theme_style.dart';
import 'package:wonder_flutter/app/data/enums/walk_type_enum.dart';
import 'package:wonder_flutter/app/data/models/adapter_models/walk_model.dart';
import 'package:wonder_flutter/app/data/providers/walk_provider.dart';
import 'package:wonder_flutter/app/routes/app_pages.dart';

class EventController extends GetxController with GetSingleTickerProviderStateMixin {

  static const specialEventsThemeKeys = [
    '도시락 전달',
    '유기견 산책'
  ];

  final WalkProvider _walkProvider = WalkProvider.to;
  late final TabController tabController;

  final List<WalkThemeStyleModel> eventTabs = specialEventsThemeKeys.map((theme) {
    return AppWalkThemeStyle.getStyle(theme);
  }).toList();

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

  Future<List<Walk>> fetchWalksByEventWalkType(WalkType walkType) async {
    var targetEventWalkList = <Walk>[];
    targetEventWalkList.addAll(await _walkProvider.getWalksByType(walkType));

    return targetEventWalkList;
  }

  void onReservationButtonPressed() {
    Get.toNamed(Routes.RESERVATION_LIST);
  }

  void Function() injectOnWonderCardPressed(Walk walk) {
    return () {
      Get.toNamed(Routes.MAP_DETAIL, arguments: {
        'id': walk.id,
        'walk': walk,
        'isEvent': true,
      });
    };
  }
}

class EventTab {
  final String title;
  final String comment;
  final String iconPath;
  final WalkType walkType;

  EventTab({
    required this.title,
    required this.comment,
    required this.iconPath,
    required this.walkType,
  });
}