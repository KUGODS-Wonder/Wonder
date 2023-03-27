import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/common/util/google_map_utils.dart';
import 'package:wonder_flutter/app/common/util/utils.dart';
import 'package:wonder_flutter/app/data/models/adapter_models/bookmark_model.dart';
import 'package:wonder_flutter/app/data/models/adapter_models/walk_model.dart';
import 'package:wonder_flutter/app/data/providers/bookmark_provider.dart';
import 'package:wonder_flutter/app/data/providers/state_providers/profile_state_provider.dart';
import 'package:wonder_flutter/app/data/providers/walk_provider.dart';
import 'package:wonder_flutter/app/modules/map/controllers/bookmark_save_control_mixin.dart';
import 'package:wonder_flutter/app/modules/map/controllers/swipe_page_controller_mixin.dart';
import 'package:wonder_flutter/app/modules/widgets/sliding_up_panel.dart';
import 'package:wonder_flutter/app/routes/app_pages.dart';

class MapController extends GetxController
    with GetSingleTickerProviderStateMixin,SwipePageControllerMixin,BookmarkSaveControlMixin {

  static const Duration _slidingDuration = Duration(milliseconds: 500);
  static const CameraPosition initPos = CameraPosition(
    target: LatLng(37.5889938, 127.0292206),
    zoom: Constants.initialZoomLevel,
  );

  final _walkProvider = WalkProvider.to;
  final _bookmarkProvider = BookmarkProvider.to;
  final _profileStateProvider = ProfileStateProvider.to;

  final bookmarkPanelController = SlidingUpPanelController(duration: _slidingDuration);

  final currentIndex = (-1).obs;
  final RxList<Walk> walks = <Walk>[].obs;
  final RxList<Bookmark> bookmarks = <Bookmark>[].obs;
  final RxList<Marker> markers = <Marker>[].obs;

  Rx<Future<List<Bookmark>>> fetchBookmarkFuture = Future.value(<Bookmark>[]).obs;
  bool isBookmarkUpdated = false;

  GoogleMapController? _mapController;
  double zoomVal = Constants.initialZoomLevel;
  LatLng _centerPoint = initPos.target;

  late BitmapDescriptor defaultMarkerIcon;
  int? swipedWalkId;
  bool isMapMovedFromPageReset = false;
  Future<List<Walk>>? _fetchWalksFuture;


  Walk get currentWalk => walks[currentIndex.value];

  int? get getInitPageIndex {
    if (currentIndex.value != -1 && swipedWalkId != null) {
      var foundIndex = _findWalkIndexById(swipedWalkId!);
      if (foundIndex != null) {
        return foundIndex;
      }
    }

    return null;
  }

  @override
  void onInit() async {
    super.onInit();
    await _setDefaultMapMarkerIcon();
  }

  @override
  onClose() async {
    bookmarkPanelController.dispose();

    await _fetchWalksFuture;
    super.onClose();
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void onCameraMove(CameraPosition position) {
    zoomVal = position.zoom;
    _centerPoint = position.target;
  }

  Future<List<Walk>> fetchWalks() async {
    if (_mapController == null) return walks;

    LatLng topLeftPoint = await GoogleMapUtils.getScreenLatLng(_mapController!);

    var radiusInKm = GoogleMapUtils.calculateDistance(topLeftPoint.latitude, topLeftPoint.longitude, _centerPoint.latitude, _centerPoint.longitude);

    var fetchedWalks = await _walkProvider.getWalks(_centerPoint.latitude, _centerPoint.longitude, radiusInKm).catchError((error) {
      if (error is String) {
        Get.snackbar('산책로 조회 실패', error);
      }
      return <Walk>[];
    });

    walks.clear();
    walks.addAll(fetchedWalks);
    getWalksStartingPoints(walks);
    changeIndex(walks.isEmpty ? -1 : 0);
    moveToPage(getInitPageIndex ?? 0);
    isMapMovedFromPageReset = true;
    return walks;
  }

  void fetchBookmarks() async {
    if (isBookmarkUpdated) return;
    var completer = Completer<List<Bookmark>>();
    fetchBookmarkFuture.value = completer.future;
    var x = await _bookmarkProvider.getBookmarks(_centerPoint.latitude, _centerPoint.longitude);

    if (x != null) {
      completer.complete(x);
    } else {
      completer.completeError('북마크 조회 실패');
      return;
    }

    fetchBookmarkFuture.value.then((bookmarkList) {
      bookmarks.clear();
      bookmarks.addAll(bookmarkList);
      isBookmarkUpdated = true;
    }).catchError((error) {
      Get.snackbar('북마크 조회 실패', error.toString());
    });
  }

  void saveThisBookmark() async {
    saveWalkAsBookmark(
      currentWalk,
      onTitleTextEmpty: () {
        Get.snackbar('북마크 저장 실패', '북마크 제목을 입력해주세요.');
      },
      onError: (error) {
        if (error is String) {
          Get.snackbar('북마크 저장 실패', error);
        }
      },
      onSuccess: () {
        isBookmarkUpdated = false;
        Get.snackbar('북마크 저장 성공', '북마크가 저장되었습니다.');
      },
    );
  }

  void deleteBookmark(int id) async {
    bool isSuccess = await _bookmarkProvider.deleteBookmark(bookmarkId: id).catchError((error) {
      if (error is String) {
        Get.snackbar('북마크 삭제 실패', error);
      }
      return false;
    });

    if (isSuccess) {
      isBookmarkUpdated = false;
      fetchBookmarks();
      Get.snackbar('북마크 삭제 성공', '북마크가 삭제되었습니다.');
    }
  }

  void showBookmarkPanel() {
    fetchBookmarks();
    bookmarkPanelController.show();
  }

  void showSaveBookmarkPanel() {
    if (currentIndex.value == -1) return;
    bookmarkSavePanelController.show();
    setBookmarkTitleText(currentWalk.name);
  }


  void getWalksStartingPoints(List<Walk> walks) {
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
      swipedWalkId = currentWalk.id;
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

  void navigateToMapDetailPage() {
    Get.toNamed(Routes.MAP_DETAIL, arguments: {
      'id': currentWalk.id,
      'walk': currentWalk,
      'isEvent': false,
    });
  }

  Future _setDefaultMapMarkerIcon() async {

    final Uint8List markerIcon = await Utils.getBytesFromAsset('assets/images/map_marker.png', 100);
    defaultMarkerIcon =  BitmapDescriptor.fromBytes(markerIcon);
    return;
  }

  int? _findWalkIndexById(int walkId) {
    for (int i = 0; i < walks.length; i++) {
      if (walks[i].id == walkId) {
        return i;
      }
    }
    return null;
  }

  void onCameraIdle() {

    if (isMapMovedFromPageReset) {
      isMapMovedFromPageReset = false;
      return;
    }

    _fetchWalksFuture = fetchWalks();
  }

  void resetSwipeIndex(PointerUpEvent event) {
    swipedWalkId = null;
    isMapMovedFromPageReset = false;
  }

  void moveToThisBookmark(Bookmark bookmark) {
    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              bookmark.walk.coordinate[0].lat,
              bookmark.walk.coordinate[0].lng,
            ),
            zoom: zoomVal,
          )
        )
      );

      isMapMovedFromPageReset = false;
    }
  }

  Future<int> getRequiredWalkLeft(Walk walk) async {
    var profile = await _profileStateProvider.profile;
    var ratingLeft = profile.ratingToNextRank - profile.currentRating;

    return ratingLeft ~/ walk.ratingUp + (ratingLeft % walk.ratingUp != 0 ? 1 : 0);
  }
}
