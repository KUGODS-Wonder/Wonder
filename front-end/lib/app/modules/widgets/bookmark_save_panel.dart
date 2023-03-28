import 'package:flutter/material.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/common/values/app_colors.dart';
import 'package:wonder_flutter/app/common/values/styles/app_text_style.dart';
import 'package:wonder_flutter/app/modules/widgets/sliding_up_panel.dart';

class BookmarkSavePanel extends StatelessWidget {
  final SlidingUpPanelController controller;
  final TextEditingController titleTextController;
  final TextEditingController descriptionTextController;
  final void Function()? onButtonPressed;

  const BookmarkSavePanel({
    Key? key,
    required this.controller,
    required this.titleTextController,
    required this.descriptionTextController,
    this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      slidingUpPanelController: controller,
      ratio: 0.35,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Constants.defaultHorizontalPadding),
        child: LayoutBuilder(
            builder: (context, constraints) {
              return ListView(
                children: [
                  _buildBookmarkSaveTextField(
                      textController: titleTextController,
                      hintText: '저장할 이름을 입력하세요'
                  ),
                  _buildBookmarkSaveTextField(
                      textController: descriptionTextController,
                      hintText: '설명을 입력하세요'
                  ),
                  OutlinedButton(
                    onPressed: onButtonPressed,
                    style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        fixedSize: Size(constraints.maxWidth, 35.0),
                        side: const BorderSide(color: AppColors.kPrimary100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )
                    ),
                    child: Text(
                        '저장',
                        style: AppTextStyle.boldStyle.copyWith(
                          color: AppColors.kPrimary100,
                          fontSize: 16.0,
                        )
                    ),
                  ),
                ],
              );
            }
        ),
      ),
    );
  }

  Widget _buildBookmarkSaveTextField({
    required TextEditingController textController,
    required String hintText,
  }) {
    return TextField(
      controller: textController,
      style: AppTextStyle.mediumStyle.copyWith(
        color: AppColors.black,
      ),
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        hintText: hintText,
        hintStyle: AppTextStyle.lightStyle.copyWith(
          color: AppColors.lightGrey,
        ),
      ),
    );
  }
}
