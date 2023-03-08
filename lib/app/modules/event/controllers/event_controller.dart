import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/values/styles/app_walk_theme_style.dart';
import 'package:wonder_flutter/app/data/enums/walk_type_enum.dart';
import 'package:wonder_flutter/app/data/models/walk_model.dart';
import 'package:wonder_flutter/app/data/providers/walk_provider.dart';

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

  final Map<WalkType, List<Walk>> eventWalkMap = {};

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
    var targetEventWalkList = eventWalkMap[walkType];

    if (eventWalkMap.containsKey(walkType)) {
      targetEventWalkList = eventWalkMap[walkType]!;
    } else {
      targetEventWalkList = [];
    }

    targetEventWalkList.addAll(await _walkProvider.getWalksByType(walkType));

    eventWalkMap[walkType] = targetEventWalkList;
    return targetEventWalkList;
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