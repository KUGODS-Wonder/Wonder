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

  Rx<Future<List<Bookmark>>> fetchBookmarkFuture = Future.value(<Bookmark>[]).obs;
  bool isBookmarkUpdated = false;

  GoogleMapController? _mapController;
  double zoomVal = Constants.initialZoomLevel;
  LatLng _centerPoint = initPos.target;
  Timer? _debounce;

  late BitmapDescriptor defaultMarkerIcon;
  int? swipedWalkId;
  bool isMapMovedFromPageReset = false;


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

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void onCameraMove(CameraPosition position) {
    zoomVal = position.zoom;
    _centerPoint = position.target;
  }

  void fetchWalks() async {
    if (_mapController == null) return;

    LatLng topLeftPoint = await GoogleMapUtils.getScreenLatLng(_mapController!);
    // printInfo(info: 'topLeftLat: ${topLeftPoint.latitude}, topLeftLng: ${topLeftPoint.longitude}');

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
    var bookmarkList = await fetchBookmarkFuture.value;
    if (bookmarkList != null) {
      bookmarks.clear();
      bookmarks.addAll(bookmarkList);
    }
    isBookmarkUpdated = true;
  }

  void saveThisBookmark() async {
    if (bookmarkTitleTextController.text.isEmpty) {
      Get.snackbar('북마크 저장 실패', '북마크 제목을 입력해주세요.');
      return;
    }

    bool isSuccess = await _bookmarkProvider.saveBookmark(
      walkId: currentWalk.id,
      title: bookmarkTitleTextController.text,
      contents: bookmarkDescriptionTextController.text,
    ).catchError((error) {
      if (error is String) {
        Get.snackbar('북마크 저장 실패', error);
      }
      return false;
    });

    if (isSuccess) {
      isBookmarkUpdated = false;
      Get.snackbar('북마크 저장 성공', '북마크가 저장되었습니다.');
    }
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
    bookmarkTitleTextController.text = currentWalk.name;
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

    fetchWalks();
    if (_debounce != null && _debounce!.isActive) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // fetchWalks();
      _debounce = null;
    });
  }

  void resetSwipeIndex(PointerUpEvent event) {
    swipedWalkId = null;
    isMapMovedFromPageReset = false;
  }
}
