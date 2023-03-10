import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/common/values/styles/app_text_style.dart';

class ReservationDialog extends StatelessWidget {
  const ReservationDialog({Key? key}) : super(key: key);

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
                Text(
                  '????????????',
                  style: AppTextStyle.commonTitleStyle,
                ),
              ],
            )
        )
    );
  }
}
