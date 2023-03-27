import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/common/util/animatable_list.dart';
import 'package:wonder_flutter/app/common/values/styles/app_text_style.dart';
import 'package:wonder_flutter/app/data/models/adapter_models/voluntary_walk_model.dart';
import 'package:wonder_flutter/app/modules/widgets/colored_button.dart';
import 'package:wonder_flutter/app/modules/widgets/reservation_tile.dart';

class ReservationDialog extends StatefulWidget {
  static const int maxDisplays = 3;
  static const String areYouSureText = '정말 해당 시간으로 신청하시겠습니까?';

  final List<VoluntaryWalk> possibleReservations;
  final String bottomMessage;


  const ReservationDialog({
    Key? key,
    required this.possibleReservations,
    required this.bottomMessage,
  }) : super(key: key);

  @override
  State<ReservationDialog> createState() => _ReservationDialogState();
}

class _ReservationDialogState extends State<ReservationDialog> with SingleTickerProviderStateMixin{
  static const Duration _duration = Duration(milliseconds: 500);
  static const double listItemHeight = 80.0;
  static const _buttonHeight = 40.0;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final _animatedListHeight = ReservationDialog.maxDisplays * listItemHeight + 30.0;

  late AnimationController _controller;
  late Tween<double> _shrinkListSizeTween;
  late Tween<double> _expandTween;
  late Animation<double> _shrinkListSizeAnimation;
  late Animation<double> _expandAnimation;
  late AnimatableList<VoluntaryWalk> _animatableList;
  bool isAreYouSureMode = false;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _animatableList = AnimatableList<VoluntaryWalk>(
      listKey: _listKey,
      removedItemBuilder: (item, context, animation) {
        return FadeTransition(
          opacity: animation,
          child: SizeTransition(
            sizeFactor: animation,
            child: _buildListItem(item, animation, () {}, listItemHeight)
          ),
        );
      },
      initialItems: widget.possibleReservations,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: const EdgeInsets.symmetric(
            horizontal: Constants.defaultHorizontalPadding),
        child: Container(
            padding: const EdgeInsets.all(Constants.defaultHorizontalPadding),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: _animatedListHeight * _shrinkListSizeAnimation.value,
                      child: child,
                    ),
                    Text(
                      isAreYouSureMode ? ReservationDialog.areYouSureText : widget.bottomMessage,
                      style: AppTextStyle.commonDescriptionStyle,
                    ),
                    SizedBox(
                      height: _buttonHeight * _expandAnimation.value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ColoredButton(
                            onPressed: () {
                              Get.back(result: null);
                            },
                            child: Text(
                              '취소',
                              style: AppTextStyle.coloredButtonTextStyle,
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          ColoredButton(
                            onPressed: () {
                              if (isAreYouSureMode && _animatableList.length == 1) {
                                Get.back(result: _animatableList[0]);
                              }
                            },
                            child: Text(
                              '신청',
                              style: AppTextStyle.coloredButtonTextStyle,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
              child: AnimatedList(
                  key: _listKey,
                  initialItemCount: _animatableList.length,
                  itemBuilder: (context, index, animation) {
                    return _buildListItem(_animatableList[index], animation, () {
                      _enterAreYouSureMode(index);
                    }, listItemHeight);
                  }
              ),
            )
        )
    );
  }


  void _initAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: _duration,
    );
    _shrinkListSizeTween = Tween<double>(begin: 1.0, end: 0.33);
    _expandTween = Tween<double>(begin: 0.0, end: 1.0);
    _shrinkListSizeAnimation = _shrinkListSizeTween.animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _expandAnimation = _expandTween.animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }


  void _enterAreYouSureMode(int index) {
    if (isAreYouSureMode) {
      return;
    }
    isAreYouSureMode = true;
    _removeAllExcept(index);
    _controller.forward();
  }

  void _removeAllExcept(int index) {
    for (int i = 0; i < index; i++) {
      _animatableList.removeAt(0);
    }

    while (_animatableList.length > 1) {
      _animatableList.removeAt(1);
    }
  }


  Widget _buildListItem(
      VoluntaryWalk item,
      Animation<double> animation,
      void Function() onTap,
      double height
      ) {
    return SlideTransition(
      position: animation.drive(Tween(begin: const Offset(-1.0,0.0), end: const Offset(0.0,0.0))),
      child: ReservationTile(item: item, onTap: onTap, height: height),
    );
  }
}
