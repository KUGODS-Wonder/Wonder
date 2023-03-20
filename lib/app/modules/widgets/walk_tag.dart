import 'package:flutter/material.dart';
import 'package:wonder_flutter/app/common/util/exports.dart';
import 'package:wonder_flutter/app/common/values/styles/app_walk_tag_style.dart';
import 'package:wonder_flutter/app/data/models/tag_model.dart';


class WalkTag extends StatelessWidget {
  final Tag tag;
  final double? height;
  final WalkTagStyleModel style;

  WalkTag({Key? key, required this.tag, this.height})
      : style = AppWalkTagStyle.getStyle(tag.name), super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 18.0,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(3.0, 0.0, 3.0, 2.0),
        decoration: BoxDecoration(
          color: style.backgroundColor,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Text(
          tag.name,
          textAlign: TextAlign.center,
          style: AppTextStyle.regularStyle.copyWith(
            fontSize: 12.0,
            color: style.fontColor,
          ),
        )
      ),
    );
  }
}
