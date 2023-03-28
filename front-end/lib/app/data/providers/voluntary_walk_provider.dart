import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/data/enums/walk_type_enum.dart';
import 'package:wonder_flutter/app/data/errors/api_error.dart';
import 'package:wonder_flutter/app/data/http_provider.dart';
import 'package:wonder_flutter/app/data/models/adapter_models/voluntary_walk_model.dart';
import 'package:wonder_flutter/app/data/models/adapter_models/walk_model.dart';
import 'package:wonder_flutter/app/data/models/voluntary_walk_data_model.dart';
import 'package:wonder_flutter/app/data/providers/walk_provider.dart';

class VoluntaryWalkProvider extends GetLifeCycle {

  static const Map<String, WalkType> themeToWalkTypeMap = {
    '도시락 배달 봉사': WalkType.elderlyDeliverWalk,
    '유기견 산책': WalkType.dogWalk,
  };
  static VoluntaryWalkProvider get to => Get.find();

  final HttpProvider _httpProvider = Get.find<HttpProvider>();
  final WalkProvider _walkProvider = Get.find<WalkProvider>();
  Future<List<VoluntaryWalk>>? pendingRequest;
  bool _hasPendingPostRequest = false;

  @override
  void onInit() {
  }


  Future<Map<WalkType, List<VoluntaryWalk>>> getVoluntaryWalksClassifiedByType() async {
    var voluntaryWalks = await getVoluntaryWalks().catchError(((error) {
      return <VoluntaryWalk>[];
    }));
    Map<WalkType, List<VoluntaryWalk>> voluntaryWalksByType = {};
    for (String theme in themeToWalkTypeMap.keys) {
      voluntaryWalksByType[themeToWalkTypeMap[theme]!] = <VoluntaryWalk>[];
    }

    for (VoluntaryWalk walk in voluntaryWalks) {
      var type = themeToWalkTypeMap[walk.theme] ?? WalkType.unknown;
      if (!voluntaryWalksByType.containsKey(type)) {
        voluntaryWalksByType[type] = <VoluntaryWalk>[];
      }
      voluntaryWalksByType[type]?.add(walk);
    }

    return voluntaryWalksByType;
  }

  Future<List<VoluntaryWalk>> getVoluntaryWalks() async {
    // if (_hasPendingRequest) return Future.error('Request is already in progress.');
    // _hasPendingRequest = true;
    String? errorMessage;

    try {
      var response = await _httpProvider.httpGet(Constants.reservationUrl);
      if (response.success) {
        var voluntaryDataList = response.data.map<VoluntaryWalkData>((json) => VoluntaryWalkData.fromJson(json)).toList();
        var bookmarkList = await _parseVoluntaryData(voluntaryDataList);

        // _hasPendingRequest = false;
        return bookmarkList;
      } else {
        errorMessage = response.message.isNotEmpty ? response.message : null;
      }
    } on ApiError catch (ae) {
      errorMessage = ae.message;
    } catch (e) {
      errorMessage = 'Unknown Error.';
    }

    // _hasPendingRequest = false;
    return Future.error(errorMessage ?? 'Unknown Error.');
  }

  Future<int?> requestReservation({required int voluntaryWorkId}) async {
    String? errorMessage;
    if (_hasPendingPostRequest) return null;
    _hasPendingPostRequest = true;

    try {
      var response = await _httpProvider.httpPost('${Constants.reservationUrl}/$voluntaryWorkId', {});
      if (response.success) {
        _hasPendingPostRequest = false;
        return response.data['reservationId'];
      } else {
        errorMessage = response.message.isNotEmpty ? response.message : null;
      }
    } on ApiError catch (ae) {
      errorMessage = ae.message;
    } catch (e) {
      errorMessage = 'Unknown Error.';
    }

    _hasPendingPostRequest = false;
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
