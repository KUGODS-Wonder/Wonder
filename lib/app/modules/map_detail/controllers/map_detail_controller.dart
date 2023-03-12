import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/common/util/exports.dart';
import 'package:wonder_flutter/app/common/values/styles/app_walk_theme_style.dart';
import 'package:wonder_flutter/app/data/models/walk_model.dart';
import 'package:wonder_flutter/app/data/providers/reservation_provider.dart';
import 'package:wonder_flutter/app/modules/map_detail/views/readme_dialog.dart';
import 'package:wonder_flutter/app/modules/map_detail/views/reservation_dialog.dart';
import 'package:wonder_flutter/app/routes/app_pages.dart';

class MapDetailController extends GetxController {
  static const Duration _waitTime = Duration(milliseconds: 300);
  final ReservationProvider _reservationProvider = ReservationProvider.to;
  GoogleMapController? _mapController;
  double zoomVal = Constants.initialZoomLevel;
  bool isEvent = false;
  Completer<Set<Polyline>> getPolyLineCompleter = Completer<Set<Polyline>>();

  var isDetailMode = false.obs;

  late Walk targetWalk;
  late Color polylineColor;
  var polyLines = <Polyline>{}.obs;

  get eventMedalImagePath => isEvent ? AppWalkThemeStyle.getStyle(targetWalk.theme!).associatedMedalImagePath : null;

  @override
  void onInit() {
    targetWalk = Get.arguments['walk'];
    isEvent = Get.arguments['isEvent'] ?? false;

    polylineColor = isEvent ? AppColors.kPrimary100 : AppColors.kPrimary80;
    super.onInit();
  }

  @override
  void onReady() async {
    await Future.delayed(_waitTime).then((value) {
      isDetailMode.value = true;
    });

    polyLines.clear();
    polyLines.add(Polyline(
      polylineId: PolylineId(targetWalk.id.toString()),
      visible: true,
      points: targetWalk.coordinate!.map((c) => LatLng(c.lat, c.lng)).toList(),
      width: 5,
      color: polylineColor,
    ));

    getPolyLineCompleter.complete(polyLines);
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    var coords = targetWalk.coordinate!;
    var midLat = (coords.first.lat + coords.last.lat) / 2;
    var midLng = (coords.first.lng + coords.last.lng) / 2;

    _mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(midLat, midLng),
          zoom: zoomVal,
        ),
      )
    );
  }

  void onCameraMove(CameraPosition position) {
    zoomVal = position.zoom;
  }

  void onStartButtonPressed() async {
    if (isEvent) {
      _onEventButtonPressed();
    }
  }

  void _onEventButtonPressed() async {
    var accepted = await Get.dialog<bool>(
        const ReadmeDialog(
          message: Strings.readmeDialogDescription,
          buttonMessage: Strings.readmeDialogButtonMessage,
        )
    );

    if (accepted != null && accepted) {
      var chosenItem = await Get.dialog(ReservationDialog(
        possibleReservations: await _reservationProvider.getReservations(),
        bottomMessage: Strings.readmeDialogDescription,
      ));

      if (chosenItem != null) {
        await Future.delayed(const Duration(milliseconds: 500));

        Random random = Random();
        var x = random.nextBool();
        if (x) {
          Get.snackbar(Strings.reservationSuccessTitle, Strings.reservationSuccessMessage);
          Get.offNamed(Routes.RESERVATION_LIST);
        } else {
          Get.snackbar(Strings.reservationFailTitle, Strings.reservationFailMessage);
        }
      }
    }
  }
}
