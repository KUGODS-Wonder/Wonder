import 'dart:async';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/common/util/exports.dart';
import 'package:wonder_flutter/app/common/values/styles/app_walk_theme_style.dart';
import 'package:wonder_flutter/app/data/models/adapter_models/voluntary_walk_model.dart';
import 'package:wonder_flutter/app/data/models/adapter_models/walk_model.dart';
import 'package:wonder_flutter/app/data/models/coordinate_model.dart';
import 'package:wonder_flutter/app/data/providers/state_providers/profile_state_provider.dart';
import 'package:wonder_flutter/app/data/providers/voluntary_walk_provider.dart';
import 'package:wonder_flutter/app/modules/map/controllers/bookmark_save_control_mixin.dart';
import 'package:wonder_flutter/app/modules/map_detail/views/readme_dialog.dart';
import 'package:wonder_flutter/app/modules/map_detail/views/reservation_dialog.dart';
import 'package:wonder_flutter/app/routes/app_pages.dart';

class MapDetailController extends GetxController with BookmarkSaveControlMixin {
  static const Duration _waitTime = Duration(milliseconds: 300);
  final VoluntaryWalkProvider _voluntaryWalkProvider = VoluntaryWalkProvider.to;
  final ProfileStateProvider _profileStateProvider = ProfileStateProvider.to;
  GoogleMapController? _mapController;
  double zoomVal = Constants.initialZoomLevel;
  bool isEvent = false;
  bool _hasPendingRequest = false;
  Completer<Set<Polyline>> getPolyLineCompleter = Completer<Set<Polyline>>();
  CancelableOperation? _cancelableOperation;

  var isDetailMode = false.obs;

  late Walk targetWalk;
  late Color polylineColor;
  var polyLines = <Polyline>{}.obs;

  get eventMedalImagePath => isEvent ? AppWalkThemeStyle.getStyle(targetWalk.theme).associatedMedalImagePath : null;

  @override
  void onInit() {
    targetWalk = Get.arguments['walk'];
    isEvent = Get.arguments['isEvent'] ?? false;

    polylineColor = isEvent ? AppColors.kPrimary100 : AppColors.kPrimary80;
    super.onInit();
  }

  @override
  void onReady() async {

    if (!isEvent) {
      await Future.delayed(_waitTime);
    }
    isDetailMode.value = true;

    polyLines.clear();
    polyLines.add(Polyline(
      polylineId: PolylineId(targetWalk.id.toString()),
      visible: true,
      points: targetWalk.coordinate.map((c) => LatLng(c.lat, c.lng)).toList(),
      width: 5,
      color: polylineColor,
    ));

    getPolyLineCompleter.complete(polyLines);
    super.onReady();
  }

  @override
  void onClose() {
    _cancelableOperation?.cancel();
    super.onClose();
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    var coords = targetWalk.coordinate;
    var bounds = _createBounds(coords);
    Future.delayed(const Duration(milliseconds: 500), () {
      _mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    });
  }

  void onCameraMove(CameraPosition position) {
    zoomVal = position.zoom;
  }

  void onStartButtonPressed() async {
    if (isEvent) {
      if (_hasPendingRequest) {
        return;
      }
      _hasPendingRequest = true;
      _cancelableOperation = CancelableOperation.fromFuture(_onEventButtonPressed());
      await _cancelableOperation!.valueOrCancellation(null);
      _hasPendingRequest = false;
    } else {
      Get.toNamed(Routes.WALK_TRACK, arguments: {
        'walk': targetWalk,
        'isEvent': false,
      });
    }
  }

  Future _onEventButtonPressed() async {
    var accepted = await Get.dialog<bool>(
        const ReadmeDialog(
          message: Strings.readmeDialogDescription,
          buttonMessage: Strings.readmeDialogButtonMessage,
        )
    );

    if (accepted != null && accepted) {
      var map = await _voluntaryWalkProvider.getVoluntaryWalksClassifiedByType();
      var chosenItem = await Get.dialog<VoluntaryWalk?>(ReservationDialog(
        possibleReservations: map[VoluntaryWalkProvider.themeToWalkTypeMap[targetWalk.theme]!]!,
        bottomMessage: Strings.readmeDialogDescription,
      ));

      if (chosenItem != null) {
        var reservationId = await _voluntaryWalkProvider.requestReservation(voluntaryWorkId: chosenItem.voluntaryWorkId).catchError((error) {
          Get.snackbar(Strings.reservationFailTitle, Strings.reservationFailMessage);
          return null;
        });

        if (reservationId == null) {
          return;
        }

        Get.snackbar(Strings.reservationSuccessTitle, Strings.reservationSuccessMessage);
        Get.offNamed(Routes.RESERVATION_LIST);
      }
    }
  }

  LatLngBounds _createBounds(List<Coordinate> positions) {
    final southwestLat = positions.map((p) => p.lat).reduce((value, element) => value < element ? value : element); // smallest
    final southwestLon = positions.map((p) => p.lng).reduce((value, element) => value < element ? value : element);
    final northeastLat = positions.map((p) => p.lat).reduce((value, element) => value > element ? value : element); // biggest
    final northeastLon = positions.map((p) => p.lng).reduce((value, element) => value > element ? value : element);
    return LatLngBounds(
        southwest: LatLng(southwestLat, southwestLon),
        northeast: LatLng(northeastLat, northeastLon)
    );
  }

  void saveWalk() {
    bookmarkSavePanelController.show();
    setBookmarkTitleText(targetWalk.name);
  }

  void saveThisBookmark() {
    saveWalkAsBookmark(
      targetWalk,
      onTitleTextEmpty: () {
        Get.snackbar('북마크 저장 실패', '북마크 제목을 입력해주세요.');
      },
      onError: (error) {
        if (error is String) {
          Get.snackbar('북마크 저장 실패', error);
        }
      },
      onSuccess: () {
        Get.snackbar('북마크 저장 성공', '북마크가 저장되었습니다.');
      },
    );
  }

  Future<int> getRequiredWalkLeft() async {
    var profile = await _profileStateProvider.profile;
    var ratingLeft = profile.ratingToNextRank - profile.currentRating;

    return ratingLeft ~/ targetWalk.ratingUp + (ratingLeft % targetWalk.ratingUp != 0 ? 1 : 0);
  }
}
