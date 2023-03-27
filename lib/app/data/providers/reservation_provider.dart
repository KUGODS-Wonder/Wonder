import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/data/errors/api_error.dart';
import 'package:wonder_flutter/app/data/http_provider.dart';
import 'package:wonder_flutter/app/data/models/adapter_models/voluntary_walk_model.dart';
import 'package:wonder_flutter/app/data/models/reservation_data_model.dart';
import 'package:wonder_flutter/app/data/providers/voluntary_walk_provider.dart';

import '../models/adapter_models/reservation_model.dart';

class ReservationProvider extends GetConnect {
  static ReservationProvider to = Get.find<ReservationProvider>();
  final HttpProvider _httpProvider = Get.find<HttpProvider>();
  final VoluntaryWalkProvider _voluntaryWalkProvider = Get.find<VoluntaryWalkProvider>();

  bool _hasPendingDeleteRequest = false;

  @override
  void onInit() {
    super.onInit();
  }

  Future<List<Reservation>> getReservations() async {
    String? errorMessage;

    try {
      var response = await _httpProvider.httpGet(Constants.reservationReadUrl);
      if (response.success) {
        var voluntaryWalks = await _voluntaryWalkProvider.getVoluntaryWalks();
        var walkIdMap = <int, VoluntaryWalk>{};

        for (VoluntaryWalk walk in voluntaryWalks) {
          walkIdMap[walk.voluntaryWorkId] = walk;
        }

        var reservationDataList = response.data.map<ReservationData>((json) => ReservationData.fromJson(json)).toList();
        var reservationList = await _parseReservationData(reservationDataList, walkIdMap);

        return reservationList;
      } else {
        errorMessage = response.message.isNotEmpty ? response.message : null;
      }
    } on ApiError catch (ae) {
      errorMessage = ae.message;
    } catch (e) {
      errorMessage = 'Unknown Error.';
    }

    return Future.error(errorMessage ?? 'Unknown Error.');
  }

  Future<bool> deleteReservation({required int reservationId}) async {
    String? errorMessage;
    if (_hasPendingDeleteRequest) return false;
    _hasPendingDeleteRequest = true;

    try {
      var response = await _httpProvider.httpDelete('${Constants.reservationDeleteUrl}/$reservationId');
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

  Future<List<Reservation>> _parseReservationData(List<ReservationData> voluntaryDataList,Map<int, VoluntaryWalk> idMap) async {
    var reservationList = <Reservation>[];

    for (ReservationData data in voluntaryDataList) {
      reservationList.add(Reservation.fromData(data, idMap[data.voluntaryWorkId]!));
    }

    return reservationList;
  }
}
