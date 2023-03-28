import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/values/app_colors.dart';
import 'package:wonder_flutter/app/common/values/styles/app_walk_theme_style.dart';
import 'package:wonder_flutter/app/data/enums/walk_type_enum.dart';
import 'package:wonder_flutter/app/data/models/adapter_models/voluntary_walk_model.dart';
import 'package:wonder_flutter/app/data/models/adapter_models/walk_model.dart';
import 'package:wonder_flutter/app/data/providers/voluntary_walk_provider.dart';
import 'package:wonder_flutter/app/routes/app_pages.dart';

class EventController extends GetxController with GetTickerProviderStateMixin {

  final VoluntaryWalkProvider _voluntaryWalkProvider = VoluntaryWalkProvider.to;

  static const specialEventsThemeColors = [
    AppColors.elderCardThemeColor,
    AppColors.reward80,
  ];

  late final TabController tabController;

  final List<WalkThemeStyleModel> eventTabs = VoluntaryWalkProvider.themeToWalkTypeMap.keys.map((theme) {
    return AppWalkThemeStyle.getStyle(theme);
  }).toList();
  final _colorTween = TweenSequence(
        List.generate(
          specialEventsThemeColors.length - 1,
          (index) => TweenSequenceItem(
            tween: ColorTween(begin: specialEventsThemeColors[index],
            end: specialEventsThemeColors[index + 1]),
            weight: 1
          )
        )
  );

  int tabIndex = 0;
  CancelableOperation<Map<WalkType, List<VoluntaryWalk>>>? _fetchVoluntaryWorkOperation;

  late AnimationController _animationController;
  late Animation<Color?> colorAnimation;

  @override
  void onInit() {
    super.onInit();
    _fetchVoluntaryWorkOperation = CancelableOperation.fromFuture(getVoluntaryWalksClassifiedByType());

    tabController = TabController(vsync: this, length: eventTabs.length);
    tabController.addListener(() {
      onTabSelected(tabController.index);
    });
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    colorAnimation = _animationController.drive(_colorTween);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    tabController.dispose();
    _animationController.dispose();
    _fetchVoluntaryWorkOperation?.cancel();
    super.onClose();
  }

  Future<Map<WalkType, List<VoluntaryWalk>>> getVoluntaryWalksClassifiedByType() async {
    return await _voluntaryWalkProvider.getVoluntaryWalksClassifiedByType();
  }

  Future<List<Walk>> getWalksByType(WalkType walkType) async {
    var map = await _fetchVoluntaryWorkOperation?.value;
    if (map != null) {
      return map[walkType] ?? [];
    }
    return [];
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

  void onTabSelected(int index) {
    _animationController.animateTo(index / (eventTabs.length - 1));
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