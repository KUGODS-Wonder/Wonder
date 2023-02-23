import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/data/models/walk_model.dart';
import 'package:wonder_flutter/app/data/providers/walk_provider.dart';
import 'package:wonder_flutter/app/modules/map/controllers/swipe_page_controller_mixin.dart';
import 'package:wonder_flutter/app/routes/app_pages.dart';

class MapController extends GetxController with GetSingleTickerProviderStateMixin,SwipePageControllerMixin {
  final WalkProvider _walkProvider = WalkProvider.to;

  static const CameraPosition initPos = CameraPosition(
    target: LatLng(37.5889938, 127.0292206),
    zoom: Constants.initialZoomLevel,
  );

  final currentIndex = (-1).obs;
  final RxList<Walk> walks = <Walk>[].obs;

  GoogleMapController? _mapController;
  double zoomVal = Constants.initialZoomLevel;
  late BitmapDescriptor defaultMarkerIcon;

  RxList<Marker> markers = <Marker>[].obs;

  Walk get currentWalk => walks[currentIndex.value];

  @override
  void onInit() async {
    super.onInit();
    _addDefaultMapMarkerIcon();
    fetchWalks();
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
  }

  void onCameraMove(CameraPosition position) {
    zoomVal = position.zoom;
  }

  void fetchWalks() async {
    walks.clear();
    walks.addAll(await _walkProvider.getWalks());
    getWalksStartingPoints();
    changeIndex(walks.isEmpty ? -1 : 0);
  }

  void getWalksStartingPoints() {
    markers.clear();
    for (Walk walk in walks) {
      markers.add(Marker(
        markerId: MarkerId(walk.id.toString()),
        position: LatLng(walk.coordinate![0].lat, walk.coordinate![0].lng),
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
              walks[index].coordinate![0].lat,
              walks[index].coordinate![0].lng,
            ),
            zoom: zoomVal,
          )
        )
      );
    }
  }
  void onMapTap(LatLng argument) {
    print('onMapTap: $argument');
    fetchWalks();
  }

  void onStartButtonPressed() {
    Get.toNamed(Routes.MAP_DETAIL, arguments: {
      'id': currentWalk.id,
      'walk': currentWalk,
    });
    // Navigator.of(Get.context!).pushNamed('/map_detail', arguments: currentWalk);
  }

  void _addDefaultMapMarkerIcon() async {
    defaultMarkerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/images/map_marker.png',
    );
  }

}
