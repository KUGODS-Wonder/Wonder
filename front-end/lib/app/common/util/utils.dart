import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/common/util/exports.dart';
import 'package:wonder_flutter/app/common/values/styles/app_medal_style.dart';
import 'package:wonder_flutter/app/data/models/adapter_models/profile_model.dart';
import 'package:wonder_flutter/app/modules/widgets/custom_inkwell_widget.dart';
import 'package:wonder_flutter/app/modules/widgets/custom_text_button.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

abstract class Utils {

  static DateFormat defaultDateFormatter = DateFormat('yyyy-MM-dd');

  static void showDialog(
    String? message, {
    String? title,
    bool success = false,
    VoidCallback? onTap,
    bool barrierDismissible = true,
  }) =>
      Get.dialog(
        AlertDialog(
          title: title != null ? Text(
            success ? Strings.success : title,
            textAlign: TextAlign.center,
            style: AppTextStyle.semiBoldStyle.copyWith(
              color: Colors.black,
              fontSize: Dimens.fontSize18,
            ),
          ) : const SizedBox.shrink(),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message ?? Strings.somethingWentWrong,
                textAlign: TextAlign.center,
                maxLines: 6,
                style: AppTextStyle.mediumStyle.copyWith(
                  color: AppColors.darkGrey,
                  fontSize: Dimens.fontSize16,
                ),
              ),
            ],
          ),
          actions: [
            CustomInkwellWidget.text(
              onTap: () {
                Get.back();

                onTap?.call();
              },
              title: Strings.ok,
              textStyle: AppTextStyle.buttonTextStyle.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: Dimens.fontSize16,
              ),
            ),
          ],
        ),
        barrierDismissible: barrierDismissible,
      );

  static void showIconDialog(
    String title,
    String message, {
    Widget? imageWidget,
    VoidCallback? onTap,
  }) =>
      Get.dialog(
        AlertDialog(
          title:
              imageWidget ?? const Icon(Icons.done), //add your icon/image here
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyle.semiBoldStyle.copyWith(
                  color: Colors.black,
                  fontSize: Dimens.fontSize24,
                ),
              ),
              SizedBox(height: 10.w),
              Text(message,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.regularStyle.copyWith(
                    color: AppColors.darkGrey,
                    fontSize: Dimens.fontSize16,
                  )),
              SizedBox(height: 20.w),
              CustomTextButton(
                title: Strings.ok,
                onPressed: () {
                  Get.back();

                  onTap?.call();
                },
              ),
            ],
          ),
        ),
        barrierDismissible: false,
      );

  static void showMedalDialog(Medal medal) {
    var medalStyle = AppMedalStyle.getStyle(medal.title);
    Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.symmetric(
          horizontal: Constants.defaultHorizontalPadding,
          vertical: 24.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundColor: AppColors.extraLightGrey,
                child: Image.asset(
                  medalStyle.imagePath,
                  width: 50.0,
                  height: 50.0,
                ),
              ),
              const SizedBox(width: 5.0),
              Expanded(
                child: SizedBox(
                  height: 100.0,
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            medal.title,
                            style: AppTextStyle.semiBoldStyle.copyWith(
                              color: Colors.black,
                              fontSize: Dimens.fontSize14,
                            ),
                          ),
                          Text(medal.comments == null ? '' : '"${medal.comments}"',
                              style: AppTextStyle.lightStyle.copyWith(
                                color: AppColors.middleGrey,
                                fontSize: Dimens.fontSize10,
                                fontStyle: FontStyle.italic,
                              )
                          ),
                        ],
                      ),
                      Center(
                        child: Text(medal.description,
                            style: AppTextStyle.lightStyle.copyWith(
                              color: AppColors.darkGrey,
                              fontSize: Dimens.fontSize10,
                            )
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text('${defaultDateFormatter.format(medal.date)} 획득',
                            style: AppTextStyle.mediumStyle.copyWith(
                              color: AppColors.darkGrey,
                              fontSize: Dimens.fontSize10,
                            )
                        ),
                      )
                    ],
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  static showChoiceDialog(String? message, {
  String title = Strings.error,
  bool barrierDismissible = true,
  required void Function() onConfirm}) {
    return Get.defaultDialog(
      barrierDismissible: barrierDismissible,
      onWillPop: () async {
        Get.back(result: false);
        return true;
      },
      title: title,
      content: Text(
        message ?? Strings.somethingWentWrong,
        textAlign: TextAlign.center,
        maxLines: 6,
        style: AppTextStyle.mediumStyle.copyWith(
          color: AppColors.darkGrey,
          fontSize: Dimens.fontSize16,
        ),
      ),
      confirm: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomInkwellWidget.text(
              title: Strings.cancel,
              textStyle: AppTextStyle.buttonTextStyle.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: Dimens.fontSize16,
              ),
              onTap: () {
                Get.back(result: false);
              },
            ),
            CustomInkwellWidget.text(
              title: Strings.ok,
              textStyle: AppTextStyle.buttonTextStyle.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: Dimens.fontSize16,
              ),
              onTap: () {
                onConfirm();
                Get.back(result: true);
              },
            ),
          ],
        ),
      ),
    );
  }

  static void timePicker(
    Function(String time) onSelectTime, {
    TimeOfDay? initialTime,
  }) {
    showTimePicker(
      context: Get.overlayContext!,
      initialTime: initialTime ??
          TimeOfDay.fromDateTime(
            DateTime.now(),
          ),
    ).then((v) {
      if (v != null) {
        final _now = DateTime.now();
        final _dateTime = DateTime(
          _now.year,
          _now.month,
          _now.day,
          v.hour,
          v.minute,
        );

        onSelectTime(_dateTime.formattedDate(dateFormat: 'hh:mm aa'));
      }
    });
  }

  static String getRandomString(
    int length, {
    bool isNumber = true,
  }) {
    final _chars = isNumber ? '1234567890' : 'abcdefghijklmnopqrstuvwxyz';
    final _rnd = Random();

    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => _chars.codeUnitAt(
          _rnd.nextInt(
            _chars.length,
          ),
        ),
      ),
    );
  }

  static void loadingDialog() {
    closeDialog();

    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      name: 'loadingDialog',
    );
  }

  static void closeDialog() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }

  static void closeSnackbar() {
    if (Get.isSnackbarOpen == true) {
      Get.back();
    }
  }

  static void showSnackbar(String? message) {
    closeSnackbar();

    Get.rawSnackbar(message: message);
  }

  static void closeKeyboard() {
    final currentFocus = Get.focusScope!;
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static void goBackToScreen(String routeName) {
    Get.until(
      (route) => route.settings.name == routeName,
    );
  }

  static Future<void> showImagePicker({
    required Function(File image) onGetImage,
  }) {
    return showModalBottomSheet<void>(
      context: Get.context!,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.all(10.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    getImage(source: 2).then((v) {
                      if (v != null) {
                        onGetImage(v);
                        Get.back();
                      }
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.image,
                        size: 60.w,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        Strings.gallery,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.semiBoldStyle.copyWith(
                          color: AppColors.darkGrey,
                          fontSize: Dimens.fontSize16,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    getImage().then((v) {
                      if (v != null) {
                        onGetImage(v);
                        Get.back();
                      }
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.camera,
                        size: 60.w,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        Strings.camera,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.semiBoldStyle.copyWith(
                          color: AppColors.darkGrey,
                          fontSize: Dimens.fontSize16,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static Future<File?> getImage({int source = 1}) async {
    CroppedFile? croppedFile;
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: source == 1 ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 60,
    );

    if (pickedFile != null) {
      final image = File(pickedFile.path);

      croppedFile = await ImageCropper().cropImage(
        compressQuality: 50,
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarColor: Colors.transparent,
            toolbarWidgetColor: Colors.transparent,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            minimumAspectRatio: 0.1,
            aspectRatioLockDimensionSwapEnabled: true,
          )
        ],
      );
    }

    if (croppedFile == null) {
      return null;
    } else {
      return File(croppedFile.path);
    }
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  static convertHoursToString(int hours) {
    // var date = DateTime.fromMillisecondsSinceEpoch(hours * 3600000);
    //
    // bool hourOverflowFlag = false;
    // if (date.hour < 9) {
    //   hourOverflowFlag = true;
    // }
    // var items = [
    //   {'text': 'year', 'value': date.year - 1970},
    //   {'text': 'month', 'value': date.month - 1},
    //   {'text': 'day', 'value': date.day },
    //   {'text': 'hr', 'value': date.hour },
    // ];
    // var str = '';
    // for (var item in items) {
    //   if (item['value'] != 0) {
    //     str += '${item['value']} ${item['text']}';
    //     if (item['value'] as int > 1) {
    //       str += 's ';
    //     } else {
    //       str += ' ';
    //     }
    //   }
    // }
    //
    // if (str.isEmpty) {
    //   str = '0 hr';
    // }
    //
    // return str;

    return '$hours hr${hours > 0 ? 's' : ''}';
  }

  static String convertDistanceToKm(int meters) {
    var km = meters ~/ 1000;
    var metersLeft = meters % 1000;
    String str;
    if (km == 0) {
      str = '${metersLeft}m';
    } else {
      str = '$km.${metersLeft ~/ 100}km';
    }

    return str;
  }
}
