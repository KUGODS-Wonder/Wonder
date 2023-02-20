import 'package:flutter/material.dart';
import 'package:wonder_flutter/app/common/values/app_colors.dart';
import 'package:wonder_flutter/app/common/values/styles/app_text_style.dart';
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
              ],
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
          )
        ],
      ),
    );
  }
}
