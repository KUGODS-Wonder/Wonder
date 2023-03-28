import 'package:flutter/material.dart';
import 'package:get/get.dart';


mixin SwipePageControllerMixin on GetxController, GetSingleTickerProviderStateMixin {
  static const Duration _changePageDuration = Duration(milliseconds: 1000);
  final double maxRotation = 20;
  double cardWidth = 300;
  double cardHeight = 280;
  double _prevScrollX = 0;
  bool _isScrolling = false;
  int _lastIndex = -1;

  AnimationController? _tweenController;
  Tween<double>? _tween;
  late PageController pageController;
  late Animation<double> _tweenAnim;

  RxDouble normalizedOffset = 0.0.obs;

  double get currentRotation => normalizedOffset * maxRotation;

  @override
  void onInit() {
    super.onInit();
    _initializePageController();
  }

  @override onClose () {
    pageController.dispose();
    _tweenController?.dispose();
    super.onClose();
  }


  void onSwipe(int index);


  //Check the notifications bubbling up from the ListView, use them to update our currentOffset and isScrolling state
  bool onHandleScrollNotifications(Notification notification) {
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

      var nextIndex = pageController.page!.round();
      if (nextIndex != _lastIndex) {
        _lastIndex = nextIndex;
        onSwipe(nextIndex);
      }
    }
    //Scroll Start
    else if (notification is ScrollStartNotification) {
      _isScrolling = true;
      _prevScrollX = notification.metrics.pixels;
      if (_tween != null) {
        _tweenController!.stop();
      }
    } else if (notification is ScrollEndNotification) {
      _isScrolling = false;
      _startOffsetTweenToZero();
    }
    return true;
  }

  void onHandlePointerUp(PointerUpEvent event) {
    if (_isScrolling) {
      _isScrolling = false;
      _startOffsetTweenToZero();
    }
  }

  void moveToPage(int page) {
    if (pageController.hasClients && pageController.page! != page) {
      pageController.animateToPage(page, duration: _changePageDuration, curve: Curves.elasticOut);
    }
  }

  void _initializePageController() {
    cardWidth = (Get.width * .75).clamp(250.0, 350.0);
    cardHeight = cardWidth * 0.93;

    //Calculate the viewPort fraction for this aspect ratio, since PageController does not accept pixel based size values
    pageController = PageController(initialPage: 0, viewportFraction: cardWidth / Get.width);
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