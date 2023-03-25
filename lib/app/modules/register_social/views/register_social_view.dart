import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_social_controller.dart';

class RegisterSocialView extends GetView<RegisterSocialController> {
  const RegisterSocialView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RegisterSocialView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RegisterSocialView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
