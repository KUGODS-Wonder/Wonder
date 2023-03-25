import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/data/errors/api_error.dart';
import 'package:wonder_flutter/app/data/http_provider.dart';
import 'package:wonder_flutter/app/data/models/adapter_models/voluntary_walk_model.dart';
import 'package:wonder_flutter/app/data/models/adapter_models/walk_model.dart';
import 'package:wonder_flutter/app/data/models/voluntary_walk_data_model.dart';
import 'package:wonder_flutter/app/data/providers/walk_provider.dart';

class VoluntaryWalkProvider extends GetConnect {

  static VoluntaryWalkProvider get to => Get.find();

  final HttpProvider _httpProvider = Get.find<HttpProvider>();
  final WalkProvider _walkProvider = Get.find<WalkProvider>();
  bool _hasPendingRequest = false;
  bool _hasPendingDeleteRequest = false;

  @override
  void onInit() {
  }

  Future<List<VoluntaryWalk>?> getVoluntaryWalks() async {
    if (_hasPendingRequest) return null;
    _hasPendingRequest = true;
    String? errorMessage;

    try {
      var response = await _httpProvider.httpGet(Constants.reservationUrl);
      if (response.success) {
        var voluntaryDataList = response.data.map<VoluntaryWalkData>((json) => VoluntaryWalkData.fromJson(json)).toList();
        var bookmarkList = await _parseVoluntaryData(voluntaryDataList);

        _hasPendingRequest = false;
        return bookmarkList;
      } else {
        errorMessage = response.message.isNotEmpty ? response.message : null;
      }
    } on ApiError catch (ae) {
      errorMessage = ae.message;
    } catch (e) {
      errorMessage = 'Unknown Error.';
    }

    _hasPendingRequest = false;
    return Future.error(errorMessage ?? 'Unknown Error.');
  }

  Future<bool> deleteVoluntaryReservation({required int voluntaryWorkId}) async {
    String? errorMessage;
    if (_hasPendingDeleteRequest) return false;
    _hasPendingDeleteRequest = true;

    try {
      var response = await _httpProvider.httpDelete('${Constants.reservationDeleteUrl}/$voluntaryWorkId');
      if (response.success) {
        _hasPendingDeleteRequest = false;
        return true;
      } else {
        errorMessage = response.message.isNotEmpty ? response.message : null;
      }
    } on ApiError catch (ae) {
      errorMessage = ae.message;
    } catch (e) {
      errorMessage = 'Unknown Error.';
    }

    _hasPendingDeleteRequest = false;
    return Future.error(errorMessage ?? 'Unknown Error.');
  }

  Future<List<VoluntaryWalk>> _parseVoluntaryData(List<VoluntaryWalkData> voluntaryDataList) async {
    var voluntaryWalkList = <VoluntaryWalk>[];
    List<Future<Walk?>> futures = [];

    for (VoluntaryWalkData data in voluntaryDataList) {
      futures.add(_walkProvider.getWalk(data.walkId));
    }

    var walks = await Future.wait(futures);
    for (int i = 0; i < walks.length; i++) {
      if (walks[i] != null) {
        voluntaryWalkList.add(VoluntaryWalk.fromData(voluntaryDataList[i], walks[i]!));
      }
    }
    voluntaryWalkList.sort((a, b) => a.id.compareTo(b.id));
    return voluntaryWalkList;
  }
}
