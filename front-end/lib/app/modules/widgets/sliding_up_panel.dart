import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SlidingUpPanelController {
  final Duration duration;
  final StreamController onPressShowController = StreamController.broadcast();
  final StreamController onPressHideController = StreamController.broadcast();
  bool _isSliding = false;

  SlidingUpPanelController({required this.duration});

  void show() async {
    if (_isSliding) {
      return;
    }

    _isSliding = true;
    onPressShowController.add(null);
    await Future.delayed(duration);
    _isSliding = false;
  }

  void hide() async {
    if (_isSliding) {
      return;
    }

    _isSliding = true;
    onPressHideController.add(null);
    await Future.delayed(duration);
    _isSliding = false;
  }

  void dispose() {
    onPressShowController.close();
    onPressHideController.close();
  }
}


class SlidingUpPanel extends StatefulWidget {
  final SlidingUpPanelController slidingUpPanelController;
  final double ratio;
  final Widget child;

  const SlidingUpPanel({
    Key? key,
    required this.slidingUpPanelController,
    required this.child,
    this.ratio = 0.9,
  }) : super(key: key);

  @override
  State<SlidingUpPanel> createState() => _SlidingUpPanelState();
}


class _SlidingUpPanelState extends State<SlidingUpPanel> with SingleTickerProviderStateMixin{

  late final AnimationController _animationController;
  late final Animation<double> _animation;
  late final Tween<double> _doubleTween;
  final double initHeight = 45.0;
  final isDisplayed = RxBool(false);

  late Duration _duration;

  @override
  void initState() {
    super.initState();
    _duration = widget.slidingUpPanelController.duration;
    _animationController = AnimationController(vsync: this, duration: _duration);
    _doubleTween = Tween<double>(begin: 0, end: 1);
    _animation = _doubleTween.animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    widget.slidingUpPanelController.onPressShowController.stream.listen((_) {
      isDisplayed.value = true;
      _animationController.forward();
    });
    widget.slidingUpPanelController.onPressHideController.stream.listen((_) async {
      _animationController.reverse();
      await Future.delayed(_duration);
      isDisplayed.value = false;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
        if (!isDisplayed.value) {
          return const SizedBox.shrink();
        } else {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Opacity(
                        opacity: _animation.value,
                        child: GestureDetector(
                          onTap: widget.slidingUpPanelController.hide,
                          child: Container(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        )
                    );
                  }
                ),
                SafeArea(
                  top: true,
                  left: false,
                  right: false,
                  bottom: false,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(height: constraints.maxHeight * (1 - widget.ratio)),
                          AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              return SizedBox(
                                height: initHeight + (constraints.maxHeight * widget.ratio - initHeight) * _animation.value,
                                child: child,
                              );
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                              ),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: widget.slidingUpPanelController.hide,
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 20),
                                        Container(
                                          width: 50,
                                          height: 5,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: widget.child,
                                  )
                                ]
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  ),
                ),
              ],
            ),
          );
        }
      }
    );
  }
}

