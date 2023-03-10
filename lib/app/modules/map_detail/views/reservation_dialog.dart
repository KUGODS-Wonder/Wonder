import 'package:flutter/material.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/common/util/animatable_list.dart';
import 'package:wonder_flutter/app/common/values/app_colors.dart';
import 'package:wonder_flutter/app/common/values/styles/app_text_style.dart';
import 'package:wonder_flutter/app/data/models/reservation_model.dart';

class ReservationDialog extends StatefulWidget {
  static const int maxDisplays = 3;
  static const double listItemHeight = 80.0;
  static const String canApplyText = '신청가능';
  static const String maxText = '마감';

  final List<Reservation> possibleReservations;
  final String bottomMessage;


  const ReservationDialog({
    Key? key,
    required this.possibleReservations,
    required this.bottomMessage,
  }) : super(key: key);

  @override
  State<ReservationDialog> createState() => _ReservationDialogState();
}

class _ReservationDialogState extends State<ReservationDialog> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  late AnimatableList<Reservation> _animatableList;

  @override
  void initState() {
    super.initState();
    _animatableList = AnimatableList<Reservation>(
      listKey: _listKey,
      removedItemBuilder: (item, context, animation) {
        return _buildListItem(item, animation, () {});
      },
      initialItems: widget.possibleReservations,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: const EdgeInsets.all(Constants.defaultHorizontalPadding),
        child: Container(
            padding: const EdgeInsets.all(Constants.defaultHorizontalPadding),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AnimatedList(
                    key: _listKey,
                    initialItemCount: _animatableList.length,
                    itemBuilder: (context, index, animation) {
                      return _buildListItem(_animatableList[index], animation, () {
                        _animatableList.removeAt(index);
                      });
                    }
                  ),
                ),
                Text(
                  widget.bottomMessage,
                  style: AppTextStyle.commonDescriptionStyle,
                ),
              ],
            )
        )
    );
  }

  Widget _buildListItem(Reservation item, Animation<double> animation, void Function() onTap) {
    int appliedPeopleCount = item.appliedPeopleCount;
    int maxPeopleCount = item.maxPeopleCount;
    return SlideTransition(
      position: animation.drive(Tween(begin: const Offset(-1.0,0.0), end: const Offset(0.0,0.0))),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: ReservationDialog.listItemHeight,
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.defaultHorizontalPadding),
          decoration: BoxDecoration(
            color: AppColors.extraLightGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.date,
                          style: AppTextStyle.commonItemTitleStyle),
                      Text('${item.timeStart} ~ ${item.timeEnd}',
                          style: AppTextStyle.commonItemDescriptionStyle),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 10),
                          const SizedBox(width: 5),
                          Text(item.location,
                              style: AppTextStyle.commonItemCaptionStyle),
                        ],
                      ),
                    ],
                  )
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('$appliedPeopleCount/$maxPeopleCount',
                        style: AppTextStyle.commonItemTitleStyle),
                  ),
                  Text(appliedPeopleCount == maxPeopleCount ? ReservationDialog.maxText : ReservationDialog.canApplyText,
                      style: AppTextStyle.commonItemDescriptionStyle),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
