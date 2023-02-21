import 'package:flutter/material.dart';
import 'package:wonder_flutter/app/common/values/app_colors.dart';
import 'package:wonder_flutter/app/common/values/styles/app_text_style.dart';
import 'package:wonder_flutter/app/common/values/styles/app_walk_theme_style.dart';
import 'package:wonder_flutter/app/data/models/walk_model.dart';
import 'package:wonder_flutter/app/modules/widgets/walk_tag.dart';


class SmallWalkContainer extends StatelessWidget {
  final Walk walk;
  const SmallWalkContainer({Key? key, required this.walk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: 300,
      padding: const EdgeInsets.all(25.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  walk.name ?? 'NO NAMED',
                  style: AppTextStyle.walkTitle,
                ),
                Text(
                  walk.location ?? 'NO LOCATION',
                  style: AppTextStyle.walkAddress,
                ),
                const SizedBox(height: 5.0),
                SizedBox(
                  height: 18.0,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: walk.tags?.length ?? 0,
                    itemBuilder: (context, index) {
                      if (walk.tags != null) {
                        return WalkTag(tag: walk.tags![index]);
                      }
                      return const SizedBox(height: 18.0);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 8.0);
                    }
                  ),
                ),
                const SizedBox(height: 5.0),
                Row(
                  children: [
                    _buildIconItem(
                        'assets/images/increase.png',
                        background: AppColors.faintGrey,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.add_rounded, color: AppColors.middleGrey, size: 14.0),
                            Text(
                              '${walk.ratingUp ?? 0}',
                              style: AppTextStyle.walkIconItemStyle,
                            ),
                          ],
                        )
                    ),
                    const SizedBox(width: 15.0),
                    _buildIconItem(
                        'assets/images/fireworks.png',
                        background: AppColors.reward60,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/walking_person.png',
                              width: 20.0,
                              height: 20.0
                            ),
                            const Icon(Icons.close_rounded, color: AppColors.reward100, size: 14.0),
                            Text(
                              '${walk.requiredWalksLeft ?? 0}',
                              style: AppTextStyle.walkIconItemStyle.copyWith(
                                color: AppColors.reward100,
                              ),
                            ),
                          ],
                        )
                    ),
                  ]
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              AppWalkThemeStyle.getStyle(walk.theme ?? '').path,
              width: 40.0,
              height: 40.0,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${walk.distance ?? 0} m',
                  style: AppTextStyle.walkDescription,
                ),
                Text(
                  '${walk.time ?? 0} 분 소요',
                  style: AppTextStyle.walkDescription,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildButton(
                  onPressed: () {},
                  color: AppColors.white,
                  outlineColor: AppColors.kPrimary100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.bookmark_rounded,
                        color: AppColors.kPrimary100,
                        size: 16.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Text(
                          '저장',
                          style: AppTextStyle.boldStyle.copyWith(
                            color: AppColors.kPrimary100,
                            fontSize: 16.0,
                          ),
                        ),
                      )
                    ]
                  )
                ),
                const SizedBox(width: 10.0),
                _buildButton(
                  onPressed: () {},
                  color: AppColors.kPrimary100,
                  child: Text(
                    '시작',
                    style: AppTextStyle.walkIconItemStyle.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconItem(String path, {
      required Color background,
      Widget? child}) {
    return Container(
      height: 75.0,
      width: 65.0,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            path,
            width: 38.0,
            height: 38.0,
          ),
          child ?? const SizedBox.shrink()
        ],
      ),
    );
  }

  Widget _buildButton({
      required Widget child,
      required Color color,
      required Function() onPressed,
      Color? outlineColor
    }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: color,
        fixedSize: const Size(80.0, 35.0),
        side: BorderSide(color: outlineColor ?? color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: child
    );
  }
}
