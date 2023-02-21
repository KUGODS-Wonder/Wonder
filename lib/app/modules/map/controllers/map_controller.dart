import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wonder_flutter/app/data/models/walk_model.dart';
import 'package:wonder_flutter/app/data/providers/walk_provider.dart';

class MapController extends GetxController with GetSingleTickerProviderStateMixin {
  final WalkProvider _walkProvider = WalkProvider.to;

  static const CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  late PageController pageController;
  bool _pageControllerInitialized = false;

  final double _maxRotation = 20;
  double cardWidth = 300;
  double cardHeight = 280;
  double _prevScrollX = 0;
  bool _isScrolling = false;

  AnimationController? _tweenController;
  Tween<double>? _tween;
  late Animation<double> _tweenAnim;

  RxDouble normalizedOffset = 0.0.obs;
  final currentIndex = (-1).obs;
  final RxList<Walk> walks = <Walk>[].obs;

  Walk get currentWalk => walks[currentIndex.value];
  double get currentRotation => normalizedOffset * _maxRotation;

  @override
  void onInit() async {
    super.onInit();
    walks.listen(onWalksChange);
    fetchWalks();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void fetchWalks() async {
    if (!_pageControllerInitialized) {
      _initializePageController();
      _pageControllerInitialized = true;
    }
    walks.clear();
    walks.addAll(await _walkProvider.getWalks());
    changeIndex(walks.isEmpty ? -1 : 0);
  }

  void changeIndex(int index) {
    if (index < walks.length) {
      currentIndex.value = index;
    }
  }

  void onWalksChange(List<Walk> walks) {

  }

  void _initializePageController() {
    if (currentIndex.value != -1) {
      return;
    }

    cardWidth = (Get.width * .75).clamp(250.0, 350.0);
    cardHeight = cardWidth * 0.93;

    //Calculate the viewPort fraction for this aspect ratio, since PageController does not accept pixel based size values
    pageController = PageController(initialPage: 0, viewportFraction: cardWidth / Get.width);
  }

  //Check the notifications bubbling up from the ListView, use them to update our currentOffset and isScrolling state
  bool handleScrollNotifications(Notification notification) {
    //Scroll Update, add to our current offset, but clamp to -1 and 1
    if (notification is ScrollUpdateNotification) {
      if (_isScrolling) {
        double dx = notification.metrics.pixels - _prevScrollX;
        double scrollFactor = .01;
        double newOffset = (normalizedOffset.value + dx * scrollFactor);
        _setOffset(newOffset.clamp(-1.0, 1.0));
      }
      _prevScrollX = notification.metrics.pixels;
      //Calculate the index closest to middle
      //_focusedIndex = (_prevScrollX / (_itemWidth + _listItemPadding)).round();

      // onWalkChange(walks.elementAt(pageController.page!.round() % walks.length));
    }
    //Scroll Start
    else if (notification is ScrollStartNotification) {
      _isScrolling = true;
      _prevScrollX = notification.metrics.pixels;
      if (_tween != null) {
        _tweenController!.stop();
      }
    }
    return true;
  }

  void handlePointerUp(PointerUpEvent event) {
    if (_isScrolling) {
      _isScrolling = false;
      _startOffsetTweenToZero();
    }
  }

  void _setOffset(double value) {
    normalizedOffset.value = value;
  }

  //Tweens our offset from the current value, to 0
  void _startOffsetTweenToZero() {
    //The first time this runs, setup our controller, tween and animation. All 3 are required to control an active animation.
    int tweenTime = 1000;
    if (_tweenController == null) {
      //Create Controller, which starts/stops the tween, and rebuilds this widget while it's running
      _tweenController = AnimationController(vsync: this, duration: Duration(milliseconds: tweenTime));
      //Create Tween, which defines our begin + end values
      _tween = Tween<double>(begin: -1, end: 0);
      //Create Animation, which allows us to access the current tween value and the onUpdate() callback.
      _tweenAnim = _tween!.animate(CurvedAnimation(parent: _tweenController!, curve: Curves.elasticOut))
      //Set our offset each time the tween fires, triggering a rebuild
        ..addListener(() {
          _setOffset(_tweenAnim.value);
        });
    }
    //Restart the tweenController and inject a new start value into the tween
    _tween!.begin = normalizedOffset.value;
    _tweenController!.reset();
    _tween!.end = 0;
    _tweenController!.forward();
  }
}
