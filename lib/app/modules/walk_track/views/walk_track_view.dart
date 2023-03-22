import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/common/values/app_colors.dart';
import 'package:wonder_flutter/app/common/values/styles/app_text_style.dart';
import 'package:wonder_flutter/app/modules/map/controllers/map_controller.dart';
import 'package:wonder_flutter/app/modules/widgets/api_fetch_future_builder.dart';
import 'package:wonder_flutter/app/modules/widgets/app_bottom_navigation_bar.dart';
import 'package:wonder_flutter/app/modules/widgets/colored_button.dart';

import '../controllers/walk_track_controller.dart';

class WalkTrackView extends GetView<WalkTrackController> {
  const WalkTrackView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.askUserWantToExit();
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ApiFetchFutureBuilder(
                    future: controller.getPolyLineCompleter.future,
                    builder: (context, _) {
                      return GoogleMap(
                        mapType: MapType.normal,
                        polylines: controller.polyLines,
                        initialCameraPosition: MapController.initPos,
                        onMapCreated: controller.onMapCreated,
                        onCameraMove: controller.onCameraMove,
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        mapToolbarEnabled: false,
                        tiltGesturesEnabled: false,
                        rotateGesturesEnabled: false,
                        minMaxZoomPreference: const MinMaxZoomPreference(12, 18),
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Constants.defaultHorizontalPadding),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.targetWalk.name,
                            style: AppTextStyle.walkTitle,
                          ),
                          Text(
                            controller.targetWalk.location,
                            style: AppTextStyle.walkAddress,
                          )
                        ],
                      ),
                      ColoredButton(
                        onPressed: controller.askUserWantToExit,
                        child: Text(
                          '취소',
                          style: AppTextStyle.coloredButtonTextStyle,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.extraLightGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Obx(() {
                      return Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 150,
                                child: Text(
                                  controller.timerStringValue.value,
                                  style: AppTextStyle.timerTextStyle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text('남음', style: AppTextStyle.mediumStyle.copyWith(
                                  color: AppColors.black,
                                )),
                              ),
                            ],
                          ),
                          // LinearProgressIndicator(
                          //   value: controller.progress.value,
                          //   minHeight: 20,
                          //   backgroundColor: AppColors.middleGrey,
                          //   valueColor: const AlwaysStoppedAnimation<Color>(AppColors.kPrimary100),
                          // ),
                        ],
                      );
                    }),
                  )
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: AppBottomNavigationBar(),
      ),
    );
  }
}
