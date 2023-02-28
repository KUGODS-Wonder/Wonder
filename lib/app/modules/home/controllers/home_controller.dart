import 'package:flutter/cupertino.dart';
import 'package:wonder_flutter/app/common/storage/storage.dart';
import 'package:get/get.dart';
import 'package:wonder_flutter/app/data/models/leaderboard_model.dart';
import 'package:wonder_flutter/app/data/models/profile_model.dart';
import 'package:wonder_flutter/app/data/providers/leaderboard_provider.dart';
import 'package:wonder_flutter/app/data/providers/profile_provider.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin{

  static const Duration _circularAnimationDuration = Duration(milliseconds: 1500);

  final ProfileProvider _profileProvider = ProfileProvider.to;
  final LeaderboardProvider _leaderboardProvider = LeaderboardProvider.to;

  late Future initFuture;

  late Profile profile;
  late LeaderboardData leaderboard;

  late AnimationController circularAnimationController;
  late Tween<double> _circularTween;
  late Animation<double> circularAnimation;

  @override
  void onInit() async {
    super.onInit();
    initFuture = fetchProfile();
    initFuture.then((_) {
      _initializeCircularAnimation(profile.currentRating / profile.ratingToNextRank);
      circularAnimationController.forward();
    });
  }

  @override
  void onReady() {
    super.onReady();
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
      var profileFuture = _profileProvider.getProfile();
      var leaderboardFuture = _leaderboardProvider.getLeaderboardData();

      profile = await profileFuture;
      leaderboard = await leaderboardFuture;
    }
    catch (_) {
      return Future.error('프로필 데이터 획득 실패');
    }

    return true;
  }

  void _initializeCircularAnimation(double rankProgress) {
    circularAnimationController = AnimationController(
      vsync: this,
      duration: _circularAnimationDuration,
    );
    _circularTween = Tween<double>(begin: 0, end: rankProgress);
    circularAnimation = _circularTween.animate(CurvedAnimation(parent: circularAnimationController, curve: Curves.easeInOut));
  }
}
