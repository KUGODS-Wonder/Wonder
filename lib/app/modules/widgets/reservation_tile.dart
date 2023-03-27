import 'package:flutter/material.dart';
import 'package:wonder_flutter/app/common/util/exports.dart';
import 'package:wonder_flutter/app/common/values/app_colors.dart';
import 'package:wonder_flutter/app/common/values/styles/app_text_style.dart';
import 'package:wonder_flutter/app/data/models/adapter_models/reservation_model.dart';
import 'package:wonder_flutter/app/data/models/adapter_models/voluntary_walk_model.dart';

class ReservationTile extends StatelessWidget {
  static const String canApplyText = '신청가능';
  static const String maxText = '마감';

  final VoluntaryWalk item;
  final void Function() onTap;
  final double height;

  const ReservationTile({
    Key? key,
    required this.item,
    required this.onTap,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isReservation = item is Reservation;
    String appliedPeopleCount = isReservation ? (item as Reservation).appliedPeopleCount.toString() : '?';
    String maxPeopleCount = isReservation ? (item as Reservation).appliedPeopleCount.toString() : '?';
    bool isFull = isReservation ? appliedPeopleCount == maxPeopleCount : false;
    Color textColor = isFull ? AppColors.middleGrey : AppColors.kPrimary100;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: GestureDetector(
        onTap: isFull ? null : onTap,
        child: Container(
          height: height,
          padding: const EdgeInsets.symmetric(
              horizontal: 12.0),
          decoration: BoxDecoration(
            color: AppColors.faintGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.startDate.formattedDate(),
                          style: AppTextStyle.commonItemTitleStyle),
                      Text('${item.startTime} ~ ${item.endTime}',
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text('$appliedPeopleCount/$maxPeopleCount',
                        style: AppTextStyle.boldStyle.copyWith(
                          color: textColor,
                          fontSize: 13,
                        )
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(isFull ? maxText : canApplyText,
                      style: AppTextStyle.boldStyle.copyWith(
                        color: textColor,
                        fontSize: 11,
                      )
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
