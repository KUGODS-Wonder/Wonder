import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/reservation_list_controller.dart';

class ReservationListView extends GetView<ReservationListController> {
  const ReservationListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReservationListView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ReservationListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
