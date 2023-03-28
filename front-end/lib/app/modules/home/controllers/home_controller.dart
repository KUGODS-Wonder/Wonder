import 'package:flutter/material.dart';
import 'package:wonder_flutter/app/common/storage/storage.dart';
import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/util/utils.dart';
import 'package:wonder_flutter/app/data/models/adapter_models/profile_model.dart';
import 'package:wonder_flutter/app/data/providers/state_providers/profile_state_provider.dart';


class HomeController extends GetxController with GetSingleTickerProviderStateMixin{

  static const Duration _circularAnimationDuration = Duration(milliseconds: 1500);

  final ProfileStateProvider _profileProvider = ProfileStateProvider.to;

  late Future<bool> initFuture;

  late Profile profile;
  late LeaderboardInfo leaderboard;
  late List<Rank> leaderboardDisplayRanks = <Rank>[];

  AnimationController? _circularAnimationController;
  late Tween<double> _circularTween;
  late Animation<double> circularAnimation;

  @override
  void onInit() async {
    super.onInit();
    initFuture = fetchProfile();
    initFuture.then((value) {
      _initializeCircularAnimation(profile.currentRating / profile.ratingToNextRank);
      _circularAnimationController?.forward();

      return value;
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _circularAnimationController?.dispose();
    super.onClose();
  }

  void onEditProfileClick() {
    Get.back();
  }

  void onFaqsClick() {
    Get.back();
  }

  void onLogoutClick() {
    Storage.clearStorage();
  }


  Future<bool> fetchProfile() async {

    try {
      var profileFuture = _profileProvider.refreshProfile();

      profile = await profileFuture;
      leaderboard = profile.leaderboardInfo;

      leaderboardDisplayRanks.add(Rank(nickname: '나', distance: leaderboard.myDistance));
      leaderboardDisplayRanks.addAll(leaderboard.rank);
    }
    catch (_) {
      return Future.error('프로필 데이터 획득 실패');
    }

    return true;
  }

  void _initializeCircularAnimation(double rankProgress) {
    _circularAnimationController = AnimationController(
      vsync: this,
      duration: _circularAnimationDuration,
    );
    _circularTween = Tween<double>(begin: 0, end: rankProgress);
    circularAnimation = _circularTween.animate(CurvedAnimation(parent: _circularAnimationController!, curve: Curves.easeInOut));
  }

  void Function() showMedalDetails(int index) {
    return () => Utils.showMedalDialog(profile.medal[index]);
  }
}
