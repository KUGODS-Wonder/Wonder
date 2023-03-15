import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/reservation_model.dart';

class ReservationProvider extends GetConnect {
  static ReservationProvider to = Get.find<ReservationProvider>();

  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Reservation.fromJson(map);
      if (map is List)
        return map.map((item) => Reservation.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Reservation?> getReservation(int id) async {
    final response = await get('reservation/$id');
    return response.body;
  }

  Future<Response<Reservation>> postReservation(
          Reservation reservation) async =>
      await post('reservation', reservation);
  Future<Response> deleteReservation(int id) async =>
      await delete('reservation/$id');

  Future<List<Reservation>> getReservations() async {
    final response = jsonDecode(await rootBundle.loadString('assets/reservation.json'));
    if (response != null) {
      return response.map<Reservation>((json) => Reservation.fromJson(json)).toList();
    } else {
      throw const FileSystemException('Failed to load bookmarks');
    }
  }
}
