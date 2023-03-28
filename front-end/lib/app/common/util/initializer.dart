import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:wonder_flutter/app/data/api_helper.dart';
import 'package:wonder_flutter/app/data/api_helper_impl.dart';
import 'package:wonder_flutter/app/data/http_provider.dart';
import 'package:wonder_flutter/app/data/http_provider_dio_impl.dart';
import 'package:wonder_flutter/app/data/interface_controller/api_interface_controller.dart';
import 'package:wonder_flutter/app/data/providers/bookmark_provider.dart';
import 'package:wonder_flutter/app/data/providers/state_providers/profile_state_provider.dart';
import 'package:wonder_flutter/app/data/providers/voluntary_walk_provider.dart';
import 'package:wonder_flutter/app/data/providers/walk_provider.dart';
import 'package:wonder_flutter/app/modules/widgets/custom_error_widget.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

abstract class Initializer {
  static void init(VoidCallback runApp) {
    ErrorWidget.builder = (errorDetails) {
      return CustomErrorWidget(
        message: errorDetails.exceptionAsString(),
      );
    };

    runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();
      FlutterError.onError = (details) {
        FlutterError.dumpErrorToConsole(details);
        Get.printInfo(info: details.stack.toString());
      };

      await _initServices();
      runApp();
    }, (error, stack) {
      Get.printInfo(info: 'runZonedGuarded: ${error.toString()}');
    });
  }

  static Future<void> _initServices() async {
    try {
      await _initStorage();

      _initScreenPreference();
    } catch (err) {
      rethrow;
    }
  }

  static Future<void> _initStorage() async {
    await GetStorage.init();
  }

  static void _initScreenPreference() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiHelper>(
      () => ApiHelperImpl(),
    );

    Get.put<HttpProvider>(HttpProviderDioImpl());
    Get.put<WalkProvider>(WalkProvider());
    Get.put<BookmarkProvider>(BookmarkProvider());
    Get.put<ProfileStateProvider>(ProfileStateProvider());
    Get.put<VoluntaryWalkProvider>(VoluntaryWalkProvider());

    Get.lazyPut<ApiInterfaceController>(
      () => ApiInterfaceController(),
    );
  }
}
