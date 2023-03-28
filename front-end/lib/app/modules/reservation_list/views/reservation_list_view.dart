import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/common/values/styles/app_text_style.dart';
import 'package:wonder_flutter/app/data/models/adapter_models/reservation_model.dart';
import 'package:wonder_flutter/app/modules/widgets/api_fetch_future_builder.dart';
import 'package:wonder_flutter/app/modules/widgets/app_bottom_navigation_bar.dart';
import 'package:wonder_flutter/app/modules/widgets/colored_button.dart';
import 'package:wonder_flutter/app/modules/widgets/reservation_tile.dart';

import '../controllers/reservation_list_controller.dart';

class ReservationListView extends GetView<ReservationListController> {
  static const double height = 80.0;

  const ReservationListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.defaultHorizontalPadding,
            vertical: Constants.defaultVerticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reservations',
                style: AppTextStyle.profileTitlesStyle,
              ),
              Expanded(
                child: Obx(() {
                    return ApiFetchFutureBuilder<List<Reservation>>(
                      future: controller.reservationsFuture.value,
                      builder: (context, data) {
                        return ListView.builder(
                          itemCount: data!.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Expanded(
                                  child: ReservationTile(
                                    item: data[index],
                                    onTap: () {},
                                    height: height
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                SizedBox(
                                  height: height,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ColoredButton(
                                        fixedSize: const Size(30, 30),
                                        onPressed: () {
                                          controller.onClickCancelReservation(data[index]);
                                        },
                                        child: Text(
                                          '취소',
                                          style: AppTextStyle.coloredButtonTextStyle.copyWith(
                                            fontSize: 16,
                                          ),
                                        )
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      }
                    );
                  }
                )
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavigationBar(),
    );
  }
}
