import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/common/values/styles/app_text_style.dart';
import 'package:wonder_flutter/app/modules/widgets/colored_button.dart';

class ReadmeDialog extends StatelessWidget {
  final String message;
  final String buttonMessage;
  const ReadmeDialog({
    Key? key,
    required this.message,
    required this.buttonMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(Constants.defaultHorizontalPadding),
      child: Container(
        height: Get.height * 0.25,
        padding: const EdgeInsets.symmetric(
          vertical: Constants.defaultVerticalPadding,
          horizontal: Constants.defaultHorizontalPadding
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '꼭 읽어주세요',
              style: AppTextStyle.commonTitleStyle,
            ),
            Text(
              message,
              style: AppTextStyle.commonCaptionStyle.copyWith(
                color: Colors.black,
              ),
            ),
            Center(
              child: ColoredButton(
                onPressed: () {
                  Get.back(result: true);
                },
                child: Text(
                  buttonMessage,
                  style: AppTextStyle.commonCaptionStyle.copyWith(
                    color: Colors.white,
                  ),
                ),
              )
            )
          ],
        )
      )
    );
  }
}
