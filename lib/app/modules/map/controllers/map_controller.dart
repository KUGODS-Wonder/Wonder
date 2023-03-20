import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/common/util/utils.dart';
import 'package:wonder_flutter/app/data/models/adapter_models/bookmark_model.dart';
import 'package:wonder_flutter/app/data/models/adapter_models/walk_model.dart';
import 'package:wonder_flutter/app/data/providers/bookmark_provider.dart';
import 'package:wonder_flutter/app/data/providers/walk_provider.dart';
import 'package:wonder_flutter/app/modules/map/controllers/swipe_page_controller_mixin.dart';
import 'package:wonder_flutter/app/modules/widgets/sliding_up_panel.dart';
import 'package:wonder_flutter/app/routes/app_pages.dart';

class MapController extends GetxController with GetSingleTickerProviderStateMixin,SwipePageControllerMixin {

  static const Duration _slidingDuration = Duration(milliseconds: 500);
  static const CameraPosition initPos = CameraPosition(
    target: LatLng(37.5889938, 127.0292206),
    zoom: Constants.initialZoomLevel,
  );

  final _walkProvider = WalkProvider.to;
  final _bookmarkProvider = BookmarkProvider.to;
  final bookmarkPanelController = SlidingUpPanelController(duration: _slidingDuration);
  final bookmarkSavePanelController = SlidingUpPanelController(duration: _slidingDuration);
  final bookmarkTitleTextController = TextEditingController();
  final bookmarkDescriptionTextController = TextEditingController();

  final currentIndex = (-1).obs;
  final RxList<Walk> walks = <Walk>[].obs;
  final RxList<Bookmark> bookmarks = <Bookmark>[].obs;
  final RxList<Marker> markers = <Marker>[].obs;

  GoogleMapController? _mapController;
  double zoomVal = Constants.initialZoomLevel;
  LatLng _centerPoint = initPos.target;
  Timer? _debounce;

  late BitmapDescriptor defaultMarkerIcon;


  Walk get currentWalk => walks[currentIndex.value];

  @override
  void onInit() async {
    super.onInit();
    await _setDefaultMapMarkerIcon();
    fetchBookmarks();
    // fetchWalks();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    Future.delayed(const Duration(milliseconds: 500), () {
      fetchWalks();
    });
  }

  void onCameraMove(CameraPosition position) {
    zoomVal = position.zoom;
    _centerPoint = position.target;
  }

  void fetchWalks() async {
    if (_mapController == null) return;
    walks.clear();

    ScreenCoordinate screenCoordinate = const ScreenCoordinate(x: 0, y: 0);
    LatLng topLeftPoint = await _mapController!.getLatLng(screenCoordinate);
    double latRadius = topLeftPoint.latitude - _centerPoint.latitude;
    double lngRadius = _centerPoint.longitude - topLeftPoint.longitude;
    printInfo(info: 'latRadius: $latRadius, lngRadius: $lngRadius');
    printInfo(info: 'topLeftLat: ${topLeftPoint.latitude}, topLeftLng: ${topLeftPoint.longitude}');
    printInfo(info: 'centerLat: ${_centerPoint.latitude}, centerLng: ${_centerPoint.longitude}');

    var radiusInKm = Utils.calculateDistance(topLeftPoint.latitude, topLeftPoint.longitude, _centerPoint.latitude, _centerPoint.longitude);

    await _walkProvider.getWalks(_centerPoint.latitude, _centerPoint.longitude, radiusInKm).catchError((error) {
      if (error is String) {
        Get.snackbar('산책로 조회 실패', error);
      }
      return <Walk>[];
    }).then((value) {
      walks.addAll(value);
    });
    getWalksStartingPoints();
    changeIndex(walks.isEmpty ? -1 : 0);
  }

  void fetchBookmarks() async {
    bookmarks.clear();
    bookmarks.addAll(await _bookmarkProvider.getBookmarks());
  }

  void showSaveBookmarkPanel() {
    if (currentIndex.value == -1) return;
    bookmarkSavePanelController.show();
  }

  void getWalksStartingPoints() {
    markers.clear();
    for (Walk walk in walks) {
      markers.add(Marker(
        markerId: MarkerId(walk.id.toString()),
        position: LatLng(walk.coordinate[0].lat, walk.coordinate[0].lng),
        icon: defaultMarkerIcon,
        onTap: () {
          changeIndex(walks.indexOf(walk));
        }
      ));

      update();
    }
  }

  void changeIndex(int index) {
    if (index < walks.length) {
      if (currentIndex.value != index) {
        currentIndex.value = index;

        if (index != -1) {
          moveToPage(index);
        }
      }
    }
  }

  @override
  void onSwipe(int index) {
    changeIndex(index);
    if (_mapController != null && -1 < index && index < walks.length) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              walks[index].coordinate[0].lat,
              walks[index].coordinate[0].lng,
            ),
            zoom: zoomVal,
          )
        )
      );
    }
  }

  void onMapTap(LatLng argument) {
    fetchWalks();
  }

  void onStartButtonPressed() {
    Get.toNamed(Routes.MAP_DETAIL, arguments: {
      'id': currentWalk.id,
      'walk': currentWalk,
      'isEvent': false,
    });
  }

  void onSaveButtonPressed() {
    bookmarkSavePanelController.show();
    bookmarkTitleTextController.text = currentWalk.name;
  }

  Future _setDefaultMapMarkerIcon() async {

    final Uint8List markerIcon = await Utils.getBytesFromAsset('assets/images/map_marker.png', 100);
    defaultMarkerIcon =  BitmapDescriptor.fromBytes(markerIcon);
    return;
  }

  void onCameraMoveStarted() {

  }

  void onCameraIdle() {
    if (_debounce != null && _debounce!.isActive) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      fetchWalks();
    });
  }
}
