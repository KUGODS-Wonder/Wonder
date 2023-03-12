import 'package:get/get.dart';
import 'package:wonder_flutter/app/data/models/reservation_model.dart';
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

  }
}
