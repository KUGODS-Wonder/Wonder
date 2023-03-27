import 'package:get/get.dart';
import 'package:wonder_flutter/app/data/models/adapter_models/reservation_model.dart';
import 'package:wonder_flutter/app/data/providers/reservation_provider.dart';

class ReservationListController extends GetxController {
  final ReservationProvider _reservationProvider = ReservationProvider.to;
  Rx<Future<List<Reservation>>> reservationsFuture = Rx<Future<List<Reservation>>>(
    Future.value([]),
  );

  @override
  void onInit() async {
    super.onInit();
    fetchReservations();
  }

  void fetchReservations() {
    reservationsFuture.value = _reservationProvider.getReservations();
  }

  void onClickCancelReservation(Reservation data) async {
    String? errorMessage;
    var success = await _reservationProvider.deleteReservation(reservationId: data.reservationId).catchError(((error) {
      if (error is String) {
        errorMessage = error;
      } else {
        errorMessage = 'Unknown Error.';
      }
      return false;
    }));

    if (success) {
      Get.snackbar('취소 성공', '성공적으로 취소했습니다.');
      fetchReservations();
    } else {
      Get.snackbar('취소 실패', errorMessage ?? 'Unknown Error.');
    }
  }
}
