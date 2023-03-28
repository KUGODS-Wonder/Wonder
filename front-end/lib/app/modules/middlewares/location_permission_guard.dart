import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPermissionGuard {

  static const androidAlertDialog = AlertDialog(
    title: Text('위치 권한이 허용되지 않았습니다.'),
    content: Text('설정 -> 앱에서 위치 권한을\n \'항상 허용\'으로 해 주십시오.'),
  );

  static const iOSAlertDialog = AlertDialog(
    title: Text('위치 권한이 허용되지 않았습니다.'),
    content: Text('위치 권한을 \'항상 허용\'으로 해 주십시오.'),
  );

  static const iOSPermanentlyDeniedDialog = AlertDialog(
    title: Text('항상 위치 권한이 허용되지 않았습니다.'),
    content: Text('위치 권한을 설정에서 허용해 주십시오.\n앱이 정상적으로 작동하지 않을 수 있습니다.'),
  );

  static Future<bool> checkLocationPermissions() async {
    var locationPermission = await checkLocationPermission();

    if (!locationPermission) {

      if (GetPlatform.isAndroid) {
        await Get.dialog(androidAlertDialog);
        if (await Permission.location.isDenied) {
          await openAppSettings();
        }

      } else if (GetPlatform.isIOS) {
        Get.dialog(
            iOSAlertDialog,
        );
      }

      return false;
    }

    var locationAlwaysPermission = await checkLocationAlwaysPermission();

    if (!locationAlwaysPermission) {

      if (GetPlatform.isAndroid) {
        await Get.dialog(androidAlertDialog);
        if (await Permission.location.isDenied) {
          await openAppSettings();
        }
      } else if (GetPlatform.isIOS) {
        Get.dialog(
            iOSAlertDialog,
        );
      }

      return false;
    } else {
      return true;
    }
  }

  static Future<bool> checkLocationPermission() async {
    var status = await Permission.location.status;

    if (status != PermissionStatus.granted) {
      if(await Permission.location.request().isGranted == false) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  static Future<bool> checkLocationAlwaysPermission() async {
    var status = await Permission.locationAlways.status;

    if (status == PermissionStatus.permanentlyDenied && GetPlatform.isIOS) {
      // await openAppSettings();
      if (await Permission.locationAlways.status != PermissionStatus.granted) {
        Get.dialog(iOSPermanentlyDeniedDialog);
        return true;
      } else {
        return true;
      }
    } else if (status != PermissionStatus.granted) {
      if(await Permission.locationAlways.request().isGranted == false) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }
}